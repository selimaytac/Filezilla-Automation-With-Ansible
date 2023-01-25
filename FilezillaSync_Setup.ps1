param($path)
$action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument "-File $path\FilezillaSync.ps1"
$trigger = New-ScheduledTaskTrigger -Daily -At 1am
$settings = New-ScheduledTaskSettingsSet
$principal = New-ScheduledTaskPrincipal -GroupId "BUILTIN\Administrators" -RunLevel Highest
$task = New-ScheduledTask -Action $action -Trigger $trigger -Settings $settings -Principal $principal
Register-ScheduledTask -TaskName "Filezilla Data Collection" -InputObject $task

