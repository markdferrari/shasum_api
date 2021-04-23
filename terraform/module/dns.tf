resource "aws_route53_record" "api_gateway" {
  zone_id = var.hosted_zone_id
  name    = var.api_gateway_dns_record
  type    = "A"

  alias {
    name                   = var.api_gateway_endpoint
    zone_id                = "ZLY8HYME6SFDD"
    evaluate_target_health = false
  }
}

