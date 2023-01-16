resource "aws_s3_bucket" "finance" {
    bucket = "finance-16012023"
    tags = {
        Description = "Finance and Payroll"
    }  
}

resource "aws_s3_object" "finance-2023" {
  source = "Warp.dmg"
  key = "Warp.dmg"
#   force_destroy = true
  bucket = aws_s3_bucket.finance.id
}