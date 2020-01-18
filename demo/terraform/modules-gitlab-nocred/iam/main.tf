resource "aws_iam_policy" "s3_access" {
  name = var.aws_s3_access_iam_policy_name
  policy = data.template_file.s3_access_policy.rendered
}

resource "aws_iam_role" "ec2_access_to_s3_role" {
  name = var.aws_ec2_iam_role_name
  assume_role_policy = data.template_file.ec2_assume_role.rendered
}

resource "aws_iam_role_policy_attachment" "ec2_access_to_s3_att" {
  role = aws_iam_role.ec2_access_to_s3_role.name
  policy_arn = aws_iam_policy.s3_access.arn
}

resource "aws_s3_bucket_policy" "only_vpce" {
  bucket = var.aws_s3_bucket_id
  policy = data.template_file.bucket_vpce_policy.rendered
}

data "template_file" "s3_access_policy" {
  template = file("${var.aws_bucket_policy_json}")

  vars = {
    bucket_name = var.aws_s3_bucket_name
  }
}

data "template_file" "ec2_assume_role" {
  template = file("${var.aws_ec2_assume_role_policy_json}")
}

data "template_file" "bucket_vpce_policy" {
  template = file("${var.aws_bucket_policy_json}")

  vars = {
    bucket_name = var.aws_s3_bucket_name
    vpce        = var.aws_vpc_endpoint
  }
}
