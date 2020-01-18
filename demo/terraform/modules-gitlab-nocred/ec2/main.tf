resource "aws_instance" "gitlab" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.aws_instance_type
  vpc_security_group_ids = var.aws_security_group_ids_gitlab
  key_name               = var.aws_key_name
  subnet_id              = var.aws_subnet_id
  iam_instance_profile   = var.aws_iam_instance_profile
  user_data              = data.template_file.user_data.rendered

  root_block_device {
    volume_type = "gp2"
    volume_size = var.aws_volume_size_gitlab
  }

  tags = {
    Name = var.aws_instance_name_gitlab
  }
}

resource "aws_instance" "runner" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.aws_instance_type
  vpc_security_group_ids = var.aws_security_group_ids_runner
  key_name               = var.aws_key_name
  subnet_id              = var.aws_subnet_id
  iam_instance_profile   = var.aws_iam_instance_profile
  user_data              = data.template_file.user_data.rendered

  root_block_device {
    volume_type = "gp2"
    volume_size = var.aws_volume_size_runner
  }

  tags = {
    Name = var.aws_instance_name_runner
  }
}

# resource "aws_ebs_volume" "vol" {
#   availability_zone = var.aws_availability_zone
#   type              = "gp2"
#   size              = var.aws_volume_size
# }

# resource "aws_volume_attachment" "ebs_att" {
#   device_name = "/dev/xdh"
#   volume_id   = aws_ebs_volume.vol.id
#   instance_id = aws_instance.gitlab.id
# }

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "block-device-mapping.volume-type"
    values = ["gp2"]
  }
}

data "template_file" "user_data" {
  template = file("${var.aws_user_data_template}")
}
