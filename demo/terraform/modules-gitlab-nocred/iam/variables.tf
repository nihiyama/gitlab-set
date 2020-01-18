variable "aws_s3_bucket_name" {
  description = "S3 bucket name"
}

variable "aws_ec2_assume_role_policy_json" {
  description = "ec2 asuume role policy json"
}

variable "aws_ec2_iam_role_name" {
  description = "ec2 iam role name"
}

variable "aws_iam_instance_profile" {
  description = "instance profile name"
}

variable "aws_s3_access_iam_policy_json" {
  description = "s3 access policy"
}

variable "aws_s3_access_iam_policy_name" {
  description = "s3 access policy name"
}

variable "aws_vpc_endpoint" {
  description = "S3 endpoint"
}

variable "aws_s3_bucket_id" {
  description = "bucket id"
}

variable "aws_bucket_policy_json" {
  description = "bucket policy json"
}
