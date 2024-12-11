# #Kafka Target Group
# resource "aws_lb_target_group" "demo-app-tg" {
#   name                 = var.app_tg_name
#   port                 = var.app_tg_port
#   protocol             = var.app_tg_protocol
#   vpc_id               = module.vpc.vpc_id
#   deregistration_delay = var.deregistration_delay
# }
