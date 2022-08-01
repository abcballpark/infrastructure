data "aws_iam_policy_document" "lambda_exec_policy" {
  version = "2012-10-17"
  statement {
    sid     = ""
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "exec_role" {
  name               = "${var.api_name}-${var.name}-executor"
  assume_role_policy = data.aws_iam_policy_document.lambda_exec_policy.json
}

resource "aws_iam_role_policy_attachment" "exec_role_policy_1" {
  role       = aws_iam_role.exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "aws_iam_policy_document" "dynamodb_rw" {
  statement {
    effect = "Allow"
    actions = [
      "dynamodb:PutItem",
      "dynamodb:GetItem",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem",
      "dynamodb:BatchGetItem",
    ]
    resources = [var.dynamo_table_arn]
    # resources = [module.tables.dynamo_table_arn]
  }
}

resource "aws_iam_policy" "dynamodb_rw" {
  name   = "${var.api_name}-${var.name}-dynamodb-rw"
  policy = data.aws_iam_policy_document.dynamodb_rw.json
}

resource "aws_iam_role_policy_attachment" "participant_dynamo_rw" {
  role = aws_iam_role.exec_role.name
  #   role = module.resource_participant.exec_role_name
  policy_arn = aws_iam_policy.dynamodb_rw.arn
}
