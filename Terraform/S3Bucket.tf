resource "aws_s3_bucket" "b" {
  bucket = var.bucket_name

  tags = {
    Name        = "pravisht-wema-terraform-s3-bucket"
    Environment = "Testing"
  }
}