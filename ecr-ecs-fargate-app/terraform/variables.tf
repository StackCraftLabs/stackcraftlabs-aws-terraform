variable "aws_region" {
    description = "AWS region to deploy resources"
    type        = string
    default     = "us-west-2"
}

variable "docker_image" {
    description = "Docker image name"
    type        = string
}

variable "docker_tag" {
    description = "Docker image tag"
    type        = string
}

variable "container_port" {
    description = "Exposed Container Port"
    type    = number
    default = 80
}

variable "desired_count" {
    description = "Desired Count for number of App Instances running at a time"
    type    = number
    default = 1
}

variable "app_name" {
    description = "Name of the Application"
    type        = string
    default = "stackcraft-ecs-app"
}