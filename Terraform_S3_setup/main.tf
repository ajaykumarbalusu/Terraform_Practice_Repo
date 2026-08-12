terraform {
  backend "s3" {
    bucket       = "company-tfstate"
    key          = "prod/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true # Native S3 locking (Terraform 1.10+)
    encrypt      = true
  }
}
