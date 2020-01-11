resource "aws_eks_cluster" "eks_cluster" {
  name     = var.aws_eks_cluster_name
  role_arn = var.aws_eks_cluster_role_arn
  vpc_config {
    subnet_ids = var.aws_eks_cluster_subnet_ids

  }
}
