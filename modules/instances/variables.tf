variable "vpc_id" {
  description = "ID of the VPC to use"
  type        = string
}

variable "instance_count" {
  description = "The nnumber of EC2 instances to spin up"
  type        = number
  default     = 4
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}

variable "associate_public_ip_address" {
  type = list(bool)
}

variable "instance_names" {
  type = list(string)
}

variable "ami_name" {
  description = "The name of the OS image to use"
  type        = string
  default     = "Jammy Jellyfish"
}

variable "ami_id" {
  description = "The id of the OS image to use"
  type        = string
  default     = "ami-08e4526a271956ce2"
}

variable "ami_key_pair_name" {
  description = "The name of the SSH key to use"
  default     = "rik"
}
