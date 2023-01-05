terraform {
  backend "s3" {
    bucket = "terraform-state-cloud-resume-challenge"
    key    = "s3-website-terraform.tfstate"
    region = "us-east-2"
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region = var.region
}

#S3 Bucket for production
resource "aws_s3_bucket" "cloud-resume-challenge" {
  bucket = "${var.bucket_name}"

  tags = {
    Name = "crc"
  }

}

resource "aws_s3_bucket_website_configuration" "cloud-resume-challenge" {
  bucket = aws_s3_bucket.cloud-resume-challenge.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_acl" "cloud-resume-challenge" {
  bucket = aws_s3_bucket.cloud-resume-challenge.id

  acl = "public-read"
}

resource "aws_s3_bucket_policy" "cloud-resume-challenge" {
  bucket = aws_s3_bucket.cloud-resume-challenge.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.cloud-resume-challenge.arn,
          "${aws_s3_bucket.cloud-resume-challenge.arn}/*",
        ]
      },
    ]
  })
}

#Configure subdomain
resource "aws_s3_bucket" "cloud-resume-challenge-www" {
  bucket = "www.${var.bucket_name}"

  tags = {
    Name = "crc"
  }

}
resource "aws_s3_bucket_website_configuration" "cloud-resume-challenge-www" {
  bucket = aws_s3_bucket.cloud-resume-challenge-www.id

  redirect_all_requests_to {
    host_name = "www.${var.domain_name}"
    protocol  = "https"
  }
  

}

#S3 Bucket for dev/testing
resource "aws_s3_bucket" "cloud-resume-challenge-dev" {
  bucket = "jt-cloud-resume-challenge-website-dev"

  tags = {
    Name = "crc"
  }
  
}

resource "aws_s3_bucket_website_configuration" "cloud-resume-challenge-dev" {
  bucket = aws_s3_bucket.cloud-resume-challenge-dev.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_acl" "cloud-resume-challenge-dev" {
  bucket = aws_s3_bucket.cloud-resume-challenge-dev.id

  acl = "public-read"
}

resource "aws_s3_bucket_policy" "cloud-resume-challenge-dev" {
  bucket = aws_s3_bucket.cloud-resume-challenge-dev.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.cloud-resume-challenge-dev.arn,
          "${aws_s3_bucket.cloud-resume-challenge-dev.arn}/*",
        ]
      },
    ]
  })
}