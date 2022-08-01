resource "aws_api_gateway_rest_api" "api" {
  name = var.api_name
}

resource "aws_api_gateway_deployment" "dev" {
  rest_api_id = aws_api_gateway_rest_api.api.id

  triggers = {
    redeployment = sha1(jsonencode([
      # Adding things here will influence when the API is re-deployed
      # API Gateway Resource definitions
      module.resource_participant.sha1_output
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "dev" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  deployment_id = aws_api_gateway_deployment.dev.id
  stage_name    = "dev"
}

resource "aws_cloudwatch_log_group" "api_gw_access_log" {
  name = "/aws/api_gateway/enrollment-api/dev"
}

resource "aws_cloudwatch_log_group" "api_gw_execution_log" {
  name = "API-Gateway-Execution-Logs_${aws_api_gateway_rest_api.api.id}/${aws_api_gateway_stage.dev.stage_name}"
}

resource "aws_api_gateway_account" "enrollment_api" {
  cloudwatch_role_arn = aws_iam_role.enrollment_api_logger.arn
}

resource "aws_api_gateway_authorizer" "main" {
  name        = "main"
  type        = "COGNITO_USER_POOLS"
  rest_api_id = aws_api_gateway_rest_api.api.id
  provider_arns = [
    var.user_pool_arn
  ]
}

///////////////////////////////////////////////////////////////////////////////
// API Gateway Resources

module "resource_participant" {
  source = "./terraform-aws-api-resource"
  name   = "participant"

  api_name           = aws_api_gateway_rest_api.api.name
  api_id             = aws_api_gateway_rest_api.api.id
  parent_resource_id = aws_api_gateway_rest_api.api.root_resource_id

  authorizer_id = aws_api_gateway_authorizer.main.id

  # dynamo_table_arn = module.tables.participant_table_arn
  table_attributes = [
    {
      name = "ParticipantId",
      type = "S"
    },
    {
      name = "UserId",
      type = "S"
    },
  ]
  hash_key  = "ParticipantId"
  range_key = "UserId"
}
