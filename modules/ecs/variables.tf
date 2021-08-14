variable "vpc_id" {
  type = string
}

variable "alb_name" {
  type    = string
  default = "test-alb"
}

variable "internal" {
  type    = bool
  default = false
}

variable "target_type" {
  type    = string
  default = "instance"
}

variable "health_check_path" {
  type    = string
  default = "/"
}

variable "my_remote_ip" {
  type    = string
  default = "192.168.0.1/32"
}

variable "subnet_ids" {
  type = list(string)
}

variable "cluster_name" {
  type    = string
  default = "test-cluster"
}

variable "ecr_name" {
  type    = string
  default = "test-ecr"
}

variable "task_definition_file" {
  type    = string
  default = "./modules/ecs/ecs_task_definition.json"
}

variable "task_definition" {
  type = map(string)
  default = {
    name           = "test-task-def"
    container_name = "test-container"
    awslogs-region = "ap-northeast-1"
    cwlog_name     = "test-cwlog"
    cwlog_prefix   = "test-container"

  }
}

variable "ecs_task_trust_policy" {
  type    = string
  default = "./modules/ecs/ecs_task_trust_policy.json"
}

variable "service_name" {
  type    = string
  default = "test-svc"
}

variable "desired_count" {
  type    = number
  default = 0
}
