variable "name_prefix" {
  type    = string
  default = "dev"
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


variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "VPC CIDR block"
}

variable "public_cidr" {
  type        = string
  default     = "10.0.12.0/24"
  description = "Public CIDR block"

}

variable "private_cidr" {
  type        = string
  default     = "10.0.24.0/24"
  description = "Private CIDR block"
}
