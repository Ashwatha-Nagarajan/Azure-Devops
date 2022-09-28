data "aws_secretsmanager_secret_version" "db_cred" {
  secret_id     = "db-secrets"
}
