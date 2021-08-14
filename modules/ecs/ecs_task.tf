resource "aws_cloudwatch_log_group" "this" {
  name = var.task_definition.cwlog_name
}

data "template_file" "this" {

  template = file(var.task_definition_file)

  vars = {
    name           = var.task_definition.container_name
    image          = aws_ecr_repository.this.repository_url
    awslogs-region = var.task_definition.awslogs-region
    awslogs-group  = var.task_definition.cwlog_name
    awslogs-prefix = var.task_definition.cwlog_prefix
  }
}

resource "aws_ecs_task_definition" "this" {
  family                = var.task_definition.name
  container_definitions = data.template_file.this.rendered

  cpu    = "256"
  memory = "512"

  execution_role_arn       = aws_iam_role.this.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  lifecycle {
    ignore_changes = all
  }

}
