output "ssh-gitlab" {
  value = "ssh -i ${module.key-pair.private_key_file} ec2-user@${module.ec2.ec2_gitlab_public_dns}"
}

output "ssh-runner" {
  value = "ssh -i ${module.key-pair.private_key_file} ec2-user@${module.ec2.ec2_runner_public_dns}"
}

output "id" {
  value = module.iam_gitlab_backup_s3.id
}
output "secret" {
  value = module.iam_gitlab_backup_s3.secret
}
