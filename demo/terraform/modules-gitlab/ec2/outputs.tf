output "ec2_id" {
  value = aws_instance.gitlab.id
}

output "ec2_public_dns" {
  value = aws_instance.gitlab.public_dns
}
