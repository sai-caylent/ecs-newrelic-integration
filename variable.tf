variable "prefix" {
  default = "f45"
}
variable "container_port" {
  default = 80
}
variable "name" {
  default = "f45-newrelic"
}
variable "environment" {
  default = "dev"
}
variable "container_image" {
  default = "131578276461.dkr.ecr.us-east-2.amazonaws.com/f45-project"
}

