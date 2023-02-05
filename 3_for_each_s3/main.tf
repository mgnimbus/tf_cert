resource "aws_s3_bucket" "my_buckys" {
  for_each = toset(["ramu", "sommu"])
  bucket   = "test-s3-bucky-${each.key}"
}

resource "aws_s3_bucket_acl" "pvt_acl" {
  for_each = toset(["ramu", "sommu"])
  bucket   = aws_s3_bucket.my_buckys[each.key].id
  acl      = "private"
}


resource "aws_s3_bucket" "my_map_buckys" {
  for_each = {
    dev  = "my-dev-bucket-123"
    prod = "my-prod-bucket-123"
  }
  bucket = "map-test-s3-bucky-${each.value}"
}

output "for_loop_ids" {
  value = [for i in aws_s3_bucket.my_buckys : i.id]
}


output "map_ids" {
  value = [for i in aws_s3_bucket.my_map_buckys : i.id]
}
resource "random_string" "randy" {
  for_each = toset(["ramu", "sommu"])
  length   = "4"
  special  = false
  lower    = true
}

output "randys" {
  value = [for i in random_string.randy : i.id]
}

#how to add random_string to for_loop
resource "aws_s3_bucket" "my_buckys-random" {
  for_each = toset(["one", "two"])
  bucket   = join("-", ["test-s3-bucky-${each.key}", "${random_string.randy["ramu"].id}"])

  #bucket   = join("-", ["test-s3-bucky-${each.key}", [for i in random_string.randy : i[*].id]])
  #bucket = join("-", ["test-s3-bucky-${each.key}", "${random_string.randy[each.value].id}"])
}
