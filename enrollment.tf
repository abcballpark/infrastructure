module "enrollment-backend" {
  source  = "app.terraform.io/abcballpark/enrollment-backend/aws"
  version = "0.1.4"
  tf_org = local.tf_org

  api_name = "enrollment-api"
}
