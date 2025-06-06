//creation of vpc
resource "aws_vpc" "dev" {
  cidr_block = "10.0.0.0/16"
}

//creation of internet gateway
resource "aws_internet_gateway" "dev" {
  vpc_id = aws_vpc.dev.id
}

//creation of subnet
resource "aws_subnet" "dev" {
  vpc_id     = aws_vpc.dev.id
  cidr_block = "10.0.1.0/24"
}
//creation of Aws route table
resource "aws_route_table" "dev" {
  vpc_id = aws_vpc.dev.id
route {
    cidr_block = "10.0.1.0/24"
    gateway_id = aws_internet_gateway.dev.id
  }
  }

  //Rote table Asociation
  resource "aws_route_table_association" "dev" {
  subnet_id      = aws_subnet.dev.id
  route_table_id = aws_route_table.dev.id
}
//6.creation of ec2 instance
 resource "aws_instance" "dev" {
  ami           = "ami-00a929b66ed6e0de6"
  instance_type = "t2.micro"
  key_name      = "Thursday"
  subnet_id     = aws_subnet.dev.id
  associate_public_ip_address = true
 }
