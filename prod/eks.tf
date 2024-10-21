locals {
  name = "${var.project_name}-${var.environment_name}-eks-cluster"
}

module "eks" {
    source = "terraform-aws-modules/eks/aws"

    version = "~> 20.0" # 모듈 버전 20.0.x의 최신 버전 사용

    iam_role_use_name_prefix = false

    cluster_name = local.name # eks cluster 이름 설정
    cluster_version = "1.30" # eks cluster의 k8s 버전

    # 클러스터 관리자에게 액세스 허용 여부
    enable_cluster_creator_admin_permissions = true
    # 클러스터 인증 모드
    authentication_mode = "API_AND_CONFIG_MAP"

    # 클러스터 엔드포인트 액세스 - VPC 외부에서 클러스터 엔드포인트에 액세스할 수 있는지 여부
    cluster_endpoint_private_access = false
    cluster_endpoint_public_access = true

    # eks cluster의 vpc 설정
    vpc_id = module.vpc.vpc_id

    # node group이 속할 subnet 설정
    subnet_ids = module.vpc.private_subnets

    # cluster의 iam role 설정
    # iam_role_name = aws_iam_role.eks_cluster_role.name

    # 이걸로 설정해도 된다.
    # iam_role_arn = aws_iam_role.eks_cluster_role.arn

    # node group의 security group id 설정
    # node_security_group_id = 

    # Node group 설정
    eks_managed_node_groups = {
        base_node_group = {
            # ami_type = ""
            # iam_role_name = aws_iam_role.eks_node_group_role.name
            iam_role_use_name_prefix = false
            name = "${var.project_name}-${var.environment_name}-node-group"
            instance_types = ["t2.small"]
            min_size = 2
            max_size = 3
            desired_size = 2
        }
    }

    # OIDC 프로바이더 활성화. IAM 역할 기반 서비스 계정(IRSA)를 사용할 수 있도록 설정.
    enable_irsa = true

    # cluster_addons = {
    #     coredns = {}
    #     eks-pod-identity-agent = {}
    #     kube-proxy = {}
    #     vpc-cni = {}
    # }

    # 현재의 caller(사용자)를 eks cluster의 administrator로 추가
    # enable_cluster_creator_admin_permissions = true

    # access_entries = {
        
    # }
}