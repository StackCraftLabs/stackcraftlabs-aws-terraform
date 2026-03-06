output "alb_dns" {
    value = aws_lb.main.dns_name
    description = "DNS name of the Application Load Balancer"
}