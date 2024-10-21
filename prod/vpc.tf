module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "5.0.0" # vpc module의 버전 설정

    # vpc 이름 설정
    name = "${var.project_name}-${var.environment_name}-vpc"

    # vpc cidr 설정
    cidr = var.vpc_cidr

    # vpc 가용영역 설정
    azs = var.azs

    # subnet cidr 설정
    public_subnets = var.public_cidrs
    private_subnets = var.private_cidrs

    # NAT 게이트웨이 설정. Private subnet의 인스턴스과 바깥과 소통하려면 필요하다.
    enable_nat_gateway = true

    # NAT 게이트 웨이를 1개만 생성 (비쌈. 그리고 굳이 여러개 필요없음)
    single_nat_gateway = true

    # EKS 클러스터가 서브넷을 인식할 수 있도록 다음 태그들이 필요함.
    public_subnet_tags = {
        "kubernetes.io/role/elb" = 1
    }

    private_subnet_tags = {
        "kubernetes.io/role/internal-elb" = 1
    }
}