resource "aws_s3_bucket" "state" {
    bucket = "kodecloud-terraform-state-bucket01"
    force_destroy = true
    tags = {
        Description = "Bucket for storing state files"
    }  
}

# resource "aws_s3_bucket" "finance" {
#     bucket = "finance-16012023"
#     tags = {
#         Description = "Finance and Payroll"
#     }  
# }

# resource "aws_s3_object" "finance-2023" {
#   source = "Networking.pdf"
#   key = "Networking.pdf"
# #   force_destroy = true
#   bucket = aws_s3_bucket.finance.id
# }