resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "main"
  }
}

locals {
  subnets_public = {
    "zone-a" = { cidr = "10.0.1.0/24", zone = "eu-west-2a" }
    "zone-b" = { cidr = "10.0.2.0/24", zone = "eu-west-2b" }
  }

  subnets_private = {
    "zone-a" = { cidr = "10.0.3.0/24", zone = "eu-west-2a" }
    "zone-b" = { cidr = "10.0.4.0/24", zone = "eu-west-2b" }
  }
}

resource "aws_subnet" "main_public" {
  for_each                = local.subnets_public
  vpc_id                  = aws_vpc.main.id
  availability_zone       = each.value.zone
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = true
}

resource "aws_subnet" "main_private" {
  for_each                = local.subnets_private
  vpc_id                  = aws_vpc.main.id
  availability_zone       = each.value.zone
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = false
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    "Name" = "main"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rt_asso" {
  for_each       = aws_subnet.main_public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "ng" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.main_public["zone-a"].id
  depends_on    = [aws_internet_gateway.igw]
}

resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ng.id
  }
}

resource "aws_route_table_association" "rt_association_ng" {
  for_each = aws_subnet.main_private
  route_table_id = aws_route_table.rt_private.id
  subnet_id      = each.value.id
}
