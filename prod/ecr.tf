resource "aws_ecr_repository" "terraform-study-ecr" {
  name = "${var.project_name}-${var.environment_name}-ecr"
  image_tag_mutability = "MUTABLE" # 이미지 태그를 변경 가능하게 설정
  
  image_scanning_configuration {
    scan_on_push = true # 이미지 푸시 시 보안 스캔 자동 수행
  }
  encryption_configuration {
    encryption_type = "AES256" # 기본 암호화 사용
  }
}