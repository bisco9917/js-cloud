resource "aws_security_group" "allow_http_https" {
  name        = "allow_http_https"
  description = "Allow HTTP and HTTPS inbound traffic"
  vpc_id      = aws_vpc.salt_environment.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.allow_http_https.id

  description = "Allow HTTP inbound"
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.allow_http_https.id

  description = "Allow HTTPS inbound"
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  to_port     = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_out" {
  security_group_id = aws_security_group.allow_http_https.id

  description = "Allow all traffic outbound"
  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 0
  to_port     = 0
}