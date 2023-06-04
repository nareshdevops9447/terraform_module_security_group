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