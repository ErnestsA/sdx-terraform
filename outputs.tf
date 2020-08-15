output "default_tags" {
  value = "${local.default_tags}"
}

output "vpc_cidr" {
  value = aws_vpc.private_cloud.cidr_block
}

output "availability_zone" {
  value = aws_subnet.private_network.availability_zone
}

output "server_ami" {
  value = data.aws_ami.linux_ami_hvm.id

}

output "server_ips" {
  value = aws_instance.server.*.public_ip
}


