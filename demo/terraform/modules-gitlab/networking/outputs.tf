output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnet_id" {
  value = element(aws_subnet.sn.*.id, var.aws_subnets_nums)
}

output "availability_zone" {
  value = element(aws_subnet.sn.*.availability_zone, var.aws_subnets_nums)
}

output "gitlab-security_group_id" {
  value = aws_security_group.gitlab-sg.id
}

output "swarm-security_group_id" {
  value = aws_security_group.swarm-sg.id
}

output "s3_vpce_id" {
  value = aws_vpc_endpoint.s3_vpce.id
}
