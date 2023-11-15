resource "aws_vpc" "app_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "app_vpc"
  }
}

resource "aws_subnet" "app_subnet" {
  vpc_id                  = aws_vpc.app_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "app_subnet"
  }
}

resource "aws_subnet" "db_subnet" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "db_subnet"
  }
}

resource "aws_internet_gateway" "app_igw" {
  vpc_id = aws_vpc.app_vpc.id

  tags = {
    Name = "app_igw"
  }
}

resource "aws_nat_gateway" "app_nat" {
  allocation_id = aws_eip.app_eip.id
  subnet_id     = aws_subnet.app_subnet.id

  tags = {
    Name = "app_nat"
  }
}

resource "aws_eip" "app_eip" {
  vpc = true
}

resource "aws_route_table" "app_rt" {
  vpc_id = aws_vpc.app_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app_igw.id
  }

  tags = {
    Name = "app_rt"
  }
}

resource "aws_route_table_association" "app_rt_assoc" {
  subnet_id      = aws_subnet.app_subnet.id
  route_table_id = aws_route_table.app_rt.id
}

resource "aws_route_table" "db_rt" {
  vpc_id = aws_vpc.app_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.app_nat.id
  }

  tags = {
    Name = "db_rt"
  }
}

resource "aws_route_table_association" "db_rt_assoc" {
  subnet_id      = aws_subnet.db_subnet.id
  route_table_id = aws_route_table.db_rt.id
}
