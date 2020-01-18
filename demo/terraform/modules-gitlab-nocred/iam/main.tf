resource "aws_s3_bucket_policy" "only_vpce" {
  bucket = var.aws_s3_bucket_id
  policy = data.template_file.bucket_vpce_policy.rendered
}

data "template_file" "bucket_vpce_policy" {
  template = file("${var.aws_bucket_policy_json}")

  vars = {
    bucket_name = var.aws_s3_bucket_name
    vpce        = var.aws_vpc_endpoint
  }
}
