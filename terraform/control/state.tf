terraform {
  backend "s3" {
    bucket = "632700996244-markdferrari-terraform-state"
    key    = "api/terraform.tfstate"
    region = "eu-west-1"
  }
}
