
resource "aws_vpc" "an_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "an_vpc"
  }

}

resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.an_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "an_pub_1"
    Environment = "training"
    Tier = "Public"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id = aws_vpc.an_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "an_pvt_1"
    Environment = "training"
    Tier = "Private"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id = aws_vpc.an_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "an_pub_2"
    Environment = "training"
    Tier = "Public"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id = aws_vpc.an_vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "an_pvt_2"
    Environment = "training"
    Tier = "Private"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.an_vpc.id
  tags = {
    Name = "an_igw"
  }
}

resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.an_vpc.id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "an_pub_rt"
  }
}

resource "aws_route_table_association" "pub1_rt_asso" {
  subnet_id = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.pub_rt.id
}

resource "aws_route_table_association" "pub2_rt_asso" {
  subnet_id = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.pub_rt.id
}

resource "aws_eip" "an_eip" {
  vpc      = true
}

resource "aws_nat_gateway" "an_nat" {
  allocation_id = aws_eip.an_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "an_nat"
  }
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "an_pvt_rt" {
  vpc_id = aws_vpc.an_vpc.id
  route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.an_nat.id
  }
  tags = {
    Name = "an_pvt_rt"
  }
}

resource "aws_route_table_association" "pvt1_rt_asso" {
    subnet_id = aws_subnet.private_subnet_1.id
    route_table_id = aws_route_table.an_pvt_rt.id
}