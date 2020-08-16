# Internet gataway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "janis-rancans-internet-gataway"
  }
}

# Subnets
# Public Subnet
resource "aws_subnet" "public_subnet" {
  cidr_block              = var.public_cidr
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "janis-rancans-public-subnet"
  }
}

# Private Subnet
resource "aws_subnet" "private_subnet" {
  cidr_block        = var.private_cidr
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "eu-central-1b"

  tags = {
    Name = "janis-rancans-private-subnet"
  }
}

# Routing tables
# Public route table
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "janis-rancans-public-route"
  }
}

# Private route table
resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "janis-rancans-private-route"
  }
}

# Connect Public Subnet to Public Route Table
resource "aws_route_table_association" "public_subnet_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route.id
}

# Connect Private subnet to Private route table
resource "aws_route_table_association" "private_subnet_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route.id
}
