resource "aws_vpc" "private_cloud" {
  cidr_block = var.vpc_cidr
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.private_cloud.id
}

resource "aws_route_table" "r" {
  vpc_id = aws_vpc.private_cloud.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_main_route_table_association" "a" {
  vpc_id = aws_vpc.private_cloud.id
  route_table_id = aws_route_table.r.id
}


resource "aws_subnet" "private_network" {
  vpc_id = aws_vpc.private_cloud.id
  cidr_block = var.private_network_cidr

  map_public_ip_on_launch = true

  tags = "${merge(
	local.default_tags,
	map(
	  "name", "${var.name_prefix}-private_network"
	)
  )}"
}


resource "aws_route_table_association" "private_network_rt_a" {
		subnet_id = aws_subnet.private_network.id
		route_table_id = aws_route_table.r.id
}



