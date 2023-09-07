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

  index_document {
    suffix = "index.html"
  }
}

#bucket policy to give read access to public
resource "aws_s3_bucket_policy" "crc_bucket_policy" {
  bucket = aws_s3_bucket.crc.id
  policy = data.aws_iam_policy_document.crc_allow_public_access.json
}

data "aws_iam_policy_document" "crc_allow_public_access" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [aws_s3_bucket.crc.arn, "${aws_s3_bucket.crc.arn}/*",]
  }
}