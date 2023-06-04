resource "aws_security_group" "main" {
    name = var.security_group_name
    description = var.security_group_description
    vpc_id      = var.vpc_id
    
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

tags = merge(
    var.tags,
    var.security_group_tags,
   {"Name" = var.security_group_name}
   )

}
# this rule will add ingress rules to the sg
resource "aws_security_group_rule" "ingress_with_cidr" {
  count= length(var.ingress_cidr)
  type = "ingress"
  from_port = lookup(var.ingress_cidr[count.index], "from_port")
  to_port = lookup(var.ingress_cidr[count.index], "to_port")
  cidr_blocks = [lookup(var.ingress_cidr), "cidr_block"]
  protocol = "6"
  security_group_id = aws_security_group.main
}