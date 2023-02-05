resource "aws_instance" "ec2_new" {
  ami           = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
  tags = {
    "Name"      = "Mark1"
    "Env"       = "test"
    "ManagedBy" = "Terraform"
  }
}

# resource "aws_s3_bucket" "test" {
#   bucket = "test-bucket-05022023123"
# }

# resource "aws_s3_bucket_acl" "pvt_acl" {
#   bucket = aws_s3_bucket.test.id
#   acl    = "private"
# }

# output "bucket_acl" {
#   value = aws_s3_bucket_acl.pvt_acl.bucket

# }
