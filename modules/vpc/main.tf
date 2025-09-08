resource "aws_vpc" "this" {
   cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true

   tags = {
     Name = "VPC"
   }
}   
#subnet
resource "aws_subnet" "this" {
    vpc_id = aws_vpc.this.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true

    tags = {
      Name = "public subnet"
    }
  
}

resource "aws_route_table" "this" {
    vpc_id = aws_vpc.this.id
  
}

resource "aws_route" "this" {
    route_table_id = aws_route_table.this.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  
}

resource "aws_route_table_association" "this" {
    subnet_id = aws_subnet.this.id
    route_table_id = aws_route_table.this.id
  
}
#igw
resource "aws_internet_gateway" "this" {
    vpc_id = aws_vpc.this.id
  
}

#sg
resource "aws_security_group" "this" {
  vpc_id = aws_vpc.this.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name = "sg"
  }
}