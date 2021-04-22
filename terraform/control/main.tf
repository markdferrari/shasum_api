module "api" {
  source            = "../module"
  hosted_zone_id    = "Z06327397CWW2Y5ES995"
  vpc_id            = "vpc-a2dea3c4"
  public_subnet_ids = ["subnet-f19013b9", "subnet-6c02b10a", "subnet-0cf50856"]
  ssl_cert_arn      = "arn:aws:acm:eu-west-1:632700996244:certificate/f335c671-4d4b-409c-ae1f-6417a4ceac06"
}