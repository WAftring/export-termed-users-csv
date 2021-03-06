#This script will take the input date and output it as a CSV in C:/
#Please Follow the date formatting

$SD = (Read-Host -Prompt 'Input Date as mm-dd-yyyy')
$Start_Date = [DateTime]::Parse($SD)
$Date_Diff = New-TimeSpan -start $Start_Date -End (Get-Date)
$datediffnumber = "-" + $Date_Diff.Days
Get-ADUser -LDAPFilter {(useraccountcontrol:1.2.840.113556.1.4.803:=2)} -Properties whenChanged | Where-Object {$_.whenChanged -gt (Get-Date).AddDays($datediffnumber)} | Select-Object Name, @{Name='Term Date';Expression={$_.whenChanged}} | Export-csv c:\TermedUsers$SD.csv 