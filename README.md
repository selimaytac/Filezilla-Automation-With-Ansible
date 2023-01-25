# Filezilla User Fetcher With Ansible Automation

### An automation that uses Ansible to install scripts on target Windows servers, which daily transfer Filezilla users to a database via a script.

This automation script uses Ansible to copy two files to specified target servers and schedules a task to run on those servers. The files include a main script (FilezillaSync.ps1) and a setup script (FilezillaSync_Setup.ps1). The script uses the Ansible Windows module to copy the files to the remote servers and the Windows task scheduler to schedule the task.

The main script, FilezillaSync.ps1, is used to collect data from the FileZilla server on the remote servers, and then insert that data into a specified SQL database. The script first deletes any existing records for the current computer from the database, and then inserts new records for each user in the FileZilla server's users.xml file.

The setup script, FilezillaSync_Setup.ps1, is used to configure the task schedule on the remote servers. It creates a new scheduled task that runs the main script daily at 1am.

In order to use this automation, access to the target servers is required through Ansible, and the script path and target server information are passed as parameters through AWX or Tower. Also, the connection details of SQL server including SQL Server IP, SQL Server DB name, SQL username, SQL password, and table name must be entered manually into the main script (FilezillaSync.ps1) before running the automation.

## Contributing ###
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
[MIT](https://choosealicense.com/licenses/mit/)