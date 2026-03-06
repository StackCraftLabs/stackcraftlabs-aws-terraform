resource "aws_cloudwatch_log_group" "ecs" {
    name              = "/ecs/stackcraft"
    retention_in_days = 7
}