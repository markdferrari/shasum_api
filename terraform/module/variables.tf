variable "alb_name" { default = "shasum" }
variable "alb_dns_record" { default = "shasum-api" }
variable "dynamodb_table_name" { default = "main" }
variable "environment" { default = "test" }
variable "vpc_id" {}
variable "public_subnet_ids" { type = list }
variable "hosted_zone_id" {}
variable "runtime" { default = "python3.7" }