################################################################################
# ecr repository
################################################################################
resource "aws_ecr_repository" "main" {
  name                 = "${var.prefix}-project"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}
################################################################################
# ecs cluster
################################################################################
resource "aws_ecs_cluster" "main" {
  name = "${var.prefix}-cluster"
}
#ecs task definition#####

resource "aws_ecs_task_definition" "main" {
  network_mode             = "awsvpc"
  family                   = "${var.name}-task-def"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = data.aws_iam_role.newrelic.arn
  # task_role_arn            = aws_iam_role.ecs_task_role.arn
  container_definitions = data.template_file.task_definition_tpl.rendered
}

#ecs service###########
resource "aws_ecs_service" "main" {
  name                               = "${var.name}-service-${var.environment}"
  cluster                            = aws_ecs_cluster.main.id
  task_definition                    = aws_ecs_task_definition.main.arn
  desired_count                      = 1
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = data.aws_subnets.Public.ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.test.arn
    container_name   = "${var.name}-container-${var.environment}"
    container_port   = var.container_port
  }

  lifecycle {
    ignore_changes = [task_definition, desired_count]
  }
}

data "template_file" "task_definition_tpl" {
    template = file("task-definitions/awslogs.tpl")

    vars = {
        name = var.name
        image = var.container_image
        environment = var.environment
    }
}