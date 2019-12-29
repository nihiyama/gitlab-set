resource "aws_iam_user" "gitlab_backup_s3_user" {
  name = var.aws_iam_username
}
