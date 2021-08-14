output "alb_dns_name" {
  value = module.ecs.dns_name
}

output "ecr_repository" {
  value = module.ecs.ecr_repository
}

output "scale_out_action_name" {
  value = module.autoscaling.scale_out_action_name
}

output "scale_in_action_name" {
  value = module.autoscaling.scale_in_action_name
}
