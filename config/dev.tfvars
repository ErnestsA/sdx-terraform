name_prefix = "idriss-dev"

vpc_cidr_block = "10.0.0.0/16"
public_network_cidr = "10.0.2.0/24"
private_network_cidr = "10.0.3.0/24"


# server configuration
image = "amzn2-ami-hvm-2.0.20200722.0-x86_64-gp2"
ssh_key_file = "~/.ssh/id_rsa"
number = "1"
flavor = "t2.micro"
