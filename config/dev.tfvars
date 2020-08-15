name_prefix = "janis-kulless"

## Network
vpc_id = "vpc-044f1da22a48711df"
rtb_id = "rtb-063d216f5d52a9c20"

jk_cidr = "10.1.0.0/16"
jk_subnet_cidr = "10.1.1.0/24"
jk_private_cidr = "10.1.2.0/24"

## Server configuration
image = "amzn2-ami-hvm-2.0.20200722.0-x86_64-gp2"
ssh_key_file = "~/.ssh/id_rsa"
number = "1"
flavor = "t2.micro"