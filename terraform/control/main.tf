module "api" {
    source = "../module"
    hosted_zone_id = ""
    vpc_id = "vpc-a2dea3c4"
    public_subnet_ids = ["subnet-f19013b9","subnet-6c02b10a","subnet-0cf50856"]
    ssl_cert_arn = ""
}