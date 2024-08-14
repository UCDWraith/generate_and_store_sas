param (
    [string]$sasToken,
    [string]$key,
    [string]$outputPath
)

# Convert the base64-encoded key into a byte array
$keyBytes = [System.Convert]::FromBase64String($key)

$keyBytes = $keyBytes[0..31]  # Ensure the key is 32 bytes for AES-256

# Ensure the key length is exactly 32 bytes for AES-256
if ($keyBytes.Length -ne 32) {
    throw "The storage account key is not a valid size for AES-256 encryption. The key must be 256 bits (32 bytes)."
}

# Encrypt the SAS token using AES
$AES = New-Object System.Security.Cryptography.AesManaged
$AES.Key = $keyBytes
$AES.GenerateIV()

$encryptor = $AES.CreateEncryptor()
$sasTokenBytes = [System.Text.Encoding]::UTF8.GetBytes($sasToken)
$encryptedBytes = $encryptor.TransformFinalBlock($sasTokenBytes, 0, $sasTokenBytes.Length)

# Combine the IV and the encrypted SAS token and write to the output file
$ivAndEncrypted = $AES.IV + $encryptedBytes
[System.IO.File]::WriteAllBytes($outputPath, $ivAndEncrypted)
$outputPath
