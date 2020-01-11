resource "aws_vpc" "vpc" {
  cidr_block           = var.aws_vpc_cider_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = var.aws_vpc_name
  }
}

resource "aws_subnet" "sn" {
  count                   = var.aws_subnets_nums
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.aws_vpc_cider_block, 4, count.index)
  availability_zone       = element(data.aws_availability_zones.available.names, count.index % var.aws_subnets_nums)
  map_public_ip_on_launch = var.aws_map_public_ip_is

  tags {
    Name = var.aws_subnet_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags {
    Name = var.aws_internet_gateway_name
  }
}

resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.vpc.id

  tags {
    Name = var.aws_route_table_name
  }
}

resource "aws_route" "rt" {
  route_table_id         = aws_route_table.rtb.id
  gateway_id             = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "rta" {
  route_table_id = aws_route_table.rtb.id
  subnet_id      = aws_subnet.sn.id
}

resource "aws_security_group" "sg" {
  name   = var.aws_security_group_name
  vpc_id = aws_vpc.vpc.id

  tags {
    Name = var.aws_security_group_name
  }
}

resource "aws_security_group_rule" "ingress_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = var.aws_security_group_cidr_blocks
  security_group_id = aws_security_group.sg.id
}

resource "aws_security_group_rule" "ingress_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.aws_security_group_cidr_blocks
  security_group_id = aws_security_group.sg.id
}

resource "aws_security_group_rule" "default_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.aws_security_group_cidr_blocks
  security_group_id = aws_security_group.sg.id
}

resource "aws_security_group_rule" "gitlab_ssh" {
  type              = "ingress"
  from_port         = 30022
  to_port           = 30022
  protocol          = "tcp"
  cidr_blocks       = var.aws_security_group_cidr_blocks
  security_group_id = aws_security_group.sg.id
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg.id
}

data "aws_availability_zones" "available" {
  state = "available"
}
