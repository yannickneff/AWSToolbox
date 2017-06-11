# AWSToolbox
Set-NetFirewallProfile -Profile * -Enabled False
Import-Module ServerManager
Add-Content -Path "c:\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\set_proxy.cmd" -Value 'Reg Add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d http://internal-gts-ciap-elbSvcBr-S5WM1CPI2JG4-1604418959.eu-west-1.elb.amazonaws.com:8080 /f'
Add-Content -Path "c:\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\set_proxy.cmd" -Value 'Reg Add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 00000001 /f'
Add-Content -Path "c:\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\set_proxy.cmd" -Value 'Reg Add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main" /v "start page" /t REG_SZ /d http://www.facebook.com /f'
Add-WindowsFeature -Name RDS-RD-Server -IncludeAllSubFeature
