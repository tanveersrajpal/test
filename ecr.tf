resource "aws_ecr_repository" "clearpoint-frontend" {
  name                 = "clearpoint-frontend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
resource "aws_ecr_repository" "clearpoint-backend" {
  name                 = "clearpoint-backend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
