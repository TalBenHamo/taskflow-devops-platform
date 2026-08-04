variable "aws_region" {
  description = "AWS region used for TaskFlow infrastructure"
  type        = string
  default     = "us-east-2"
}

variable "project_name" {
  description = "Project name used for resource naming and tags"
  type        = string
  default     = "taskflow"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}



variable "public_key_path" {
  description = "Path to the public SSH key used for EC2 access"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ssh_allowed_cidr" {
  description = "Public IP address allowed to connect over SSH"
  type        = string
}
