Import-Module ActiveDirectory

$firstname = Read-Host -Prompt "Please Enter Your Name"
$lastname = Read-Host -Prompt "Last Name"
$Password = Read-Host -Prompt "Password" -AsSecureString
$Path = Read-Host -Prompt "Enter The path"
$logonname = Read-Host -Prompt "Enter Logon name"

New-ADUser `
    -Name "$firstname $lastname" `
    -GivenName $firstname `
    -Surname $lastname `
    -AccountPassword $Password `
    -Path $Path `
    -UserPrincipalName "$logonname" `
    -Enabled 1 `
    -ChangePasswordAtLogon 0
