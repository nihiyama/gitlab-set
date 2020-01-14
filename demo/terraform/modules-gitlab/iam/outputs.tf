output "policy-name" {
  value = aws_iam_policy.gitlab_backup_s3_policy.name
}

output "arn" {
  value = aws_iam_policy.gitlab_backup_s3_policy.arn
}

output "user-name" {
  value = aws_iam_user.gitlab_backup_s3_user.name
}

output "id" {
  value = aws_iam_access_key.gitlab_backup_s3_access_key.id
}

output "secret" {
  value = aws_iam_access_key.gitlab_backup_s3_access_key.encrypted_secret
}
