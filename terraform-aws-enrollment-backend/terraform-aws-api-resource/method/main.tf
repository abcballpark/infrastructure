resource "aws_api_gateway_method" "endpoint" {
  rest_api_id   = var.api_id
  resource_id   = var.resource_id
  http_method   = var.http_method
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = var.authorizer_id
}

resource "aws_api_gateway_integration" "redirect" {
  rest_api_id             = var.api_id
  resource_id             = var.resource_id
  http_method             = var.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.fn_invoke_arn

  depends_on = [
    aws_api_gateway_method.endpoint
  ]
}
