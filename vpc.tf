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
    
    tags = "${merge(
        local.default_tags,
        map(
            "name", "${var.name_prefix}-gateway"
        )
    )}"
}