output "vpc_id" {
    description = "VPC ID"
    value = module.vpc.vpc_id
}

output "eks_cluster_endpoint" {
    description = "EKS Cluster Endpoint"
    value = module.eks.cluster_endpoint
}

output "eks_cluster_security_group_id" {
    description = "EKS 클러스터의 보안 그룹 ID"
    value = module.eks.cluster_security_group_id
}

output "eks_node_group_role_arn" {
    description = "EKS 노드 그룹에 할당된 IAM 역할 ARN"
  
    value = [for ng in module.eks.eks_managed_node_groups : ng.iam_role_arn]
}

output "ecr_repo_uri" {
    description = "ECR Repository URI"
    value = aws_ecr_repository.terraform-study-ecr.repository_url
}