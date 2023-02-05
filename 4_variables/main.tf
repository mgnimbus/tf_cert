resource "aws_security_group" "vpc_ssh_http" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"

  dynamic "ingress" {
    for_each = var.ingress_block
    content {
      description = "TLS for VPC"
      from_port   = ingress.value["port"]
      to_port     = ingress.value["port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }

  dynamic "egress" {
    for_each = var.egress_block
    content {
      description = "TLS for VPC"
      from_port   = egress.value["port"]
      to_port     = egress.value["port"]
      protocol    = egress.value["protocol"]
      cidr_blocks = egress.value["cidr_blocks"]
    }
  }
}

resource "aws_instance" "ec2" {
  count                       = var.no_of_instance
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.vpc_ssh_http.id]
  associate_public_ip_address = true #to connect to the instance you need to add this argument, default is false
  #user_data                   = "${path.module}/tf_cert/4_variables/apache_demo.sh"
  tags = var.tags
}

resource "aws_instance" "ec2_count" {
  count                       = length(lookup(var.instance_type_list, var.env))
  ami                         = var.ami_id
  instance_type               = lookup(var.instance_type_list, var.env)[count.index]
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.vpc_ssh_http.id]
  associate_public_ip_address = true #to connect to the instance you need to add this argument, default is false
  #user_data                   = "${path.module}/tf_cert/4_variables/apache_demo.sh"
  tags = var.tags
}


resource "aws_instance" "ec2_for_each" {
  for_each                    = toset(lookup(var.instance_type_list, var.env))
  ami                         = var.ami_id
  instance_type               = each.value
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.vpc_ssh_http.id]
  associate_public_ip_address = true #to connect to the instance you need to add this argument, default is false
  #user_data                   = "${path.module}/tf_cert/4_variables/apache_demo.sh"
  tags = var.tags
}
