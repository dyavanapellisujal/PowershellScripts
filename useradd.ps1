Import-Module ActiveDirectory

$file = Read-Host -Prompt "Enter the Path to Csv File containing user account information"

$users = Import-Csv $file

ForEach ($user in $users) {
    $accountnumber= verifyusername($user.'FirstName'[0] + $user.LastName)
    $username=($user.'FirstName'[0]+$user.LastName+ $accountnumber)
    New-ADUser `
    -Name ($user.'FirstName ' + " " + $user.LastName )`
    -GivenName ($user.'FirstName ')`
    -Surname ($user.LastName)`
    -UserPrincipalName $username `
    -SamAccountName $username `
    -Path $user.OrganizationalUnit`
    -Enabled ([System.Convert]::ToBoolean($user.Enabled))


}


function verifyusername($username){
    $i=1
    if(usernametaken($username) -eq $true){
        while (usernametaken($username + $i) -eq $true){
            $i++

        }else{
            return ""
        }
        return $i
    }
    
}

function usernametaken($usernname){

    $test1= Get-ADuser -Filter { UserPrincipalname -eq $usernname }
    $test2= Get-Aduser -Filter { SamAccountName -eq $usernname }

    if($test1 -eq $Null -and $test2 -eq $Null){
        return false

    } else {
        return true
     }

}

