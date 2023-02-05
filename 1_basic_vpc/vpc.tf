resource "aws_vpc" "my_vpc" {
  cidr_block = "10.1.0.0/16"
}

resource "aws_subnet" "my_subs" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.1.1.0/24"
}

resource "aws_internet_gateway" "my_vpc_igw" {
  vpc_id = aws_vpc.my_vpc.id #to which you attach the IGW
}

resource "aws_route_table" "my_rtb" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route" "my_rt" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.my_rtb.id
  gateway_id             = aws_internet_gateway.my_vpc_igw.id
}

#you can add route block in route_table itself
/*
resource "aws_route_table" "my_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0" #IP to connect to internet
    gateway_id = aws_internet_gateway.my_vpc_igw.id
  }
}
*/

resource "aws_route_table_association" "my_rta" {
  subnet_id      = aws_subnet.my_subs.id
  route_table_id = aws_route_table.my_rtb.id
}

resource "aws_security_group" "open_22_80" {
  name        = "sg_for_ec2"
  description = "Allow port 22 & 80 inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "Allow port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "open_ssh_http_for_all"
  }
}

resource "aws_instance" "ec2" {
  ami             = "ami-0aa7d40eeae50c9a9"
  subnet_id       = aws_subnet.my_subs.id
  security_groups = [aws_security_group.open_22_80.id]
  instance_type   = "t2.micro"
  key_name        = "win11_key"
  user_data       = <<-EOF
    #! /bin/bash
    sudo yum update -y
    sudo yum install -y httpd
    sudo service httpd start  
    sudo systemctl enable httpd
    #echo "<h1>Welcome to StackSimplify ! AWS Infra created using Terraform in us-east-1 Region</h1>" | sudo tee /var/www/html/index.html
    echo "<h1>Welcome to mgnimbus ! AWS Infra created using Terraform in us-east-1 Region</h1>" > /var/www/html/index.html
  EOF
  #user_data                   = "${path.module}/tf_cert/apache_demo.sh"
  associate_public_ip_address = true #to connect to the instance you need to add this argument, default is false
}

resource "aws_eip" "my_eip" {
  depends_on = [
    aws_internet_gateway.my_vpc_igw
  ]
  instance = aws_instance.ec2.id
  vpc      = true
}

output "eip" {
  value = aws_eip.my_eip.public_ip

}
