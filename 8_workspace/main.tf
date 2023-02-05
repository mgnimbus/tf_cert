resource "aws_instance" "ec2_new" {
  count         = terraform.workspace == "default" ? 2 : 1
  ami           = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
  tags = {
    "Name" = "Mark-${terraform.workspace}-${count.index}"
  }
}

output "Ids" {
  value = aws_instance.ec2_new[*].id
}

output "Names" {
  value = aws_instance.ec2_new[*].tags["Name"]
}
