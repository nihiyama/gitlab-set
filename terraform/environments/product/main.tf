provider "aws" {
  region = "ap-northeast-1"
}

module "s3_gitlab_backup_bucket" {
  source             = "../../modules/s3/"
  aws_s3_bucket_name = "nihiyama-gitlab-buckup-bucket"
}

module "iam_gitlab_backup_s3_user" {
  source           = "../../modules/iam/user/"
  aws_iam_username = "gitlab_backup_s3_user"
  aws_iam_pgpkey   = "*****************"
}

module "iam_gitlab_backup_s3_policy" {
  source                     = "../../modules/iam/policy/"
  aws_iam_policy_name        = "gitlab_backup_s3_policy"
  aws_iam_policy_path        = "/policy/"
  aws_iam_policy_description = "gitlab backup s3 policy"
  aws_iam_policy_json        = "./jsons/gitlab_backup_s3_policy.json.tpl"
  aws_s3_bucket_name         = "nihiyama-gitlab-buckup-bucket"
}

resource "aws_iam_policy_attachment" "gitlab_backup_s3" {
  name       = "gitlab_s3_backup"
  users      = [module.iam_gitlab_backup_s3_user.name]
  policy_arn = module.iam_gitlab_backup_s3_policy.arn
}
