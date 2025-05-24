terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS provider for LocalStack
provider "aws" {
  version                     = "2.7.0"
  region                      = "us-west-2"
  access_key                  = "access_key"
  secret_key                  = "secret_key"
  endpoints {
    s3 = "http://localhost:4566"  # LocalStack default S3 endpoint
    lambda = "http://localhost:4566" # LocalStack default Lambda endpoint
  }
  skip_credentials_validation = true # Optional: Disable credential validation
  skip_requesting_account_id = true
  skip_metadata_api_check = true  # Optional: Disable metadata API check
}
