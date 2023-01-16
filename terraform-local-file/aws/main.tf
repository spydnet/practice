provider "aws" {
  region = "us-west-2"
  # access_key = "test"
  # secret_key = "test"
}

resource "aws_iam_user" "admin-user" {
  name = "lucy"
  tags = {
    Description = "Technical Team leader"
  }
}