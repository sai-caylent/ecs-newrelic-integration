output "ecs_taskdefname" {
  value = aws_ecs_task_definition.main.family
}
output "newrelic" {
  value = data.aws_iam_role.newrelic.arn
}