provider aws {
  region = "us-east-2"  # Set the desired AWS region
}

resource aws_s3_bucket my_bucket {
  bucket = "my-terraform-s3zzzz-bucket"  # Ensure this name is globally unique

  tags = {
    Name        = "MyTerraformBucket"
    Environment = "Dev"
  }
}
