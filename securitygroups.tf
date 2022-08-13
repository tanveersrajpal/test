terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "aws_security_group" "public-security-group-LB" {
  name        = "public-security-group-lb"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc-main.id

  ingress {
    description = "TLS from VPC"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "allow_tls_through_ALB"
  }
}

resource "aws_security_group" "private-security-group-ASG" {
  name        = "private-security-group-asg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc-main.id

  ingress {
    description = "TLS from VPC"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    security_groups = [
      "${aws_security_group.public-security-group-LB.id}"
    ]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["139.180.108.110/32"] #Change this to your IP
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "Allow_Communication_from_ALB_Security_Group"
  }
}
