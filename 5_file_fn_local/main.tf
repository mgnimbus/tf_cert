resource "aws_instance" "ec2" {
  ami                         = "ami-0aa7d40eeae50c9a9"
  instance_type               = "t2.micro"
  key_name                    = "win11_key"
  user_data                   = file("${path.module}/apache_demo.sh") #"${path.module}/tf_cert/5_file_fn/apache_demo.sh"
  associate_public_ip_address = true                                  #to connect to the instance you need to add this argument, default is false
  tags                        = local.default_tags
}

locals {
  tags_t = {
    Owner = "${var.tags["Owner"]}"
    Env   = "${var.tags["Env"]}"
    Name  = "${var.tags["Owner"]}-${var.tags["Env"]}"
  }
}

variable "tags" {
  type = map(string)
  default = {
    Owner = "gowtham"
    Env   = "dev"
  }
}

variable "agent" {
  default = "007"
}

variable "environment" {
  default = "JBond"
}

variable "costcenter" {
  default = "moneypenny"
}

locals {
  default_tags = {
    environment = var.environment
    agent       = var.agent
    costcenter  = var.costcenter
    Name        = join("-", [var.environment, var.agent])


  }
}
