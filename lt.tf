data "aws_ami" "amazon_linux_2023" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023.5.20240624.0-kernel-6.1-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"]
}

resource "aws_launch_template" "demo-app-lt" {
  name                   = var.lt_name
  description            = "Launch Template for Demo App using Terraform"
  image_id               = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.node_sg.id]
  key_name               = var.key_name
  user_data              = filebase64(var.user_data_path)
  ebs_optimized          = false

  block_device_mappings {
    device_name = "/dev/sda"

    ebs {
      volume_size = 15
      volume_type = "gp3"
    }
  }

  iam_instance_profile {
    arn = aws_iam_instance_profile.demo_app-Instance-Profile.arn
  }

  update_default_version = true

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "Demo-App"
      Environment = var.environment
    }
  }
}
