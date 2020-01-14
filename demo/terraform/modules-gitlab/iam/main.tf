resource "aws_iam_policy" "gitlab_backup_s3_policy" {
  name        = var.aws_iam_policy_name
  path        = var.aws_iam_policy_path
  description = var.aws_iam_policy_description
  policy      = data.template_file.gitlab_backup_s3.rendered
}

resource "aws_iam_user" "gitlab_backup_s3_user" {
  name = var.aws_iam_username
}

resource "aws_iam_access_key" "gitlab_backup_s3_access_key" {
  user    = aws_iam_user.gitlab_backup_s3_user.id
  pgp_key = data.template_file.pgpkey.rendered
}

resource "aws_iam_policy_attachment" "gitlab_backup_s3" {
  name       = "gitlab_s3_backup"
  users      = [aws_iam_user.gitlab_backup_s3_user.name]
  policy_arn = aws_iam_policy.gitlab_backup_s3_policy.arn
}

data "template_file" "gitlab_backup_s3" {
  template = file("${var.aws_iam_policy_json}")

  vars = {
    bucket_name = var.aws_s3_bucket_name
  }
}

data "template_file" "pgpkey" {
  template = file("${var.aws_iam_pgpkey}")
}
