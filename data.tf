variable "vpc_id" {
  default = "vpc-1048ee79"
}
data "aws_vpc" "selected" {
  id = var.vpc_id
}
data "aws_subnets" "Public" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  tags = {
    Tier = "Public"
  }
}

output "name" {
  value = data.aws_subnets.Public.ids
}

data "aws_iam_role" "example" {
  name = "ecsTaskExecutionRole"
}

data "aws_iam_role" "newrelic" {
  name = "NewRelicECSIntegration-Ne-NewRelicECSTaskExecution-1MU24HPPR0EVG"
}
