#data "aws_vpc" "private_cloud" {
#    id = var.vpc_id
#}

resource "aws_subnet" "jksubnet" {
    vpc_id = aws_vpc.jkvpc.id
    cidr_block = var.jk_subnet_cidr

    map_public_ip_on_launch = true

    tags = "${merge(
        local.default_tags,
        map(
            "name", "${var.name_prefix}-open-_network"
        )
    )}"
}

resource "aws_subnet" "jkprivate_network"{
    vpc_id = aws_vpc.jkvpc.id
    cidr_block = var.jk_private_cidr

    tags = "${merge(
        local.default_tags,
        map(
            "name", "${var.name_prefix}-private-_network"
        )
    )}"
}

resource "aws_route_table" "jkroute" {
    vpc_id = aws_vpc.jkvpc.id
    tags = "${merge(
        local.default_tags,
        map(
            "name", "${var.name_prefix}-route-table"
        )
    )}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.jkgate.id
    }
}

resource "aws_route_table" "jkprivate" {
    vpc_id = aws_vpc.jkvpc.id
    tags = "${merge(
        local.default_tags,
        map(
            "name", "${var.name_prefix}-private-route-table"
        )

    )}"
}

resource "aws_route_table_association" "jk-rt-a" {
    subnet_id = aws_subnet.jksubnet.id
    route_table_id = aws_route_table.jkroute.id
}

resource "aws_route_table_association" "jk-prt-a" {
    subnet_id = aws_subnet.jkprivate_network.id
    route_table_id = aws_route_table.jkprivate.id
}