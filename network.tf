#data "aws_vpc" "private_cloud" {
#    id = var.vpc_id
#}

#data "aws_route_table" "rtb" {
#    route_table_id = var.rtb_id
#}

#resource "aws_route_table_association" "private_network_rt_a" {
#    subnet_id = aws_subnet.private_network.id
#    route_table_id = data.aws_route_table.rtb.id
#}