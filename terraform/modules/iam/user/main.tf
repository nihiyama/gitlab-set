resource "aws_iam_user" "gitlab_backup_s3_user" {
  name = var.aws_iam_username
}

resource "aws_iam_access_key" "gitlab_backup_s3_access_key" {
  user    = aws_iam_user.gitlab_backup_s3_user.id
  pgp_key = var.aws_iam_pgpkey
}
