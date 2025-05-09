provider "aws" {
  region = "us-east-1"
}



terraform {
  backend "s3" {
    bucket = "sctp-ce9-tfstate"
    key    = "module3/lesson2/norman-a1.tfstate" # Suggested naming convention
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.4.0"
}

data "aws_caller_identity" "current" {}

locals {
  name_prefix = split("/", data.aws_caller_identity.current.arn)[1]
  account_id  = data.aws_caller_identity.current.account_id
}

resource "aws_s3_bucket" "s3_tf" {
  # checkov:skip=CKV_AWS_145: "Ensure that S3 buckets are encrypted with KMS by default"
  # checkov:skip=CKV2_AWS_62: "Ensure S3 buckets should have event notifications enabled"
  # checkov:skip=CKV_AWS_21: "Ensure all data stored in the S3 bucket have versioning enabled"
  # checkov:skip=CKV2_AWS_6: "Ensure that S3 bucket has a Public Access block"
  # checkov:skip=CKV_AWS_18: "Ensure the S3 bucket has access logging enabled"
  # checkov:skip=CKV2_AWS_61: "Ensure that an S3 bucket has a lifecycle configuration"
  # checkov:skip=CKV_AWS_144: "Ensure that S3 bucket has cross-region replication enabled"  
  bucket = "${local.name_prefix}-s3-tf-bkt-${local.account_id}"

}
