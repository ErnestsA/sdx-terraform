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

resource "aws_security_group" "jk_secure" {
    vpc_id = aws_vpc.jkvpc.id
    name = "${var.name_prefix}-jk-secure"

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

    tags = "${merge(
        local.default_tags,
        map(
            "name", "${var.name_prefix}-jk-secure"
        )
    )}"
}

resource "aws_instance" "server" {
    count = var.number
    ami = data.aws_ami.linux_ami_hvm.id
    instance_type = var.flavor
    key_name = aws_key_pair.keypair.key_name
    subnet_id = aws_subnet.jksubnet.id
    security_groups = [aws_security_group.jk_secure.id]

    tags = "${merge(
        local.default_tags,
        map(
            "name", "${var.name_prefix}-server-${count.index}"
        )
    )}"
}