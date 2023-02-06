output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.example.website_endpoint
}

output "bucket_id" {
  value = aws_s3_bucket.static_website.id
}
