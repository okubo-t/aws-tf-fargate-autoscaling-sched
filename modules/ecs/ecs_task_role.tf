resource "aws_iam_role" "this" {
  name               = "${var.task_definition.name}-exec-role"
  assume_role_policy = file(var.ecs_task_trust_policy)
}

resource "aws_iam_role_policy_attachment" "this" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role       = aws_iam_role.this.id
}
