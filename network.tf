resource "aws_subnet" "public_network" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_network_cidr

  map_public_ip_on_launch = true

  tags = {
    Name = "Idriss Public Subnet"
  }
}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "Idriss Internet Gateway"
  }
}

resource "aws_route_table" "vpc_public_sn_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
  tags = {
    Name = "Idriss Public Subnet Route Table"
  }
}

resource "aws_route_table_association" "public_sn_rt_a" {
  subnet_id = aws_subnet.public_network.id
  route_table_id = aws_route_table.vpc_public_sn_rt.id
}

# Private Subnet + Route table

resource "aws_subnet" "private_network" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_network_cidr
  
# map_public_ip_on_launch = false by default

  tags = {
    Name = "Idriss Private Subnet"
  }
}

resource "aws_route_table" "vpc_private_sn_rt" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "Idriss Private Subnet Route Table"
  }
}
