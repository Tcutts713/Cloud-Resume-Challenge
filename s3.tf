resource "aws_s3_bucket" "webBucket" {
  bucket = "cloud-resume-challenge-timcutts"
  policy = file("policy.json")
}

resource "aws_s3_bucket_website_configuration" "webBucket" {
  bucket = aws_s3_bucket.webBucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_ownership_controls" "webBucket" {
  bucket = aws_s3_bucket.webBucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}