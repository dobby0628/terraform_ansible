provider "aws" {
  access_key = "[access_key]"
  secret_key = "[secret_key]"
  region = "ap-northeast-2"
}

# create vpc
resource "aws_vpc" "my-vpc" {
  cidr_block       = "20.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "my-vpc"
  }
}

# create internet gateway
resource "aws_internet_gateway" "my-gw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "my-gw"
  }
}

# create route table
resource "aws_route_table" "my-route-table" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-gw.id
  }

  tags = {
    Name = "my-route-table"
  }
}

# connect vpc & route table
resource "aws_main_route_table_association" "a" {
  vpc_id         = aws_vpc.my-vpc.id
  route_table_id = aws_route_table.my-route-table.id
}

# create subnet 2a
resource "aws_subnet" "my-subnet-2a" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "20.0.0.0/24"
  availability_zone = "ap-northeast-2a"
  
  tags = {
    Name = "my-subnet-2a"
  }
}

# create subnet 2b
resource "aws_subnet" "my-subnet-2b" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "20.0.1.0/24"
  availability_zone = "ap-northeast-2b"
  
  tags = {
    Name = "my-subnet-2b"
  }
}

# create ec2 key pair
resource "aws_key_pair" "id_rsa" {
  key_name   = "id_rsa"
  public_key = file("~/.ssh/id_rsa.pub")
}

# create security group
resource "aws_security_group" "allow_web" {
  name        = "allow_web"
  description = "Allow web inbound traffic"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    description      = "web from HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "web from SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }  

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_web"
  }
}

# create ec2 instance
resource "aws_instance" "web" {
  ami                    = "ami-04876f29fd3a5e8ba"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.id_rsa.key_name
  vpc_security_group_ids = [aws_security_group.allow_web.id]
  availability_zone = "ap-northeast-2a"
  subnet_id = aws_subnet.my-subnet-2a.id
  associate_public_ip_address = true
  user_data = file("./apache.sh")

  tags = {
    Name = "web"
  }
}
