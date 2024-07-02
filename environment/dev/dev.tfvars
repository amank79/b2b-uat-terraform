environment = "dev"


#LT
lt_name        = "demo-app-lt"
instance_type  = "t2.micro"
key_name       = "demo"
user_data_path = "environment/dev/user_data/bootstrap.sh"



#ASG
asg_name                = "demo-app-asg"
desired_capacity        = 1
max_size                = 1
min_size                = 1
health_check_type       = "EC2"
launch_template_version = "$Default"
strategy                = "Rolling"

#TG
app_tg_name          = "demo-app-tg"
app_tg_port          = 80
app_tg_protocol      = "HTTP"
deregistration_delay = 300

#ELB
lb_name                    = "demo-app-elb"
lb_type                    = "application"
demo_app_listener_protocol = "HTTP"
demo_app_listener_port     = 80



#SG
sg_name = "mbpro-sg"

nodes_ingress_rules = [
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

nodes_egress_rules = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

#IAM Role
iam_name        = "Demo-App-Role-New"
iam_policy_arns = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", "arn:aws:iam::aws:policy/AmazonEC2FullAccess", "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM", "arn:aws:iam::aws:policy/AutoScalingFullAccess", "arn:aws:iam::aws:policy/AmazonS3FullAccess", "arn:aws:iam::aws:policy/CloudWatchAgentAdminPolicy", "arn:aws:iam::aws:policy/CloudWatchFullAccess", "arn:aws:iam::aws:policy/AWSCodeDeployFullAccess", "arn:aws:iam::aws:policy/AmazonElasticFileSystemFullAccess", "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"]
