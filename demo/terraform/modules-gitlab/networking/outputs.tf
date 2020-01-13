output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnet_id" {
  value = element(aws_subnet.sn.*.id, var.aws_subnets_nums)
}

output "availability_zone" {
  value = element(aws_subnet.sn.*.availability_zone, var.aws_subnets_nums)
}

output "security_group_id" {
  value = aws_security_group.sg.id
}
