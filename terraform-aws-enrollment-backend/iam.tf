data "aws_iam_policy_document" "enrollment_api_logger_role_policy_cloudwatch" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
      "logs:GetLogEvents",
      "logs:FilterLogEvents"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "enrollment_api_logger_role_policy_doc" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }
    actions = [
      "sts:AssumeRole"
    ]
  }
}
resource "aws_iam_role" "enrollment_api_logger" {
  name               = "enrollment-api-logger"
  assume_role_policy = data.aws_iam_policy_document.enrollment_api_logger_role_policy_doc.json
}

resource "aws_iam_role_policy" "enrollment_api_logger_policy_1" {
  role   = aws_iam_role.enrollment_api_logger.id
  policy = data.aws_iam_policy_document.enrollment_api_logger_role_policy_cloudwatch.json
}
