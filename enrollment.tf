module "enrollment-backend" {
  source  = "app.terraform.io/abcballpark/enrollment-backend/aws"
  version = "0.1.6"

  api_name = "enrollment-api"
}
