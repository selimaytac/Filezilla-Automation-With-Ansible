
$SqlServer = "<SQL SERVER IP>"
$SqlDb = "<SQL SERVER DB NAME>"
$SqlUsername = "<SQL USERNAME>"
$SqlPassword = "<SQL PASSWORD>"

$Path = "C:\Windows\System32\config\systemprofile\AppData\Local\filezilla-server\users.xml"
[xml] $xml = Get-Content $Path
$computerName = hostname

$DeleteExistRecordsSql = "DELETE FROM <TABLE NAME> WHERE ComputerName = '$computerName'"
Invoke-Sqlcmd -Query $DeleteExistRecordsSql -ServerInstance $SqlServer -Database $SqlDb -Username $SqlUsername -Password $SqlPassword

foreach($user in $xml.filezilla.user) {
    if($user.name.Trim() -ne "<system user>") {
        $obj = New-Object PSObject -Property @{
            UserName = $user.name.Trim()
            MountPoint = $user.mount_point.native_path.Trim()
            Description = $user.description.Trim()
            ComputerName = $computerName
        }
        $SqlQuery = "INSERT INTO <TABLE NAME> (UserName, MountPoint, Description, ComputerName) VALUES ('$($obj.UserName)', '$($obj.MountPoint)', '$($obj.Description)', '$($obj.ComputerName)')"
        Invoke-Sqlcmd -Query $SqlQuery -ServerInstance $SqlServer -Database $SqlDb -Username $SqlUsername -Password $SqlPassword
    }
}

