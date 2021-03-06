variable "aws_vpc_cider_block" {
  description = "vpc cider block"
  default     = "10.0.0.0/16"
}

variable "aws_vpc_name" {
  description = "vpc name"
}

variable "aws_subnets_nums" {
  description = "Number of subnets"
}

variable "aws_subnet_name" {
  description = "subnet_names_header"
}

# variable "aws_availability_zone" {
#   description = "aws enable availability zone"
# }

variable "aws_map_public_ip_is" {
  description = "aws map public ip"
  default     = true
}

variable "aws_internet_gateway_name" {
  description = "aws internet gateway name"
}

variable "aws_route_table_name" {
  description = "aws route table name"
}

variable "aws_security_group_cidr_blocks" {
  description = "aws security group cidr blocks"
  type        = list(string)
}

variable "aws_security_group_name_gitlab" {
  description = "aws security group name for gitlab"
}

variable "aws_security_group_name_swarm" {
  description = "aws security group name for swarm"
}

variable "aws_s3_vpc_endpoint_name" {
  description = "aws vpc endpoint name"
}

# variable "aws_security_group_port" {
#   description = "aws security group port"
# }
