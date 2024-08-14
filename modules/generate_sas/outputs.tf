output "sas_string" {
  value = var.use_modern ? data.external.decrypt_sas.result["sas_token"] : data.azurerm_storage_account_blob_container_sas.sas_generation[0].sas
}
