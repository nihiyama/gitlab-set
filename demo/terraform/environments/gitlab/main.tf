provider "aws" {
  region = "ap-northeast-1"
}

module "networking" {
  source                         = "../../modules-gitlab/networking/"
  aws_vpc_cider_block            = "10.10.0.0/16"
  aws_vpc_name                   = "gitlab_vpc"
  aws_subnets_nums               = 1
  aws_subnet_name                = "gitlab_public_subnet"
  aws_map_public_ip_is           = true
  aws_internet_gateway_name      = "gitlab_igw"
  aws_route_table_name           = "gitlab_rtb"
  aws_security_group_cidr_blocks = ["*********"]
  aws_security_group_name        = "gitlab_sg"
}

module "s3_gitlab_backup_bucket" {
  source             = "../../modules-gitlab/s3/"
  aws_s3_bucket_name = "nihiyama-gitlab-buckup-bucket"
}

module "iam_gitlab_backup_s3" {
  source                     = "../../modules-gitlab/iam/"
  aws_iam_policy_name        = "gitlab_backup_s3_policy"
  aws_iam_policy_path        = "/policy/"
  aws_iam_policy_description = "gitlab backup s3 policy"
  aws_iam_policy_json        = "./policy/gitlab_backup_s3_policy.json.tpl"
  aws_iam_username           = "gitlab_backup_s3_user"
  aws_iam_pgpkey             = "./credentials/gitlab.public.gpg.base64"
  aws_s3_bucket_name         = module.s3_gitlab_backup_bucket.name
}

module "key-pair" {
  source            = "../../modules-gitlab/key-pair/"
  aws_key_name      = "gitlab_key_pair"
  aws_key_file_path = "./credentials/"
}

module "ec2" {
  source                 = "../../modules-gitlab/ec2/"
  aws_instance_name      = "gitlab"
  aws_instance_type      = "t3.medium"
  aws_security_group_ids = [module.networking.security_group_id]
  aws_subnet_id          = module.networking.subnet_id
  aws_volume_size        = 30
  # aws_availability_zone  = module.networking.availability_zone
  aws_key_name           = module.key-pair.key_name
  aws_user_data_template = "./user_data/cloud-config.yml.tpl"
}
