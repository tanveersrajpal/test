#---------------------------------------------------
#VAR - aws_launch_configuration
variable "ec2_image_id" {
  type    = string
  default = "ami-0a5d07e2b337abadb"
}
variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"
}
variable "ec2_keypair_name" {
  type    = string
  default = "strikingimpact"
}
variable "ec2_keypair_public_data" {
  type = string
  #Change Key below
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDE8rDX3NSE7pHLxLXyA+ffVcK2qIMrQvs0lDbINcONOtq0wVo7WBAwWOF4idXkFwWj2dwAv4z1gQsEzYfKQe0PSncVn0y0wNPxP1dwDtF3iAop++SId2WvR/afuR/uL4tLWkHBebiRovC4laPG4Q1JhBHCoYhwgoqPrwtTh+yX/5qDLP2bTLZQcq728G6jKguFCnZV8mBexLtoJm/qv8Y2jS5zxQvqjI09VnPaFiVn1JtucnwREurrxDj3B7Oq3GzVBWdDP1eYmmYA+K9fIpf+C9517+n7Jc4blT/uC9zKMEpsDBYFjRSGEetQWZr3gYY/LGbhj8xNQf2hIY1HPWmwWewd5N4OM67M34ev8lXRRDJbVdwHClos2f1hVhxifIjvsM5SqrSsKtD+JbUw4aqgZdZ2WESGKtsieKOZ+gh6q73B7HOoqh89Jv8/FtxUpRO3dDOQPvHJWQs2HQCl1raKeVXvtCaCbkDeA3ETQFHjGFNFqd/HAOjW/OXfYnPpiaE= tanveer\tanveer@TANVEER"
}
variable "ec2_user_data" {
  type    = string
  default = "#!/bin/bash\necho ECS_CLUSTER=clearpoint-main-cluster-listapi-appp >> /etc/ecs/ecs.config"
}

#---------------------------------------------------
#VAR - aws_ecs_task_definition
variable "container_memory_allocation" {
  type    = number
  default = 50
}
variable "container_cpu_allocation" {
  type    = number
  default = 2
}
#---------------------------------------------------
#VAR - aws_iam_role_policy_attachment
variable "aws_iam_policy_arn" {
  type    = string
  default = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

#VAR - network.tf
variable "vpc_subnet_az_a" {
  type    = string
  default = "ap-southeast-2a"
}
variable "vpc_subnet_az_b" {
  type    = string
  default = "ap-southeast-2b"
}
#-----------------------------------------------
#Variable Scope for ECR
variable "app_count" {
  type    = string
  default = "1"
}
