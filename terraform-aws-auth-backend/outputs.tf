output "pool_id" {
  value       = aws_cognito_user_pool.main.id
  description = "Identifier for Cognito user pool"
}

output "pool_arn" {
  value       = aws_cognito_user_pool.main.arn
  description = "ARN for Cognito user pool"
}
