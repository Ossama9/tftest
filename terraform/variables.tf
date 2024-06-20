variable "aws_region" {
  description = "The AWS region to deploy resources into"
  type        = string
  default     = "eu-west-3"
}

variable "instance_type" {
  description = "The type of instance to use"
  type        = string
  default     = "t2.micro"
}


variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}


variable "public_key_path" {
  description = "SSH public key to use for the EC2 key pair"
  type        = string
}

variable "private_key_path" {
  description = "Path to the private SSH key"
  type        = string
}

variable "ssh_user" {
  description = "SSH user to access EC2 instance"
  type        = string
  default     = "admin"
}

variable "key_name" {
  description = "The name of the AWS key pair to be used with the EC2 instance"
  type        = string
    default     = "aws-ssh-key"
}

variable "tags" {
  description = "A map of tags to add to the EC2 instance"
  type        = map(string)
  default     = {}
}
