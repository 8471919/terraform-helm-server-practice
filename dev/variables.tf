variable "region" {
  description = "aws region"
  type = string
  default = "ap-northeast-2"
}

variable "project_name" {
  description = "project name"
  type = string
  default = null
}

variable "target_label" {
  description = "dev/stage/prod"
  type = string
  default = null
}

variable "vpc_cidr" {
  description = "VPC CIDR Range"
  type = string
  default = null
}

variable "azs" {
    description = "A list of availability zones names or ids in the region"
    type = list(string)
    default = ["ap-northeast-2a"]
  
}

variable "public_cidr" {
  description = "Public Subnet CIDR"
  type = list(string)
  default = null
}

variable "ec2_instance_spec" {
  description = "EC2 Spec Information"
  type = string
  default = null
}

variable "instance_name" {
  description = "ec2 name"
  type = string
  default = "Hansu_Jeong_ec2"
}

variable "user_names" {
  description = "Create IAM users with names"
  type = list(string)
  default = ["hansu-aaa", "hansu-bbb", "hansu-ccc"]
  validation {
    # all은 리스트의 모든 요소를 iteration할 때 사용
    # 반복되는 각 요소를 참조하기 위해서는 _를 사용해야한다.
    condition = alltrue([for user_name in var.user_names : length(user_name) >= 5 
      && substr(user_name, 0, 5) == "hansu"])
    error_message = "유저 이름의 길이가 5이상이고 \"hansu\"로 시작해야합니다."
  }
}