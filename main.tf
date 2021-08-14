###########
# Network
###########
module "network" {
  source = "./modules/network"

  vpc = {
    name = "${var.prefix}-${var.env}-vpc"
    cidr = "10.0.0.0/16"
  }

  igw_name = "${var.prefix}-${var.env}-igw"

  public_subnet_a = {
    name = "${var.prefix}-${var.env}-public-a"
    cidr = "10.0.1.0/24"
  }

  public_subnet_c = {
    name = "${var.prefix}-${var.env}-public-c"
    cidr = "10.0.2.0/24"
  }

  private_subnet_a = {
    name = "${var.prefix}-${var.env}-private-a"
    cidr = "10.0.10.0/24"
  }

  private_subnet_c = {
    name = "${var.prefix}-${var.env}-private-c"
    cidr = "10.0.20.0/24"
  }

}

##############
# ECS SAMPLE
##############
module "ecs" {
  source = "./modules/ecs"

  ## network
  vpc_id = module.network.vpc_id
  subnet_ids = [
    module.network.public_subnet_a_id,
    module.network.public_subnet_c_id,
  ]
  my_remote_ip = var.my_remote_ip

  ## alb
  alb_name = "${var.prefix}-${var.env}-alb"

  ## ecs
  cluster_name = "${var.prefix}-${var.env}-cluster"
  ecr_name     = "${var.prefix}-${var.env}-app"
  task_definition = {
    name           = "${var.prefix}-${var.env}-task-def"
    container_name = "${var.prefix}-${var.env}-app"

    awslogs-region = var.aws_region
    cwlog_name     = "${var.prefix}-${var.env}-cwlog"
    cwlog_prefix   = "${var.prefix}-${var.env}-app"

  }
  service_name  = "${var.prefix}-${var.env}-svc"
  desired_count = 0

}

##################
# Push ECR Image
##################
resource "null_resource" "default" {
  depends_on = [module.ecs]

  provisioner "local-exec" {
    command = "$(aws ecr get-login --no-include-email --region ${var.aws_region})"
  }
  provisioner "local-exec" {
    command = "docker build -t ${var.prefix}-${var.env}-repo ."
  }
  provisioner "local-exec" {
    command = "docker tag ${var.prefix}-${var.env}-repo:latest ${module.ecs.ecr_repository}:latest"
  }
  provisioner "local-exec" {
    command = "docker push ${module.ecs.ecr_repository}:latest"
  }

}

module "autoscaling" {
  source     = "./modules/autoscaling"
  depends_on = [module.ecs]

  cluster_name = module.ecs.cluster_name
  service_name = module.ecs.service_name

  scale_out_action = {
    name         = "${module.ecs.service_name}-scale-out"
    schedule     = "cron(50 8 * * ? *)" # every day at 8:50 JST
    min_capacity = 2
    max_capacity = 2
  }

  scale_in_action = {
    name         = "${module.ecs.service_name}-scale-in"
    schedule     = "cron(10 18 * * ? *)" # every day at 18:10 JST
    min_capacity = 1
    max_capacity = 1
  }

}
