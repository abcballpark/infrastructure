resource "aws_lambda_function" "endpoint_fn" {
  function_name = "${var.api_name}-${var.name}"

  # s3_bucket = data.archive_file.src_zip.id
  s3_bucket = aws_s3_bucket.src.id
  s3_key    = aws_s3_object.src_zip.key

  runtime = "nodejs16.x"
  # handler = var.handler
  handler = "index.handler"

  # source_code_hash = var.src_hash
  source_code_hash = data.archive_file.src_zip.output_base64sha256

  role = aws_iam_role.exec_role.arn
}

resource "aws_lambda_permission" "allow_api_gateway" {
  function_name = aws_lambda_function.endpoint_fn.function_name
  principal     = "apigateway.amazonaws.com"
  action        = "lambda:InvokeFunction"
}

resource "aws_cloudwatch_log_group" "endpoint_fn_exec_log" {
  name = "/aws/lambda/${var.api_name}-${var.name}"
}