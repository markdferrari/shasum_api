variable "api_gateway_dns_record" { default = "api" }
variable "api_gateway_endpoint" { default = "d-qg8j337jka.execute-api.eu-west-1.amazonaws.com." }
variable "dynamodb_table_name" { default = "main" }
variable "environment" { default = "test" }
variable "vpc_id" {}
variable "public_subnet_ids" { type = list }
variable "hosted_zone_id" {}
variable "runtime" { default = "python3.7" }
variable "ssl_cert_arn" {}