<# 
.SYNOPSIS
    Will delete HKEY_CLASSES_ROOT\ms-msdt keys according to https://mecm365.com/solution-to-disable-msdt-url-protocol-via-configuration-manager-sccm/ 

.DESCRIPTION
    Will delete HKEY_CLASSES_ROOT\ms-msdt keys according to https://mecm365.com/solution-to-disable-msdt-url-protocol-via-configuration-manager-sccm/ 

.PARAMETER deleteKey
    Will delete HKEY_CLASSES_ROOT\ms-msdt keys according to https://mecm365.com/solution-to-disable-msdt-url-protocol-via-configuration-manager-sccm/ 
    to disable MSDT URL protocol

.PARAMETER backup
    Will backup registry HKEY_CLASSES_ROOT\ms-msdt

.Example
    Disable-MsdtUrl.ps1 # Checks if there is a key
    Disable-MsdtUrl.ps1 -deleteKey # Will delete key HKEY_CLASSES_ROOT\ms-msdt
    Disable-MsdtUrl.ps1 -deleteKey -backup # Will backup keys and delete key HKEY_CLASSES_ROOT\ms-msdt

#>
#Requires -RunAsAdministrator

Param(
    [switch]$deleteKey,
    [switch]$backup
)

if ((Test-Path REGISTRY::HKEY_CLASSES_ROOT\ms-msdt) -eq $true) {
    Write-Host "Key found!"
    if($deleteKey -eq $true){
        Write-Host "Try to delete key... "
        $backupSuccess = $true
        if($backup -eq $true){
            try{
                Write-Host "Creating Backup... "
                $pathForBackup = $env:ProgramData + "\\ServerEye3"
                $pathForBackup = Join-Path -Path $pathForBackup -ChildPath "ms-msdt-backup.reg"   

                Invoke-Command {reg export 'HKEY_CLASSES_ROOT\ms-msdt' $pathForBackup}

                Write-Host "Backup created in " $pathForBackup

            }catch{
                Write-Error "Could not backup Key."
                Write-Error $_
                $backupSuccess = $false
            }
        }
        try{
            if($backupSuccess -eq $true){
                Remove-Item REGISTRY::HKEY_CLASSES_ROOT\ms-msdt -Recurse -Force
                Write-Host "Key deleted."
            }else{
                Write-Error "Key not deleted - backup wasn't successful."
            }
        }catch{
            Write-Error "Could not delete Key."
            Write-Error $_
        }

        
    }else{
        Write-Host "Critical ms-msdt-Key found, no action performed" -ForegroundColor red
    }
} else {
    Write-Host "System clean, no ms-msdt keys found" -ForegroundColor green
}
