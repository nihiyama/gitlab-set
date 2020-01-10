resource "aws_iam_role" "eks_master" {
  name               = var.aws_eks_master_role_name
  assume_role_policy = data.template_file.eks_master_assume_role_policy.rendered
}

resource "aws_iam_role_policy_attachment" "eks_cluster" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_master.name
}

resource "aws_iam_role_policy_attachment" "eks_service" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_master.name
}

resource "aws_iam_role" "eks_worker" {
  name               = var.aws_eks_worker_role_name
  assume_role_policy = data.template_file.eks_worker_assume_role_policy.rendered
}

resource "aws_iam_role_policy_attachment" "eks_worker" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_worker.name
}

resource "aws_iam_role_policy_attachment" "eks_cni" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_worker.name
}

resource "aws_iam_role_policy_attachment" "ecr_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_worker.name
}

data "template_file" "eks_master_assume_role_policy" {
  template = file("${var.aws_eks_master_assume_role_policy}")
}

data "template_file" "eks_worker_assume_role_policy" {
  template = file("${var.aws_eks_worker_assume_role_policy}")
}
