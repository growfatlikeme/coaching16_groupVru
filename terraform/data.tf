# Route53 data source for the hosted zone
data "aws_route53_zone" "main" {
  name         = "sctp-sandbox.com"
  private_zone = false
}
