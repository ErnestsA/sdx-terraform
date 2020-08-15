data "aws_ami" "linux_ami_hvm" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = [var.image]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "keypair" {
  key_name = "${var.name_prefix}-key"
  public_key = "${file("${var.ssh_key_file}.pub")}"
}

resource "aws_security_group" "server_fw" {
  vpc_id = aws_vpc.vpc.id
  name = "${var.name_prefix}-server-fw"

  ingress {
    protocol = "tcp"
    from_port = 8080
    to_port = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol = "icmp"
    from_port = -1
    to_port = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Idriss Security Group"
  }
}

# Public Instance(s)

resource "aws_instance" "server" {
  count = var.number
  ami = data.aws_ami.linux_ami_hvm.id
  instance_type = var.flavor
  key_name = aws_key_pair.keypair.key_name
  subnet_id = aws_subnet.public_network.id
  security_groups = [aws_security_group.server_fw.id]

  tags = {
    Name = "Idriss Public Instance"
  }
}

# Private Instance

resource "aws_instance" "private_server" {
  ami = data.aws_ami.linux_ami_hvm.id
  instance_type = var.flavor
  key_name = aws_key_pair.keypair.key_name
  subnet_id = aws_subnet.private_network.id
  security_groups = [aws_security_group.server_fw.id]

  tags = {
    Name = "Idriss Private Instance"
  }
}

