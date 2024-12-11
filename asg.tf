# resource "aws_autoscaling_group" "asg" {
#   name = var.asg_name

#   desired_capacity = var.desired_capacity
#   max_size         = var.max_size
#   min_size         = var.min_size

#   vpc_zone_identifier = [module.vpc.private_subnets[0],module.vpc.private_subnets[1]]
#   health_check_type   = var.health_check_type

#   target_group_arns = [aws_lb_target_group.demo-app-tg.arn]

#   #   suspended_processes = var.suspended_processes

#   launch_template {
#     id      = aws_launch_template.demo-app-lt.id
#     version = var.launch_template_version
#   }

#   instance_refresh {
#     strategy = var.strategy
#     preferences {
#       min_healthy_percentage = 50
#     }
#   }

#   #   dynamic "tag" {
#   #     for_each = var.tags
#   #     iterator = item
#   #     content {
#   #       key                 = item.value.key
#   #       value               = item.value.value
#   #       propagate_at_launch = item.value.propagate_at_launch
#   #     }
#   #   }
# }

