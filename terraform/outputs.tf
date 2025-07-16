# Output the retrieved URL
output "domain_url" {
  description = "The domain URL"
  value       = "https://${data.aws_route53_record.url.name}"
}

output "zone_name_servers" {
  description = "Name servers for the hosted zone"
  value       = data.aws_route53_zone.main.name_servers
}

output "api_url" {
  value = "${aws_api_gateway_deployment.deployment.invoke_url}/newurl"
}