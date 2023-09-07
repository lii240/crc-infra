resource "aws_s3_bucket" "crc" {
  bucket = var.bucketName

  tags = {
    Name        = "CRC static website"
    Environment = "Dev"
    Creator     = "LH"
  }
}

#s3 static website configuration
resource "aws_s3_bucket_website_configuration" "crc_config" {
  bucket = aws_s3_bucket.crc.id

  index_document = {
    suffix = "index.html"
  }
}

#bucket policy to give read access to public
resource "aws_s3_bucket_policy" "crc_bucket_policy" {
  bucket = aws_s3_bucket.crc.id
  policy = templatefile("json/crc-bucket-policy.json")
}