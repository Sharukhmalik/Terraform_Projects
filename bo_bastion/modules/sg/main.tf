# modules/security-group/main.tf
resource "aws_security_group" "this" {
  name        = var.name          # ← removed trailing dash
  description = var.description
  vpc_id      = var.vpc_id

  tags = merge(
    var.common_tags,              # ← use var not local
    var.tags,
    {
      Name = var.name
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}

# Create individual ingress rules from the list
resource "aws_security_group_rule" "ingress" {
  count = length(var.ingress_rules)

  type              = "ingress"
  security_group_id = aws_security_group.this.id
  from_port         = var.ingress_rules[count.index].from_port
  to_port           = var.ingress_rules[count.index].to_port
  protocol          = var.ingress_rules[count.index].protocol
  description       = var.ingress_rules[count.index].description

  cidr_blocks              = length(var.ingress_rules[count.index].cidr_blocks) > 0 ? var.ingress_rules[count.index].cidr_blocks : null
  source_security_group_id = length(var.ingress_rules[count.index].security_groups) > 0 ? var.ingress_rules[count.index].security_groups[0] : null
}

# Create individual egress rules
resource "aws_security_group_rule" "egress" {
  count = length(var.egress_rules)

  type              = "egress"
  security_group_id = aws_security_group.this.id
  from_port         = var.egress_rules[count.index].from_port
  to_port           = var.egress_rules[count.index].to_port
  protocol          = var.egress_rules[count.index].protocol
  description       = var.egress_rules[count.index].description

  cidr_blocks              = length(var.egress_rules[count.index].cidr_blocks) > 0 ? var.egress_rules[count.index].cidr_blocks : null
  source_security_group_id = length(var.egress_rules[count.index].security_groups) > 0 ? var.egress_rules[count.index].security_groups[0] : null
}