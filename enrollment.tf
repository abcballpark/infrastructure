module "enrollment-backend" {
  # source  = "app.terraform.io/abcballpark/enrollment-backend/aws"
  # version = "0.1.33"

  source = "./terraform-aws-enrollment-backend"

  api_name      = "enrollment-api"
  user_pool_arn = module.auth_backend.pool_arn
}
