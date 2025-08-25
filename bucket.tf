# This is a basic Terraform configuration to demonstrate a public access misconfiguration on an S3 bucket,
# with the added vulnerability of hard-coded secrets.
# It is intended for educational and testing purposes only.

# Configure the AWS provider
# Replace "us-east-1" with your desired region if needed.
provider "aws" {
  region = "us-east-1"
}

# Create a public S3 bucket
# The bucket name must be globally unique.
resource "aws_s3_bucket" "bad_bucket" {
  # This bucket name is a placeholder, you must change it to something unique.
  bucket = "my-public-iac-test-bucket-with-secrets-placeholder"
}

# This resource block is where the misconfiguration is introduced.
# We are creating an explicit 'aws_s3_bucket_public_access_block' resource
# and setting all its public access block properties to 'false'.
resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.bad_bucket.id
  
  # These lines are the misconfiguration.
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# This is a hard-coded secret.
# In a real-world scenario, you would never store credentials like this.
# This resource is for IaC testing purposes only.
# resource "aws_iam_user" "bad_user" {
  # name = "test-user-with-hardcoded-secret"
  
  # WARNING: Do not use this in a real environment.
  # This section hard-codes sensitive data for secret scanning tests.
  # A real key should be dynamically generated and managed securely.
  # access_key_id = "AKIAQEFZUWXMJNQDPPPZ"
  # secret_access_key = "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"
# }

# Output the bucket name and ARN for verification.
output "bucket_name" {
  value = aws_s3_bucket.bad_bucket.bucket
}

# output "bucket_arn" {
#   value = aws_s3_bucket.bad_bucket.arn
# }

output "bad_user_name" {
  value = aws_iam_user.bad_user.name
}
