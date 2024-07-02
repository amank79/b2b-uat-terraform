resource "aws_security_group" "node_sg" {
  name        = var.sg_name
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "Default-SG"
  }
}

resource "aws_security_group_rule" "nodes_ingress" {
  count             = length(var.nodes_ingress_rules)
  security_group_id = aws_security_group.node_sg.id
  from_port         = var.nodes_ingress_rules[count.index].from_port
  to_port           = var.nodes_ingress_rules[count.index].to_port
  protocol          = var.nodes_ingress_rules[count.index].protocol
  cidr_blocks       = var.nodes_ingress_rules[count.index].cidr_blocks
  type              = "ingress"
}

resource "aws_security_group_rule" "nodes_egress" {
  count             = length(var.nodes_egress_rules)
  security_group_id = aws_security_group.node_sg.id
  from_port         = var.nodes_egress_rules[count.index].from_port
  to_port           = var.nodes_egress_rules[count.index].to_port
  protocol          = var.nodes_egress_rules[count.index].protocol
  cidr_blocks       = var.nodes_egress_rules[count.index].cidr_blocks
  type              = "egress"
}
