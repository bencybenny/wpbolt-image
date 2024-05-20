variable "proj_name" {
  type = string
}

variable "proj_env" {
  type = string
}

variable "int_type" {
  type = string
}

variable "user" {
  type = string
}

variable "ami" {
  type = string
}

locals {
  image-timestamp = "${formatdate("DD-MM-YYYY-hh-mm", timestamp())}"
  image-name = "${var.proj_name}-${var.proj_env}-${local.image-timestamp}"
}
