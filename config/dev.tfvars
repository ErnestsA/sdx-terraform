name_prefix = "idriss-dev"

# private network
#vpc_id = "${aws_vpc.vpc.id}"
#rtb_id = "${aws_subnet.private_network.id}"
vpc_cidr_block = "10.0.0.0/16"
private_network_cidr = "10.0.2.0/24"

# server configuration
image = "amzn2-ami-hvm-2.0.20200722.0-x86_64-gp2"
ssh_key_file = "~/.ssh/id_rsa"
number = "0"
flavor = "t2.micro"
