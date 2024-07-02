#Main Load balancer
resource "aws_lb" "demo-app-alb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = var.lb_type

  subnets         = module.vpc.public_subnets
  security_groups = [aws_security_group.node_sg.id]

  tags = {
    Name = var.lb_name
  }
}

#Listener for Kafka
resource "aws_lb_listener" "demo-app-listener" {
  load_balancer_arn = aws_lb.demo-app-alb.arn
  protocol          = var.demo_app_listener_protocol
  port              = var.demo_app_listener_port

  default_action {
    target_group_arn = aws_lb_target_group.demo-app-tg.arn
    type             = "forward"
  }
}
