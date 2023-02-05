/*
resource "aws_instance" "ec2_for_each_az" {
  for_each      = var.azs
  ami           = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
  tags = {
    "Name" = join("_", ["my_ec2", replace("${each.value}", "-", "_")])
  }

}
variable "azs" {
  default = {
    az1 = "us-east-1a",
    az2 = "us-east-1b"
  }

}

output "Names_splat" {
  value = [for i in aws_instance.ec2_for_each_az : i.tags[*]["Name"]]
}

output "volume_id" {
  value = [for i in aws_instance.ec2_for_each_az : i.root_block_device[0].volume_id]
}

output "ec2_id" {
  value = [for i in aws_instance.ec2_for_each_az : i.id]
}

#Need to work how to make this work
# output "ec2_id-----volume_id" {
#   value = [for i in aws_instance.ec2_for_each_az : join("----", [i.tags[0].Name, i.root_block_device[0].volume_id, ])]
# }

*/
