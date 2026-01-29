terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
  required_version = ">= 1.0"
}

provider "aws" {
  region = "us-east-1"
}

# Generate random suffix for unique bucket names
resource "random_id" "suffix" {
  byte_length = 4
}

# Create S3 bucket (basic)
resource "aws_s3_bucket" "example" {
  bucket = "my-gitops-bucket-${random_id.suffix.hex}"
}
