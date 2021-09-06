terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.56.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

resource "aws_instance" "tf-ec2" {
  ami           = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro"
  key_name      = "ec2_key"
  tags = {
    "Name" = "created-by-tf"
  }
}

resource "aws_s3_bucket" "tf-s3" {
  bucket = "busrawhatsup"
  acl    = "private"

}
