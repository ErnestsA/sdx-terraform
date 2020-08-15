variable "name_prefix" {
  type = string
  default = "dev"
}

variable "public_network_cidr" {
  type = string
}

variable "image" {
  type = string
}

variable "ssh_key_file" {
  type = string
}

variable "number" {
  type = string
}

variable "flavor" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "private_network_cidr" {
  type = string
}
