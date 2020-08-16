resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "Umar"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.1.0/24"

  map_public_ip_on_launch = true

  tags = "${merge(
    local.default_tags,
    map(
      "name", "${var.name_prefix}-private_network"
    )
  )}"
}

resource "aws_subnet" "private-subnet" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.64.29/24"

  map_public_ip_on_launch = false

  tags = "${merge(
    local.default_tags,
    map(
      "name", "${var.name_prefix}-private_network"
    )
  )}"
}

resource "aws_route_table" "routing1" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
    Name = "Umar no.1"
  }
}

resource "aws_route_table" "routing2" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "Umar no.2"
  }
}

resource "aws_route_table_association" "MohammadUmar1" {
  subnet_id      = "${aws_subnet.public-subnet.id}"
  route_table_id = "${aws_route_table.routing1.id}"
}

resource "aws_route_table_association" "MohammadUmar2" {
  subnet_id      = "${aws_subnet.private-subnet.id}"
  route_table_id = "${aws_route_table.routing2.id}"
}

resource "aws_security_group" "server_fw" {
  vpc_id = "${aws_vpc.main.id}"
  name   = "${var.name_prefix}-server-fw"

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
