output "sha1_output" {
  value = sha1(jsonencode([
    aws_api_gateway_method.endpoint,
    aws_api_gateway_integration.redirect,
  ]))
}
