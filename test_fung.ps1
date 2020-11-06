param (
 $blobnpcon, 
 $blobstgcon
)
 
 $sastoken_np=az storage container generate-sas --connection-string "$blobnpcon" --name 99-config --permissions acdlrw --expiry (Get-Date).AddMinutes(59).ToString("yyyy-MM-dTH:mZ") --auth-mode key

 $sastoken_stg=az storage container generate-sas --connection-string "$blobstgcon" --name 99-config --permissions acdlrw --expiry (Get-Date).AddMinutes(59).ToString("yyyy-MM-dTH:mZ") --auth-mode key

Write-Host "##[command] copying test_fung"
azcopy sync "https://gpdl01npseadfdl02.blob.core.windows.net/ADF_DEV/DataFactory/test_fung/?$sastoken_np" "https://gpdl01npseadfstganfield.blob.core.windows.net/99-config/ADF_DEV/DataFactory/test_fung/?$sastoken_stg" --recursive=false --exclude-pattern="*.bak"