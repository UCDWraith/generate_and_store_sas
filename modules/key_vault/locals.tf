locals {
  current_user_id = coalesce(var.msi_id, data.azurerm_client_config.current.object_id)
}