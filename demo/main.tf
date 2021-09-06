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
locals {
  instance-name = "oliver-local-name"
}
resource "aws_instance" "tf-ec2" {
  ami           = var.ec2-ami
  instance_type = var.ec2-type
  key_name      = "oliver"
  tags = {
    "Name" = "${local.instance-name}-come from locals"
  }
}
resource "aws_s3_bucket" "tf-s3" {
  bucket = "${var.s3-bucket-name}-${count.index + 1}"
  acl    = "private"
  # count = var.num_of_buckets
  count = var.num_of_buckets != 0 ? var.num_of_buckets : 3
}
resource "aws_iam_user" "new_users" {
  for_each = toset(var.users)
  name = each.value
}
output "tf-example-public-ip" {
  value = aws_instance.tf-ec2.public_ip
}
# output "tf-example-s3-meta" {
#   value = aws_s3_bucket.tf-s3.region
# }
output "tf-example-private-ip" {
  value = aws_instance.tf-ec2.private_ip
}
# output "tf-example-s3" {
#   value = aws_s3_bucket.tf-s3[*]
# }
