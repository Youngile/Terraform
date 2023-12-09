#GW,NATGW settings

resource "aws_eip" "NAT" {
  domain = "vpc"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_nat_gateway" "Private_NAT" {
  subnet_id                      = aws_subnet.Public_subnet_a.id
  allocation_id                  = aws_eip.NAT.id
  #secondary_allocation_ids       = [aws_eip.secondary.id]
  #secondary_private_ip_addresses = ["10.0.1.5"]
}

resource "aws_eip" "NAT2" {
  domain = "vpc"
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_nat_gateway" "Private_NAT2" {
  subnet_id                      = aws_subnet.Public_subnet_c.id
  allocation_id                  = aws_eip.NAT2.id
  #secondary_allocation_ids       = [aws_eip.secondary.id]
  #secondary_private_ip_addresses = ["10.0.1.5"]
}


resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
}
