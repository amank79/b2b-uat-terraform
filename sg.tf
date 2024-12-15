# resource "aws_security_group" "node_sg" {
#   name        = var.sg_name
#   description = "Allow TLS inbound traffic and all outbound traffic"
#   vpc_id      = module.vpc.vpc_id

#   tags = {
#     Name = "Default-SG"
#   }
# }

# resource "aws_security_group_rule" "nodes_ingress" {
#   count             = length(var.nodes_ingress_rules)
#   security_group_id = aws_security_group.node_sg.id
#   from_port         = var.nodes_ingress_rules[count.index].from_port
#   to_port           = var.nodes_ingress_rules[count.index].to_port
#   protocol          = var.nodes_ingress_rules[count.index].protocol
#   cidr_blocks       = var.nodes_ingress_rules[count.index].cidr_blocks
#   type              = "ingress"
# }

# resource "aws_security_group_rule" "nodes_egress" {
#   count             = length(var.nodes_egress_rules)
#   security_group_id = aws_security_group.node_sg.id
#   from_port         = var.nodes_egress_rules[count.index].from_port
#   to_port           = var.nodes_egress_rules[count.index].to_port
#   protocol          = var.nodes_egress_rules[count.index].protocol
#   cidr_blocks       = var.nodes_egress_rules[count.index].cidr_blocks
#   type              = "egress"
# }


resource "aws_security_group" "ssh_sg" {
  name        = "allow-ssh"
  description = "Security group to allow SSH access"
  vpc_id      = module.vpc.vpc_id # Replace with your VPC ID or define it in variables

  ingress {
    description = "Allow SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Replace with a specific IP range for better security
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 allows all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-ssh"
  }
}

