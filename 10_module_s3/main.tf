module "static_website_s3" {
  source        = "./static_website"
  bucket        = "test-this-website-123456"
  key           = "index.html"
  object_source = "${path.module}/index.html"
}

output "website_endpoint" {
  value = "http://${module.static_website_s3.website_endpoint}"
}

output "website_id" {
  value = module.static_website_s3.bucket_id
}

