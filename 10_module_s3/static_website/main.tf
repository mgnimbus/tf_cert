resource "aws_s3_bucket" "static_website" {
  bucket = var.bucket
}
resource "aws_s3_bucket_acl" "static_website_acl" {
  bucket = aws_s3_bucket.static_website.id
  acl    = var.acl
}
resource "aws_s3_bucket_policy" "static_website_policy" {
  bucket = var.bucket
  policy = data.aws_iam_policy_document.static_website_policy.json
}
data "aws_iam_policy_document" "static_website_policy" {
  depends_on = [
    aws_s3_bucket.static_website
  ]
  statement {
    sid       = "PublicReadGetObject"
    effect    = "Allow"
    resources = ["arn:aws:s3:::${var.bucket}/*"]
    actions   = ["s3:GetObject"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}
resource "aws_s3_object" "object" {
  depends_on = [
    aws_s3_bucket.static_website
  ]
  bucket       = var.bucket
  key          = var.key
  source       = var.object_source
  content_type = "text/html"
  etag         = filemd5(var.object_source)
}

resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.static_website.bucket

  index_document {
    suffix = var.key
  }

  error_document {
    key = "error.html"
  }
}


