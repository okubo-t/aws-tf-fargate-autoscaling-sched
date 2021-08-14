resource "aws_appautoscaling_target" "ecs" {
  resource_id        = "service/${var.cluster_name}/${var.service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
  min_capacity       = 1
  max_capacity       = 1
}

resource "aws_appautoscaling_scheduled_action" "scale_out" {
  name               = var.scale_out_action.name
  resource_id        = aws_appautoscaling_target.ecs.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs.service_namespace
  schedule           = var.scale_out_action.schedule
  timezone           = "Asia/Tokyo"

  scalable_target_action {
    min_capacity = var.scale_out_action.min_capacity
    max_capacity = var.scale_out_action.max_capacity
  }
}

resource "aws_appautoscaling_scheduled_action" "scale_in" {
  name               = var.scale_in_action.name
  resource_id        = aws_appautoscaling_target.ecs.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs.service_namespace
  schedule           = var.scale_in_action.schedule
  timezone           = "Asia/Tokyo"

  scalable_target_action {
    min_capacity = var.scale_in_action.min_capacity
    max_capacity = var.scale_in_action.max_capacity
  }
}
