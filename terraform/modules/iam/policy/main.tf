resource "aws_iam_policy" "gitlab_backup_s3_policy" {
  name        = var.aws_iam_policy_name
  path        = var.aws_iam_policy_path
  description = var.aws_iam_policy_description
  policy      = data.template_file.gitlab_backup_s3.rendered
}

data "template_file" "gitlab_backup_s3" {
  template = file("${var.aws_iam_policy_json}")

  vars = {
    bucket_name = "nihiyama_gitlab_backup_bucket"
  }
}
