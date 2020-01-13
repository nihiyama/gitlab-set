# variable "aws_ec2_ami" {
#   description = "ami"
# }

variable "aws_instance_type" {
  description = "instance type"
  default     = "t3.medium"
}

variable "aws_security_group_ids" {
  description = "security group ids"
  type        = list(string)
}

# variable "aws_availability_zone" {
#   description = "availability zone"
# }

variable "aws_volume_size" {
  description = "ec2 volume size"
}

variable "aws_instance_name" {
  description = "instance name"
}

variable "aws_subnet_id" {
  description = "subnet id"
}

variable "aws_user_data_template" {
  description = "init shell script"
}

variable "aws_key_name" {
  description = "key name"
}

