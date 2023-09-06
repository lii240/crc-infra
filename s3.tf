resource "aws_s3_bucket" "crc" {
  bucket = "crc-frontend"

  tags = {
    Name        = "CRC static website"
    Environment = "Dev"
    Creator     = "LH"
  }
}