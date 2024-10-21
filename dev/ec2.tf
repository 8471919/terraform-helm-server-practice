locals {
  count = 2
}

resource "aws_instance" "ec2_instance" {
  ami = "ami-05d2438ca66594916"
  instance_type = "${var.ec2_instance_spec}"

  count = local.count # count 개수만큼 리소스 생성. 즉, ec2 인스턴스가 2개 생성

  subnet_id = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.terraform-ec2-sg.id]

  associate_public_ip_address = true

  user_data = <<-EOF
      #!/bin/bash
      sudo apt update -y
      sudo apt upgrade -y
      sudo apt install apache2 -y

      INSTANCE_NAME="${var.instance_name}'s server ${count.index}"
      echo "<html><body><h1>$INSTANCE_NAME</h1></body></html>" | sudo tee /var/www/html/index.html

      sudo systemctl start apache2
      sudo systemctl enable apache2
    EOF

  tags = {
    Name = "${var.instance_name}'s server ${count.index}" # count.index는 인스턴스를 2개 생성하므로 설정해둔 것
  }
}

resource "aws_iam_user" "for_each_set" {
  for_each = toset(var.user_names) # for_each가 반복문.
  name = each.key
}