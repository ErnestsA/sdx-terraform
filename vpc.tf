resource "aws_vpc" "jkvpc" {
    cidr_block = var.jk_cidr

    tags = "${merge(
        local.default_tags,
        map(
            "name", "${var.name_prefix}-network"
        )
    )}"
}

resource "aws_internet_gateway" "jkgate" {
    vpc_id = aws_vpc.jkvpc.id
}

resource "aws_subnet" "private_network" {
    vpc_id = aws_vpc.jkvpc.id
    cidr_block = var.private_network_cidr

    map_public_ip_on_launch = true

    tags = "${merge(
        local.default_tags,
        map(
            "name", "${var.name_prefix}-private-_network"
        )
    )}"
}

resource "aws_route_table" "jkroute" {
    vpc_id = aws_vpc.jkvpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.jkgate.id
    }
}

resource "aws_route_table_association" "jk-rt-a" {
    subnet_id = aws_subnet.private_network.id
    route_table_id = aws_route_table.jkroute.id
}