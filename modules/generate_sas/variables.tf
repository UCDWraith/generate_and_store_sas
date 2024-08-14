variable "connection_string" {
  description = "The connection string for the storage account to which this SAS applies. Typically directly from the primary_connection_string attribute of a terraform created azurerm_storage_account resource."
  type        = string
  sensitive   = false
}

variable "container_name" {
  description = "Name of the container"
  type        = string
  sensitive   = false
}

variable "use_modern" {
  description = "The Terraform provider cannot currently generate a modern signed version (sv) value. When set as true PowerShell will handle the creation of the SAS token"
  type        = bool
  default     = false
  # https://github.com/hashicorp/terraform-provider-azurerm/issues/6519
  # https://github.com/hashicorp/go-azure-helpers/issues/44
}

variable "storage_account_name" {
  description = "The name of the storage account - used when 'use_modern' is set to True"
  type        = string
}

variable "storage_account_key" {
  description = "The primary_access_key of the storage account - used when 'use_modern' is set to True"
  type        = string
  sensitive   = true
}