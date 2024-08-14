module "storage_account" {
  source               = "./modules/storage_account"
  storage_account_name = var.storage_account_name
  resource_group_name  = var.resource_group_name
  location             = var.location
  container_name       = var.container_name
  tags                 = var.tags
}

module "key_vault" {
  source              = "./modules/key_vault"
  key_vault_name      = var.key_vault_name
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "kv_storage_primary_key" {
  source       = "./modules/key_vault_secrets"
  name         = "primary-access-key"
  value        = module.storage_account.primary_access_key
  key_vault_id = module.key_vault.key_vault_id
}

module "generate_sas" {
  source               = "./modules/generate_sas"
  connection_string    = module.storage_account.storage_account_connection_string
  container_name       = module.storage_account.storage_account_container_name
  use_modern           = var.use_modern
  storage_account_name = module.storage_account.storage_account_name
  storage_account_key  = module.storage_account.primary_access_key
}

module "store_sas" {
  source       = "./modules/key_vault_secrets"
  name         = "storage-account-sas-key"
  value        = module.generate_sas.sas_string
  key_vault_id = module.key_vault.key_vault_id
}

