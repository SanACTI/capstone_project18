terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Generate a random suffix for unique bucket names
resource "random_id" "suffix" {
  byte_length = 4
}

# Create the S3 bucket
resource "aws_s3_bucket" "example" {
  bucket = "my-gitops-bucket-${random_id.suffix.hex}"

  # Recommended: enforce bucket owner ownership, disables ACLs
  ownership_controls {
    rule {
      object_ownership = "BucketOwnerEnforced"
    }
  }

  # Optional: enable versioning (good for GitOps)
  versioning {
    enabled = true
  }

  # Optional: block all public access (default is safe)
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
