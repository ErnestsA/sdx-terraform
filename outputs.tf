output "default_tags" {
  value = "${local.default_tags}"
}

output "vpc_cidr" {
  value = aws_vpc.jkvpc.cidr_block
}

output "subnet_cidr" {
  value = aws_subnet.jksubnet.cidr_block
}

output "private_subnet_cidr" {
  value = aws_subnet.jkprivate_network.cidr_block
}

output "availability_zone" {
  value = aws_subnet.jksubnet.availability_zone
}

output "server_ami" {
  value = data.aws_ami.linux_ami_hvm.id
}

output "server_ips" {
  value = aws_instance.server.*.public_ip
}