locals {
  current_time    = timestamp()
  sas_start_time  = timeadd(local.current_time, "-1h")
  sas_expiry_time = timeadd(local.current_time, "25h")
}

data "azurerm_storage_account_blob_container_sas" "sas_generation" {
  count = var.use_modern ? 0 : 1

  connection_string = var.connection_string
  container_name    = var.container_name
  https_only        = true

  start  = local.sas_start_time
  expiry = local.sas_expiry_time

  permissions {
    read   = true
    add    = true
    create = true
    write  = true
    delete = true
    list   = true
  }
}

resource "null_resource" "generate_modern_sas" {
  count = var.use_modern ? 1 : 0

  # Step 1: Generate the SAS token
  provisioner "local-exec" {
    command = <<EOT
    $storageAccountName = "${var.storage_account_name}"
    $key = "${var.storage_account_key}"
    $containerName = "${var.container_name}"
    $Context = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $key
    $sasToken = New-AzStorageContainerSASToken -Name $containerName -Permission "racwdl" -Protocol HttpsOnly -Context $Context -StartTime  (Get-Date).AddHours(-1) -ExpiryTime (Get-Date).AddHours(25)
    ./scripts/encrypt_sas.ps1 -sasToken $sasToken -key $key -outputPath "./sas_token.enc"
    EOT

    interpreter = ["PowerShell", "-Command"]
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}

# Read the SAS token from the generated file
data "local_file" "sas_token_file" {
  filename   = "./sas_token.enc"
  depends_on = [null_resource.generate_modern_sas]
}

data "external" "decrypt_sas" {
  program = [
    "powershell",
    "-Command",
    "& {./scripts/decrypt_sas.ps1 -filePath './sas_token.enc' -key '${var.storage_account_key}'}"
  ]
  depends_on = [null_resource.generate_modern_sas]
}

output "sas_token" {
  value = data.external.decrypt_sas.result["sas_token"]
}

