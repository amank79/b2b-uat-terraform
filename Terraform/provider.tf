terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.7.1"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
  #shared_credentials_files = ["/home/ubuntu/.aws/credentials"]
  #profile = "default"
}
