variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resources"
  type        = string
}

variable "container_name" {
  description = "The name of the storage container"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to the resources"
  type        = map(string)
  default     = {}
}

variable "key_vault_name" {
  description = "The name of the Key Vault"
  type        = string
}

variable "use_modern" {
  description = "The Terraform provider cannot currently generate a modern signed version (sv) value. When set as true PowerShell will handle the creation of the SAS token"
  type        = bool
  default     = false
  # https://github.com/hashicorp/terraform-provider-azurerm/issues/6519
  # https://github.com/hashicorp/go-azure-helpers/issues/44
}