variable "name" {
  description = "(Required) Specifies the name of the Key Vault Secret. Changing this forces a new resource to be created."
  type        = string
  sensitive   = false
}

variable "value" {
  description = "(Required) Specifies the value of the Key Vault Secret. Changing this will create a new version of the Key Vault Secret."
  type        = string
  sensitive   = true
}

variable "key_vault_id" {
  description = "(Required) The ID of the Key Vault where the Secret should be created. Changing this forces a new resource to be created."
}
