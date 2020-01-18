resource "aws_s3_bucket" "gitlab_backup_bucket" {
  bucket = var.aws_s3_bucket_name

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  force_destroy = true

  lifecycle_rule {
    enabled = true

    expiration {
      days = "3"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "gitlab_backup_bucket" {
  bucket                  = aws_s3_bucket.gitlab_backup_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
