resource "tls_private_key" "keygen" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  filename = local.private_key_file
  content  = tls_private_key.keygen.private_key_pem

  provisioner "local-exec" {
    command = "chmod 600 ${local.private_key_file}"
  }
}

resource "local_file" "public_key" {
  filename = local.public_key_file
  content  = tls_private_key.keygen.public_key_openssh

  provisioner "local-exec" {
    command = "chmod 600 ${local.public_key_file}"
  }
}

resource "aws_key_pair" "key_pair" {
  key_name   = var.aws_key_name
  public_key = tls_private_key.keygen.public_key_openssh
}

locals {
  public_key_file  = "${var.aws_key_file_path}${var.aws_key_name}.id_rsa.pub"
  private_key_file = "${var.aws_key_file_path}${var.aws_key_name}.id_rsa"
}
