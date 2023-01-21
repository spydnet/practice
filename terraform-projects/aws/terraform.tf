terraform {
  backend "s3" {
    bucket = "kodecloud-terraform-state-bucket01"
    key = "projectname/terraform.tfstate"
    region = "us-west-2"
    dynamodb_table = "state-locking"
  }
}