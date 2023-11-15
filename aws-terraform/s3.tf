resource "aws_s3_bucket" "logs" {
  bucket = "my-app-logs-bucket"  # Replace with a unique bucket name
  acl    = "private"

  # Server-side encryption configuration
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  # Bucket versioning
  versioning {
    enabled = true
  }

  # Lifecycle rules, if needed (e.g., for log rotation)
  lifecycle_rule {
    enabled = true

    expiration {
      days = 90  # Number of days to keep the logs
    }

    noncurrent_version_expiration {
      days = 30
    }
  }

  # Logging configuration
  logging {
    target_bucket = aws_s3_bucket.log_destination.bucket
    target_prefix = "log/"
  }

  tags = {
    Name        = "AppLogs"
    Environment = "Production"
  }
}

resource "aws_s3_bucket" "log_destination" {
  bucket = "my-app-log-destination"  # Replace with a unique bucket name
  acl    = "log-delivery-write"
}
