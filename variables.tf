variable "name_prefix" {
  type = string
  default = "dev"
}

variable "vpc_id" {
  type = string
}

variable "rtb_id" {
  type = string
}

variable "jk_cidr" {
  type = string
}

variable "jk_subnet_cidr" {
  type = string
}

variable "jk_private_cidr" {
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