resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc_cidr_block}"

  tags = "${merge(
    local.default_tags,
    map(
      "name", "${var.name_prefix}-vpc"
    )
  )}"
}
