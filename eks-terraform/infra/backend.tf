# Why?
# Remote state lets teams collaborate safely and locks state during applies.

# terraform {
#   backend "s3" {
#     bucket         = "my-tf-state-bucket"
#     key            = "eks-terraform/terraform.tfstate"
#     region         = "us-west-1"
#     dynamodb_table = "tf-locks"
#     encrypt        = true
#   }
# }
