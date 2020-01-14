output "ec2_gitlab_id" {
  value = aws_instance.gitlab.id
}

output "ec2_runner_id" {
  value = aws_instance.runner.id
}

output "ec2_gitlab_public_dns" {
  value = aws_instance.gitlab.public_dns
}

output "ec2_runner_public_dns" {
  value = aws_instance.runner.public_dns
}
