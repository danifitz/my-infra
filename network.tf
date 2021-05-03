# Create a VPC
resource "aws_vpc" "my_personal_vpc" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
      Name = "my_personal_vpc"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_personal_vpc.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "eu-west-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "my_subnet"
  }
}

resource "aws_network_interface" "my_network_interface" {
  subnet_id   = aws_subnet.my_subnet.id
  private_ips = ["10.0.10.10"]
  security_groups = [aws_security_group.allow_ssh_and_egress.id]

  attachment {
    instance     = aws_instance.my_instance.id
    device_index = 1
  }

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_personal_vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_internet_gateway.id
  }
  
  tags = {
    Name = "my-route-table"
  }
}

resource "aws_route_table_association" "subnet-association" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_internet_gateway" "my_internet_gateway" {
  vpc_id = aws_vpc.my_personal_vpc.id
  
  tags = {
    Name = "my_internet_gateway"
  }
}

resource "aws_eip" "my_elastic_ip" {
  instance = aws_instance.my_instance.id
  vpc      = true

  tags = {
      Name = "my_elastic_ip"
  }
}