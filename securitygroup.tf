################################################################################
# Security Group for Application Load Balancer
################################################################################
resource "aws_security_group" "alb" {
  name        = "f45_alb"
  description = "Allow http inbound traffic"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    description = "http from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "allow_http"
  }
}
################################################################################
# Security Group for ecs tasks
################################################################################
resource "aws_security_group" "ecs_tasks" {
  name        = "${var.prefix}-sg-task"
  description = "ecs cluster security group"
  vpc_id      = var.vpc_id

  ingress {
    protocol         = "tcp"
    from_port        = var.container_port
    to_port          = var.container_port
    security_groups  = [aws_security_group.alb.id]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    protocol         = "-1"
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}