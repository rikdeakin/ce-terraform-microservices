variable "project_name" {
  description = "The name of the project, used as a prefix to the names of resources"
  type        = string
  default     = "nc_microservices"
}

variable "ami_name" {
  description = "The name of the OS image to use"
  type        = string
  default     = "Jammy Jellyfish"
}

variable "ami_id" {
  description = "The id of the OS image to use"
  type        = string
  default     = "ami-0505148b3591e4c07"
}

variable "ami_key_pair_name" {
  description = "The name of the SSH key to use"
  default     = "aws-ubuntu"
}