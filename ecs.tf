resource "aws_ecs_task_definition" "clearpoint_taskdefinition" {
  family             = "clearpoint-web_terraform"
  network_mode       = "bridge"
  cpu                = 256
  memory             = 512
  execution_role_arn = aws_iam_role.ecs_agent.arn
  container_definitions = jsonencode([
    {
      name      = "Frontend"
      image     = "${aws_ecr_repository.clearpoint-frontend.repository_url}:latest"
      memory    = 50
      essential = true
      cpu       = 2
      portMappings = [
        {
          containerPort = 80
          hostPort      = 3000
        }
      ]
    },
    {
      name      = "Backend"
      image     = "${aws_ecr_repository.clearpoint-backend.repository_url}:latest"
      memory    = 50
      essential = true
      cpu       = 2
      portMappings = [
        {
          containerPort = 80
          hostPort      = 3002
        }
      ]
    }
  ])
}
#--------------------------------------------------------------------------
#Creating Elastic Container Service - CLUSTER
resource "aws_ecs_cluster" "clearpoint-main-cluster-listapi-app" {
  name = "clearpoint-main-cluster-listapi-appp"
}

#--------------------------------------------------------------------------
#Creating Elastic Container Service - CLUSTER SERVICE
resource "aws_ecs_service" "clearpoint-cluster-service-listapi-app" {
  name            = "clearpoint-cluster-service-listapi-app"
  cluster         = aws_ecs_cluster.clearpoint-main-cluster-listapi-app.id
  task_definition = aws_ecs_task_definition.clearpoint_taskdefinition.id
  desired_count   = 2
  launch_type     = "EC2"
}

#--------------------------------------------------------------------------

