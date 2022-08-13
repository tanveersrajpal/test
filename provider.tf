provider "aws" {
  region = "ap-southeast-2"
}
terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "clearpoint-tfstate-backend"
    key            = "state/terraform.tfstate"
    region         = "ap-southeast-2"
  }
}
