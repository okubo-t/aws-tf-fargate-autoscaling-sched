output "scale_out_action_name" {
  value = aws_appautoscaling_scheduled_action.scale_out.name
}

output "scale_in_action_name" {
  value = aws_appautoscaling_scheduled_action.scale_in.name
}
