param (
  [string]$filePath,
  [string]$key
)

$keyBytes = [System.Convert]::FromBase64String($key)

# Ensure the key is exactly 32 bytes for AES-256
$keyBytes = $keyBytes[0..31]

if ($keyBytes.Length -ne 32) {
  throw "The storage account key is not a valid size for AES-256 encryption. The key must be 256 bits (32 bytes)."
}

# Read the encrypted data
$encryptedData = [System.IO.File]::ReadAllBytes($filePath)

# Set up AES for decryption
$AES = New-Object System.Security.Cryptography.AesManaged
$AES.Key = $keyBytes
$AES.IV = $encryptedData[0..15]  # Extract IV from the file

# Decrypt the data
$decryptor = $AES.CreateDecryptor()
$decryptedBytes = $decryptor.TransformFinalBlock($encryptedData, 16, $encryptedData.Length - 16)
$sasToken = [System.Text.Encoding]::UTF8.GetString($decryptedBytes)

# Output the SAS token as JSON
$output = @{ "sas_token" = $sasToken } | ConvertTo-Json
Write-Output $output
