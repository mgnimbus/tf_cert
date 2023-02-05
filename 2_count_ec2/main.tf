resource "aws_instance" "ec2_count" {
  count         = 2
  ami           = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
  tags = {
    "Name" = "test_ec2_${count.index}"
  }
}

output "ec2_count" {
  value = aws_instance.ec2_count[*].tags["Name"]
}

output "volume_id" {
  value = aws_instance.ec2_count[*].root_block_device[0].volume_id
}

output "rbs" {
  value = aws_instance.ec2_count[*].root_block_device[0]
}

