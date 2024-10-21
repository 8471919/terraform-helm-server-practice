# # 라우팅 테이블 = 어디로 가야할지 알려주는 친구
# resource "aws_route_table" "terraform-ec2-route-table" {
#   vpc_id = module.vpc.vpc_id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.terraform-ec2-igw.id
#   }
# }

# resource "aws_route_table_association" "public_assoc" {
#   subnet_id      = module.vpc.public_subnets[0]  # 퍼블릭 서브넷 ID
#   route_table_id = aws_route_table.terraform-ec2-route-table.id  # 라우팅 테이블 ID
# }