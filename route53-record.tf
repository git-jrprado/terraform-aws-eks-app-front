data "aws_route53_zone" "selected" {
  name = var.hosted_zone
}

resource "aws_route53_record" "hostname" {
  count = var.hostname_create ? length(var.hostnames) : 0

  zone_id = data.aws_route53_zone.selected.zone_id
  name    = var.hostnames[count.index]
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.default.domain_name
    zone_id                = aws_cloudfront_distribution.default.hosted_zone_id
    evaluate_target_health = true
  }
}
