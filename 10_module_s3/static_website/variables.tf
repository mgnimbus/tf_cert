variable "bucket" {
  type    = string
  default = "test-bucket-05022023"
}

variable "acl" {
  type    = string
  default = "public-read"
}

variable "key" {
  type    = string
  default = "index.html"
}

variable "object_source" {
  type    = string
  default = "./index.html"
}
