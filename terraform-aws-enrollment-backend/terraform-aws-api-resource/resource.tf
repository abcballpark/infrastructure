resource "aws_api_gateway_resource" "endpoint" {
  path_part   = var.name
  parent_id   = var.parent_resource_id
  rest_api_id = var.api_id
}

module "integrations" {
  source = "./method"

  for_each = toset(["POST", "GET"])

  api_id        = var.api_id
  resource_id   = aws_api_gateway_resource.endpoint.id
  http_method   = each.key
  authorizer_id = var.authorizer_id
  fn_invoke_arn = aws_lambda_function.endpoint_fn.invoke_arn
}

# resource "aws_api_gateway_method" "endpoint" {
#   rest_api_id   = var.api_id
#   resource_id   = aws_api_gateway_resource.endpoint.id
#   http_method   = "POST"
#   authorization = "COGNITO_USER_POOLS"
#   authorizer_id = var.authorizer_id
# }

# resource "aws_api_gateway_integration" "redirect" {
#   rest_api_id             = var.api_id
#   resource_id             = aws_api_gateway_resource.endpoint.id
#   http_method             = aws_api_gateway_method.endpoint.http_method
#   integration_http_method = "POST"
#   type                    = "AWS_PROXY"
#   uri                     = aws_lambda_function.endpoint_fn.invoke_arn
# }

# resource "aws_api_gateway_integration_response" "response_200" {
#   rest_api_id = var.api_id
#   resource_id = aws_api_gateway_resource.endpoint.id
#   http_method = aws_api_gateway_method.endpoint.http_method
#   status_code = "200"

#   depends_on = [
#     aws_api_gateway_integration.redirect
#   ]
# }

# resource "aws_api_gateway_method_response" "endpoint" {
#   rest_api_id = var.api_id
#   resource_id = aws_api_gateway_resource.endpoint.id
#   http_method = aws_api_gateway_method.endpoint.http_method
#   status_code = aws_api_gateway_integration_response.response_200.status_code
# }
