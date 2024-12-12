# resource "aws_iam_role" "Demo-App-Role" {
#   name = var.iam_name

#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "ec2.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# EOF

#   tags = {
#     Name = "Demo-App-IAM-Role"
#   }
# }

# resource "aws_iam_role_policy_attachment" "demo_app_policy" {
#   for_each   = var.iam_policy_arns
#   role       = aws_iam_role.Demo-App-Role.name
#   policy_arn = each.value
# }

# resource "aws_iam_instance_profile" "demo_app-Instance-Profile" {
#   name = var.iam_name
#   role = aws_iam_role.Demo-App-Role.name
# }