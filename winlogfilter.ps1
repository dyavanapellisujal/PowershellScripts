#This script is to filter logs based on useraccount tried and failed by the account and the ID through which it failed.


$XMLFILTER=@'
   
   <QueryList>
  <Query Id="0" Path="Security">
    <Select Path="Security">*[System[(Level=1  or Level=2 or Level=3 or Level=4 or Level=0 or Level=5) and (EventID=4625)]]</Select>
  </Query>
</QueryList>
    
'@

$Events = Get-WinEvent -FilterXml $XMLFILTER

$LogEntry=[System.Collections.ArrayList]@()

ForEach($Event in $Events){
    #The following for loop is for getting the index value of all the properties output by Event.properties
    #Foreach($x in 0..$Event.Properties.Count){
     #       Write-Host "$x - " $Event.Properties[$x].value
    #}
    $log = New-Object -TypeName psobject
    $Usernametried=$Event.Properties[5].Value
    $DomainTried=$Event.Properties[6].Value
    $ClientNameFrom=$Event.Properties[13].Value
    $ClientIPform=$Event.Properties[19].Value

    Add-Member -InputObject $log -MemberType NoteProperty -Name "UsernameTried" -Value $Usernametried
    Add-Member -InputObject $log -MemberType NoteProperty -Name "DomainTried" -Value $Domaintried
    Add-Member -InputObject $log -MemberType NoteProperty -Name "ClientNameFrom" -Value $ClientNameFrom
    Add-Member -InputObject $log -MemberType NoteProperty -Name "ClientIPFrom" -Value $ClientIPfromm

    [void]$LogEntry.Add($log)
}

$log #filter the output with your requirement.