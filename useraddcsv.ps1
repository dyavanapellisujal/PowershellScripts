Import-Module ActiveDirectory

$file = Read-Host -Prompt "Enter the Path to Csv File containing user account information"

$users = Import-Csv $file

ForEach ($user in $users) {
    
    New-ADUser `
    -Name ($user.'FirstName ' + " " + $user.LastName )`
    -GivenName ($user.'FirstName ')`
    -Surname ($user.LastName)`
    -UserPrincipalName ($user.'FirstName '+ "." + $user.LastName)`
    -Path $user.OrganizationalUnit`
    -Enabled ([System.Convert]::ToBoolean($user.Enabled))


}