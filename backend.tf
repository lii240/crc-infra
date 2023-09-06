terraform {
  backend "s3" {
    bucket         = "crc-backend"
    key            = "terraform.tfstate"
    region         = "eu-west-2"
  }
}