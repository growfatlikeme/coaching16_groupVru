# Terraform configuration for AWS DynamoDB table
# Contributed by: Vrushali Bavare
# Created on : 14/07/2025
# Last updated: 16/07/2025
resource "aws_dynamodb_table" "url_shortener_table" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "short_id"
    type = "S"
  }

  hash_key = "short_id"

  tags = {
    Name        = var.dynamodb_table_name
    Environment = "Development"
  }
}

# Terraform configuration for AWS IAM roles and policies
# Contributed by: Estee
# Created on : 14/07/2025
# Last updated: 16/07/2025
resource "aws_iam_role" "lambda_exec" {
  name = "groupVru-lambda-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_exec_role" {
  name = "groupVru-lambda-exec-role-ddbaccess"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "dynamodb:PutItem",
                "dynamodb:UpdateItem",
                "dynamodb:GetItem"
            ],
            "Resource": "${aws_dynamodb_table.url_shortener_table.arn}"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_exec_role.arn
}

# Custom domain name for REST API Gateway
# Route53 records for API Gateway and ACM certificate
# Contributed by: Estee
# Created on : 14/07/2025
# Last updated: 14/07/2025
resource "aws_api_gateway_domain_name" "api" {
  domain_name     = var.domain_name
  certificate_arn = aws_acm_certificate_validation.cert_validation.certificate_arn
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# ACM Certificate for the domain
# Contributed by: Este
# Created on : 14/07/2025
# Last updated: 14/07/2025
resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

# DNS validation record for the certificate
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = data.aws_route53_zone.main.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}

# Certificate validation
resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}

# Route53 A record for the API Gateway
resource "aws_route53_record" "api" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_api_gateway_domain_name.api.regional_domain_name
    zone_id                = aws_api_gateway_domain_name.api.regional_zone_id
    evaluate_target_health = false
  }
}