module "auth_backend" {
  source  = "app.terraform.io/abcballpark/auth-backend/aws"
  version = "0.1.7"

  name = "main"
}
