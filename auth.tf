module "auth-backend" {
  source  = "app.terraform.io/abcballpark/auth-backend/aws"
  version = "0.1.0"

  name = "main"
}
