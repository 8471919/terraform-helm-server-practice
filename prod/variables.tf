variable "region" {
  description = "aws region"
  type = string
  default = "ap-northeast-2"
}

variable "project_name" {
  description = "Project Name"
  type = string
}

variable "environment_name" {
  description = "dev | prod | stage | test"
  type = string
}

# VPC variables
variable "vpc_cidr" {
  description = "VPC CIDR"
  type = string
}

variable "azs" {
  description = "Availability Zone List"
  type = list(string)
}

variable "public_cidrs" {
  description = "Public CIDR List of EKS subnet"
  type = list(string)
}

variable "private_cidrs" {
  description = "Private CIDR List of EKS subnet"
  type = list(string)  
}