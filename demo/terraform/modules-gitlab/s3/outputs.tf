output "name" {
  value = aws_s3_bucket.gitlab_backup_bucket.bucket
}

output "id" {
  value = aws_s3_bucket.gitlab_backup_bucket.id
}
