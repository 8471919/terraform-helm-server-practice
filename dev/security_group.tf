resource "aws_security_group" "terraform-ec2-sg" {
  vpc_id = module.vpc.vpc_id
  name = "${var.project_name}-${var.target_label}-sg"
  description = "EC2 Security Group"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group_rule" "terraform-ec2-sg-i" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.terraform-ec2-sg.id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "terraform-ec2-ssh-i" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.terraform-ec2-sg.id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "terraform-ec2-icmp-i" {
  type = "ingress"
  from_port = -1
  to_port = -1
  protocol = "icmp" # ping 쓸 때 사용하는 프로토콜
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.terraform-ec2-sg.id

  lifecycle {
    create_before_destroy = true
  }
}

variable "ports" {
  description = "List of ports for ingress"
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    description = string
  }))
  default = [
    { from_port = 80, to_port = 80, protocol = "tcp", description = "HTTP" },
    { from_port = 443, to_port = 443, protocol = "tcp", description = "HTTPS" },
    { from_port = 465, to_port = 465, protocol = "tcp", description = "SSL" }
  ]
}
