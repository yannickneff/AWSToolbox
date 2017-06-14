Param(    [Parameter(Mandatory=$False,ValueFromPipelineByPropertyName)]    [Switch]$RemoveHTTPListeners = $False,    [Parameter(Mandatory=$True,ValueFromPipelineByPropertyName)]    [String]$DnsName #Should be the ip address)
# Enable ps remoting will set um wsman service and create listener we will delete later# SkipNetworkCheck avoid error if the network type is publicEnable-PSRemoting -SkipNetworkProfileCheck -Force
if ($RemoveHTTPListeners) {    # Removing the http listeners    Get-ChildItem WSMan:\Localhost\listener | Where -Property Keys -eq "Transport=HTTP" | Remove-Item -Recurse}
$Certificate = New-SelfSignedCertificate -CertstoreLocation "Cert:\LocalMachine\My" -DnsName $DnsName
# Creating a listener using the certificateNew-Item -Path WSMan:\LocalHost\Listener -Transport HTTPS -Address * -CertificateThumbPrint $Certificate.Thumbprint -Force
# Creating a https firewall exceptionNew-NetFirewallRule -DisplayName "Windows Remote Management (HTTPS-In)" -Name "WINRM-HTTPS-In-TCP" -Profile Any -LocalPort 5986 -Protocol TCP
Set-Item WSMan:\localhost\Service\EnableCompatibilityHttpsListener -Value true
Write-Host 'Disabling "Windows Remote Management (HTTP-In)" network firewall rule'
Disable-NetFirewallRule -DisplayName "Windows Remote Management (HTTP-In)"
