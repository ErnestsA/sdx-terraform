output "default_tags" {
  value = "${local.default_tags}"
}

output "vpc_cidr" {
  value = aws_vpc.jkvpc.cidr_block
}

output "availability_zone" {
  value = aws_subnet.private_network.availability_zone
}
