resource "aws_ecs_service" "this" {

  depends_on = [aws_lb_target_group.this]

  name            = var.service_name
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn

  desired_count = var.desired_count

  launch_type = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [aws_security_group.ecs-sg.id, ]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = var.task_definition.container_name
    container_port   = 80
  }

  lifecycle {
    ignore_changes = all
  }

}
