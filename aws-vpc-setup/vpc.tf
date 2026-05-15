#create vpc
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/24"

  tags = {
    name = ""
  }

}

#create subnet 
resource "aws_subnet" "dev_sub" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.0.0/25"
  availability_zone = "ap-south-1a"

}

#create internet gateway
resource "aws_internet_gateway" "dev_ig" {
  vpc_id = aws_vpc.my_vpc.id

}
#create route table and create route in route table for internet access
resource "aws_route_table" "dev_rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_ig.id

  }

}
#associate route table with subnet
resource "aws_route_table_association" "dev" {
  subnet_id      = aws_subnet.dev_sub.id
  route_table_id = aws_route_table.dev_rt.id

}
#create security group in vpc with port 80,22 as inbound rule
resource "aws_security_group" "dev_sg" {
  name        = "allow tls"
  description = "allow TLS inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "TLS from vpc"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    description = "TLS from vpc"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}   