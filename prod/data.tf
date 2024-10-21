# # 모든 노드 그룹의 IAM Role ARN 가져오기
# locals {
#   node_group_roles = [for ng in module.eks.eks_managed_node_groups : ng.iam_role_name]
# }

# # eks cluster iam role
# data "aws_iam_role" "eks_iam_role" {
#   name = module.eks.cluster_iam_role_name
# }

# # eks node group iam role
# data "aws_iam_role" "eks_node_group_iam_role" {
#   count = length(local.node_group_roles)

#   name = local.node_group_roles[count.index]
# }