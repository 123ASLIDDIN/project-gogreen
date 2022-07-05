# Create VPC
resource "aws_vpc" "main" {
  cidr_block = "30.0.0.0/16"
  tags = {
    Name = "Vpc-Insurance"
  }
}

# Create Public Subnet
resource "aws_subnet" "public_subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "30.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "Public-Subnet1"
  }
}
# Create Public Subnet
resource "aws_subnet" "public_subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "30.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "Public-Subnet2"
  }
}

# Create Private Subnet
resource "aws_subnet" "private_subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "30.0.3.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "Private-Subnet1"
  }
}
# Create Private Subnet
resource "aws_subnet" "private_subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "30.0.4.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "Private-Subnet2"
  }
}
# Create Private Subnet
resource "aws_subnet" "private_subnet3" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "30.0.5.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "Private-Subnet3"
  }
}
# Create Private Subnet
resource "aws_subnet" "private_subnet4" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "30.0.6.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "Private-Subnet4"
  }
}

# Creating Internet Gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Internet-Gateway"
  }
}

# Creating EIP
resource "aws_eip" "Elastik_IP1" {
  vpc = true
}

# Creating NAT Gateway
resource "aws_nat_gateway" "nat_gateway1" {
  allocation_id = aws_eip.Elastik_IP1.id
  subnet_id     = aws_subnet.public_subnet1.id

  tags = {
    Name = "NATGW-1"
  }
}

# Creating EIP2
resource "aws_eip" "Elastik_IP2" {
  vpc = true
}

# Creating NAT Gateway
resource "aws_nat_gateway" "nat_gateway2" {
  allocation_id = aws_eip.Elastik_IP2.id
  subnet_id     = aws_subnet.public_subnet2.id

  tags = {
    Name = "NATGW-2"
  }
}

# #Route for NAT
# resource "aws_route" "nat_gateway1" {
#   route_table_id = aws_route_table.private_route_table.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id = aws_nat_gateway.nat_gateway1.id
# }
# #Route for NAT
# resource "aws_route" "nat_gateway2" {
#   route_table_id = aws_route_table.private_route_table.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id = aws_nat_gateway.nat_gateway2.id
# }


# Creating Public Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "Public-route-Table"
  }
}

# Creating Private Route Table 1
resource "aws_route_table" "private_route_table-1" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway1.id

  }

  tags = {
    Name = "Private-route-Table-1"
  }
}

# Creating Private Route Table 2
resource "aws_route_table" "private_route_table-2" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway2.id

  }

  tags = {
    Name = "Private-route-Table-2"
  }
}


# Route Table association with Public Subnet
resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_route_table.id
}
# Route Table association with Public Subnet
resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_route_table.id
}


# Route Table association with Private Subnet for web and db
resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_route_table-1.id
}
# Route Table association with Private Subnet for web
resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private_route_table-2.id
}
# Route Table association with Private Subnet for app
resource "aws_route_table_association" "private3" {
  subnet_id      = aws_subnet.private_subnet3.id
  route_table_id = aws_route_table.private_route_table-1.id
}
# Route Table association with Private Subnet for app
resource "aws_route_table_association" "private4" {
  subnet_id      = aws_subnet.private_subnet4.id
  route_table_id = aws_route_table.private_route_table-2.id
}
