data "aws_ami" "linux_ami_hvm" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = [var.image]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "keypair" {
  key_name   = "${var.name_prefix}-key"
  public_key = "${file("${var.ssh_key_file}.pub")}"
}


resource "aws_instance" "server" {
  count           = var.number
  ami             = data.aws_ami.linux_ami_hvm.id
  instance_type   = var.flavor
  key_name        = aws_key_pair.keypair.key_name
  subnet_id       = "${aws_subnet.public_subnet.id}"
  security_groups = [aws_security_group.server_fw.id]

  tags = {
    Name = "janis-rancans-aws-instance-in-public-subnet"
  }
}
