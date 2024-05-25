Import-Module ActiveDirectory

Search-ADAccount -AccountDisabled | Select-Object Name,DistinguishedName

Search-ADAccount -AccountDisabled | Move-ADObject -TargetPath "OU=Disabled user,OU=itflee,DC=itflee,DC=com"


Get-ADuser -Filter {Enabled -eq $true} -SearchBase "OU=Disabled user,OU=itflee,DC=itflee,DC=com" | Disable-ADAccount