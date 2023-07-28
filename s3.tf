resource "aws_s3_bucket" "don_bucket_3" {
  bucket = "don-bucket-3"  
}
resource "aws_s3_bucket_versioning" "don_bucket_versioning" {
  bucket = aws_s3_bucket.don_bucket_3.bucket
  versioning_configuration {
    status = "Enabled"
  }
}