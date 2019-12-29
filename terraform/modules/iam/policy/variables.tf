variable "aws_iam_policy_name" {
  description = "iam policy name"
}

variable "aws_iam_policy_path" {
  description = "iam policy path"
  default     = "/policy/"
}

variable "aws_iam_policy_description" {
  description = "iam policy description"
  default     = "iam policy"
}

variable "aws_iam_policy_json" {
  description = "iam policy json filename"
  default     = "iam_policy.json"
}

variable "aws_s3_bucket_name" {
  description = "S3 bucket name"
}
