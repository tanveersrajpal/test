variable "network_interface_id" {
  type    = string
  default = "network_id_from_aws"
}
variable "ami" {
  type    = string
  default = "ami-07620139298af599e"
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "mysqladminuser" {
  type      = string
  sensitive = true
  default   = "admin"
}
variable "mysqladminpassword" {
  type      = string
  sensitive = true
  default   = "j58XZ2KFuMMDyu"
}
variable "AWS_Region" {
  type    = string
  default = "ap-southeast-2"
}
variable "vpc_subnet_az_a" {
  type    = string
  default = "ap-southeast-2a"
}
variable "vpc_subnet_az_b" {
  type    = string
  default = "ap-southeast-2b"
}
variable "vpc_subnet_az_c" {
  type    = string
  default = "ap-southeast-2c"
}
variable "subnet_id_ec2" {
  type    = string
  default = "aws_subnet.prod-subnet-public-1.id"
}
variable "ec2_cpu_utlization_alert_emailaddress" {
  type    = string
  default = "strikingimpactcorp@gmail.com"
}
#-----------------------------------------------
#Variable Scope for ECR
variable "app_count" {
  type    = string
  default = "1"
}

#-----------------------------------------------
#Variable Scope for ECR-------------------------

variable "aws_region" {
  type        = string
  description = "The region in which to create and manage resources"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.100.0.0/16"
}

variable "azs" {
  type        = list(string)
  description = "the name of availability zones to use subnets"
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnets" {
  type        = list(string)
  description = "the CIDR blocks to create public subnets"
  default     = ["10.100.10.0/24", "10.100.20.0/24"]
}

variable "private_subnets" {
  type        = list(string)
  description = "the CIDR blocks to create private subnets"
  default     = ["10.100.30.0/24", "10.100.40.0/24"]
}

variable "instance_type_spot" {
  default = "t3a.medium"
  type    = string
}

variable "spot_bid_price" {
  default     = "0.0175"
  description = "How much you are willing to pay as an hourly rate for an EC2 instance, in USD"
}

variable "cluster_name" {
  default     = "ecs_terraform_ec2"
  type        = string
  description = "the name of an ECS cluster"
}

variable "min_spot" {
  default     = "2"
  description = "The minimum EC2 spot instances to be available"
}

variable "max_spot" {
  default     = "5"
  description = "The maximum EC2 spot instances that can be launched at peak time"
}
