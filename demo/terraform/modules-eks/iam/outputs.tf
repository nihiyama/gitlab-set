output "eks_master_name" {
  value = aws_iam_role.eks_master.name
}

output "eks_master_arn" {
  value = aws_iam_role.eks_master.arn
}

output "eks_worker_name" {
  value = aws_iam_role.eks_worker.arn
}

output "eks_worker_arn" {
  value = aws_iam_role.eks_worker.arn
} 
