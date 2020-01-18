# variable "aws_ec2_ami" {
#   description = "ami"
# }

variable "aws_instance_type" {
  description = "instance type"
  default     = "t3.medium"
}

# variable "aws_availability_zone" {
#   description = "availability zone"
# }

variable "aws_volume_size_gitlab" {
  description = "ec2 volume size for gitlab"
}

variable "aws_volume_size_runner" {
  description = "ec2 volume size for runner"
}

variable "aws_instance_name_gitlab" {
  description = "instance name for gitlab"
}

variable "aws_instance_name_runner" {
  description = "instance name for runner"
}

variable "aws_iam_instance_profile" {
  description = "instance profile name"
}

variable "aws_security_group_ids_gitlab" {
  description = "security group ids for gitlab"
  type        = list(string)
}

variable "aws_security_group_ids_runner" {
  description = "security group ids for runner"
  type        = list(string)
}

variable "aws_subnet_id" {
  description = "subnet id"
}

variable "aws_user_data_template" {
  description = "init user data"
}

variable "aws_key_name" {
  description = "key name"
}

