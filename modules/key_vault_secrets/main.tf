locals {
  secret_activation_time = timeadd(timestamp(), "-1h")
  secret_expiry_time = timeadd(timestamp(), "25h")
}

resource "azurerm_key_vault_secret" "create_kv_secret" {
  name         = var.name
  value        = var.value
  key_vault_id = var.key_vault_id
  not_before_date = local.secret_activation_time
  expiration_date = local.secret_expiry_time
}