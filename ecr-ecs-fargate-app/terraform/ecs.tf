resource "aws_ecs_cluster" "main" {
    name = "${var.app_name}-cluster"

    tags = {
        Name = "${var.app_name}-cluster"
    }
}

resource "aws_ecs_task_definition" "app" {
    family = "${var.app_name}-task"
    requires_compatibilities = ["FARGATE"]

    cpu = "256"
    memory = "512"

    network_mode = "awsvpc"
    execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

    container_definitions = jsonencode([
        {
            name = "${var.app_name}-container"
            image = "${aws_ecr_repository.app.repository_url}:latest"
            portMappings = [
                {
                    containerPort = var.container_port
                    protocol = "tcp"
                }
            ]

            logConfiguration = {
                logDriver = "awslogs"
                options = {
                    "awslogs-group" = aws_cloudwatch_log_group.ecs.name
                    "awslogs-region" = var.aws_region
                    "awslogs-stream-prefix" = "${var.app_name}-logs"
                }
            }
        }
    ])
}

resource "aws_ecs_service" "app" {
    name = "${var.app_name}-service"
    cluster = aws_ecs_cluster.main.id
    task_definition = aws_ecs_task_definition.app.arn
    
    launch_type = "FARGATE"

    desired_count = var.desired_count

    network_configuration {
        subnets = [aws_subnet.private.id]
        security_groups = [aws_security_group.ecs.id]
    }

    load_balancer {
        target_group_arn = aws_lb_target_group.app.arn
        container_name = "${var.app_name}-container"
        container_port = var.container_port
    }

}