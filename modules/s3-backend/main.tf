# CREATE THE S3 BUCKET
resource "aws_s3_bucket" "terraform_place" {
  bucket = "rude-name-for-terraform-bucket-s3"
  # Enable versioning state files

  versioning {
    enabled = true
  }
  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# CREATE THE DYNAMODB TABLE
resource "aws_dynamodb_table" "terraform_locked" {
  name         = "terraform-up"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
