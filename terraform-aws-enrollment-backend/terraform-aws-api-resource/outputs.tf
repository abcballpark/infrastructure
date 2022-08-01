output "exec_role_name" {
  value = aws_iam_role.exec_role.name
}

output "sha1_output" {
  value = sha1(jsonencode([
    data.archive_file.src_zip.output_base64sha256,
    aws_api_gateway_method.endpoint,
    aws_api_gateway_method_response.endpoint,
    aws_api_gateway_integration.redirect,
    aws_api_gateway_integration_response.response_200,
  ]))
}
