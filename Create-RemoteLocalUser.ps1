Param(
    [Parameter(Mandatory=$True,ValueFromPipelineByPropertyName)]
    [String]$RemoteAdminName,
    [Parameter(Mandatory=$True,ValueFromPipelineByPropertyName)]
    [String]$RemoteAdminPassword,
    [Parameter(Mandatory=$True,ValueFromPipelineByPropertyName)]
    [String]$ComputerName,
    [Parameter(Mandatory=$True,ValueFromPipelineByPropertyName)]
    [String]$NewUserName,
    [Parameter(Mandatory=$True,ValueFromPipelineByPropertyName)]
    [String]$NewUserPassword
)

# Converting admin login to PSCredential

[SecureString]$RemoteAdminPassword = ConvertTo-SecureString $RemoteAdminPassword -AsPlainText -Force
$Creds = New-Object System.Management.Automation.PSCredential($RemoteAdminName, $RemoteAdminPassword)

# Skipping check for the certificate and the computer name
$pso = New-PsSessionOption -SkipCACheck -SkipCNCheck

Write-Host "Creating local user $NewUserName on $ComputerName"

Invoke-Command -ComputerName $ComputerName -Credential $Creds -SessionOption $pso -UseSSL -ScriptBlock {param($NewUserName,$NewUserPassword) NET USER $NewUserName $NewUserPassword /ADD /Y /logonpasswordchg:yes} -ArgumentList $NewUserName, $NewUserPassword

Write-Host "Creating the user $NewUserName to `"Remote Desktop Users group`""

Invoke-Command -ComputerName $ComputerName -Credential $Creds -SessionOption $pso -UseSSL -ScriptBlock {param($NewUserName) NET LOCALGROUP "Remote Desktop Users" $NewUserName /ADD} -ArgumentList $NewUserName
