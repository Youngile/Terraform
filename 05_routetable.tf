#Route_table settings

resource "aws_route_table" "Public_Route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "Public_rt"
  }
}

resource "aws_route_table" "Private_Route_table_a" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.Private_NAT.id
  }

  tags = {
    Name = "Private_rt_a"
  }
}

resource "aws_route_table" "Private_Route_table_c" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.Private_NAT2.id
  }

  tags = {
    Name = "Private_rt_c"
  }
}
resource "aws_route_table_association" "Public_subnet_1" {
  subnet_id      = aws_subnet.Public_subnet_a.id
  route_table_id = aws_route_table.Public_Route_table.id
}

resource "aws_route_table_association" "Public_subnet_2" {
  subnet_id      = aws_subnet.Public_subnet_c.id
  route_table_id = aws_route_table.Public_Route_table.id
}

resource "aws_route_table_association" "Private_subnet_1" {
  subnet_id      = aws_subnet.Private_web_subnet_a.id
  route_table_id = aws_route_table.Private_Route_table_a.id
}

resource "aws_route_table_association" "Private_subnet_2" {
  subnet_id      = aws_subnet.Private_web_subnet_c.id
  route_table_id = aws_route_table.Private_Route_table_c.id
}

resource "aws_route_table_association" "Private_subnet_3" {
  subnet_id      = aws_subnet.Private_db_subnet_a.id
  route_table_id = aws_route_table.Private_Route_table_a.id
}

resource "aws_route_table_association" "Private_subnet_4" {
  subnet_id      = aws_subnet.Private_db_subnet_c.id
  route_table_id = aws_route_table.Private_Route_table_c.id
}

