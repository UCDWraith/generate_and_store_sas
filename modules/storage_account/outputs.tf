output "storage_account_name" {
  description = "The name of the storage account"
  value       = data.azurerm_storage_account.storage_account.name
}

output "storage_account_connection_string" {
  description = "The connection string of the storage account"
  value       = data.azurerm_storage_account.storage_account.primary_connection_string
}

output "primary_access_key" {
  description = "The primary access key of the storage account"
  value       = data.azurerm_storage_account.storage_account.primary_access_key
  sensitive   = true
}

output "storage_account_container_name" {
  description = "The name of the container within the storage account"
  value       = data.azurerm_storage_container.container.name
}