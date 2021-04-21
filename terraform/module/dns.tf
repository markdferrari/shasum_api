resource "aws_route53_record" "alb" {
  zone_id = var.hosted_zone_id
  name    = var.alb_dns_record
  type    = "A"

  alias {
    name                   = aws_alb.alb.dns_name
    zone_id                = aws_alb.alb.zone_id
    evaluate_target_health = true
  }
}
