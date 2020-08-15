resource "aws_subnet" "public_network" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_network_cidr

  map_public_ip_on_launch = true

  tags = "${merge(
    local.default_tags,
    map(
      "name", "${var.name_prefix}-public_network"
    )
  )}"
}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "ig"
  }
}

resource "aws_route_table" "vpc_public_sn_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
  tags = {
    Name = "vpc_public_sn_rt"
  }
}

resource "aws_route_table_association" "public_sn_rt_a" {
  subnet_id = aws_subnet.public_network.id
  route_table_id = aws_route_table.vpc_public_sn_rt.id
}

# Private Subnet + Route table

resource "aws_subnet" "vpc_private_sn" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_network_cidr
  
# map_public_ip_on_launch = false by default

  tags = {
    Name = "vpc_private_sn"
  }
}


