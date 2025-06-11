variable "bucket_name" {
  type = string
  description = "bucket name"
}
variable "region" {
  type = string
  description = "The AWS region where the S3 bucket will be created."
  default = "us-east-1"
}