data "http" "myipaddr" {
  url = "http://icanhazip.com"
}

######
## PRIVATE
######

resource "aws_security_group" "private" {
  name        = "private"
  description = "Security group for private access"
  vpc_id      = var.vpc_id

  tags = {
    Name = "private-security_group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "private-ssh" {
  security_group_id = aws_security_group.private.id

  cidr_ipv4   = "${chomp(data.http.myipaddr.response_body)}/32"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_egress_rule" "private-outgoing_ipv6" {
  security_group_id = aws_security_group.private.id

  cidr_ipv6   = "::/0"
  ip_protocol = "-1"
}

resource "aws_vpc_security_group_egress_rule" "private-outgoing_ipv4" {
  security_group_id = aws_security_group.private.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

######
## PUBLIC
######

resource "aws_security_group" "public" {
  name        = "public"
  description = "Security group for public access"
  vpc_id      = var.vpc_id

  tags = {
    Name = "public-security_group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "http_ipv6" {
  security_group_id = aws_security_group.public.id

  cidr_ipv6   = "::/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "http_ipv4" {
  security_group_id = aws_security_group.public.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "app_port_ipv6" {
  security_group_id = aws_security_group.public.id

  cidr_ipv6   = "::/0"
  from_port   = 3000
  ip_protocol = "tcp"
  to_port     = 3000
}

resource "aws_vpc_security_group_ingress_rule" "app_port_ipv4" {
  security_group_id = aws_security_group.public.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 3000
  ip_protocol = "tcp"
  to_port     = 3000
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.public.id

  cidr_ipv4   = "${chomp(data.http.myipaddr.response_body)}/32"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_egress_rule" "outgoing_ipv6" {
  security_group_id = aws_security_group.public.id

  cidr_ipv6   = "::/0"
  ip_protocol = "-1"
}

resource "aws_vpc_security_group_egress_rule" "outgoing_ipv4" {
  security_group_id = aws_security_group.public.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}


