# This is a basic Terraform configuration to demonstrate a public access misconfiguration on an S3 bucket.
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
  # For example: "my-bad-iac-test-bucket-12345"
  bucket = "my-public-iac-test-bucket-placeholder"
  
  # The explicit 'depends_on' has been removed to fix the circular dependency.
  # Terraform will correctly infer the dependency from the 'aws_s3_bucket_public_access_block' resource.
}

# This resource block is where the misconfiguration is introduced.
# We are creating an explicit 'aws_s3_bucket_public_access_block' resource
# and setting all its public access block properties to 'false'.
resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.bad_bucket.id
  
  # These lines are the misconfiguration. Setting them to 'false' disables
  # public access controls.
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Output the bucket name and ARN for verification.
output "bucket_name" {
  value = aws_s3_bucket.bad_bucket.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.bad_bucket.arn
}
