resource "aws_vpc" "vpc" {
  cidr_block           = var.aws_vpc_cider_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = var.aws_vpc_name
  }
}

resource "aws_subnet" "public" {
  count                   = var.aws_subnets_nums
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.aws_vpc_cider_block, 4, count.index)
  availability_zone       = element(data.aws_availability_zones.available.names, count.index % var.aws_subnets_nums)
  map_public_ip_on_launch = var.aws_map_public_ip_is
  tags {
    Name = format("${var.aws_subnet_name}%02d", count.index + 1)
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags {
    Name = var.aws_internet_gateway_name
  }
}

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.vpc.id
  tags {
    Name = var.aws_route_table_name
  }
}

resource "aws_route" "public_rt" {
  route_table_id         = aws_route_table.public_rtb.id
  gateway_id             = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "public_rta" {
  route_table_id = aws_route_table.public_rtb.id
  subnet_id      = aws_subnet.public.id
}

resource "aws_security_group" "gitlab-sg" {
  name   = var.aws_security_group_name
  vpc_id = aws_vpc.vpc.id
}

resource "aws_security_group_rule" "ingress_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = var.cidr_blocks
  security_group_id = aws_security_group.gitlab-sg.id
}

data "aws_availability_zones" "available" {
  state = "available"
}
