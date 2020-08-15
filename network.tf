# Availibility zones
data "aws_availability_zones" "available" {}

# VPC
resource "aws_vpc" "main_vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "janis-rancans-vpc"
  }
}

# Internet gataway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  tags = {
    Name = "janis-rancans-internet-gataway"
  }
}

# Subnets
# Public Subnet
resource "aws_subnet" "public_subnet" {
  cidr_block              = "${var.public_cidr}"
  vpc_id                  = "${aws_vpc.main_vpc.id}"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "janis-rancans-public-subnet"
  }
}

# Private Subnet
resource "aws_subnet" "private_subnet" {
  cidr_block        = "${var.private_cidr}"
  vpc_id            = "${aws_vpc.main_vpc.id}"
  availability_zone = "eu-central-1b"

  tags = {
    Name = "janis-rancans-private-subnet"
  }
}

# Routing tables
# Public route table
resource "aws_route_table" "public_route" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
    Name = "janis-rancans-public-route"
  }
}

# Private route table
resource "aws_route_table" "private_route" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  tags = {
    Name = "janis-rancans-private-route"
  }
}

# Connect Public Subnet to Public Route Table
resource "aws_route_table_association" "public_subnet_assoc" {
  subnet_id      = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_route_table.public_route.id}"
}

# Connect Private subnet to Private route table
resource "aws_route_table_association" "private_subnet_assoc" {
  subnet_id      = "${aws_subnet.private_subnet.id}"
  route_table_id = "${aws_route_table.private_route.id}"
}


# Security group
resource "aws_security_group" "server_fw" {
  vpc_id = "${aws_vpc.main_vpc.id}"
  name   = "Main security group"

  ingress {
    protocol    = "tcp"
    from_port   = 8080
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "icmp"
    from_port   = -1
    to_port     = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(
    local.default_tags,
    map(
      "name", "${var.name_prefix}-server_fw"
    )
  )}"
}
