# Set the target path for the script's log output.

$targetPath = $PSScriptRoot + "\Logs"

# Get the current timestamp to label the transcript logs.

$datetime = get-date -f MM-dd-yyyy_hh.mm.ss

# Test if the path exists. If not, create it.

if (!(Test-Path $targetPath))
{
    New-Item -ItemType Directory -Force -Path $targetPath    
}

# Set the script's log file name based on current date and time.

$transcriptFile = $PSScriptRoot + "\Logs\Remove_IISLogs_$datetime.txt"

#Start logging the script.

Start-Transcript -Path $transcriptFile

# Import the WebAdministration PS module.

Import-module WebAdministration

# Get web sites

$WebSites = Get-Website | Select Name, Id, LogFile

$TotalLogFileSize = @()

# Get log directories for each web site and delete all log files older than X days. Change the AddDays() parameter to change the days to keep.

foreach ($WebSite in $WebSites)
{
	# Clear Variables
	$LogFiles = $Null;
	$LogFilePath = $Null;
 
	# Get Web Site Information
	$SiteName = $WebSite.Name
	$SiteID = $WebSite.Id
 
	# Get Web Site Log Path
	$LogDirectory = $WebSite.LogFile.Directory -Replace '%SystemDrive%', $env:SystemDrive
	$LogPath = $LogDirectory + "\W3SVC" +  $SiteID
	
	foreach ($path in $LogPath)
    {
        $CurrentDate = Get-Date

        #Set the IIS log files to delete (older than 3 days) based on today's date.
        $DatetoDelete = $CurrentDate.AddDays(-30)

        # Set the transcript log files to delete (older than 14 days) based on today's date.
        $ScriptLogDatetoDelete = $CurrentDate.AddDays(-30)
        
        # Get the IIS logs from each web site older than 3 days.
        $LogFiles = Get-ChildItem $LogPath -Filter *.log -EA SilentlyContinue | Where-Object { $_.LastWriteTime -lt $DatetoDelete }
        $TotalLogFileSize += ($LogFiles | Measure-Object -Sum Length).Sum / 1MB

        # Delete the old IIS log files.
        $LogFiles | Remove-Item -Force
    }
}

# Delete script transcript ourput older than 14 days.
Get-ChildItem $transcriptFile -ErrorAction SilentlyContinue | Where-Object { $_.LastWriteTime -lt $ScriptLogDatetoDelete } | Remove-Item -Force

# For giggles, let's write out to the transcript the amount of freed up space.
$sum = $TotalLogFileSize | Measure-Object -Sum | Select Sum

Write-Host $sum.Sum " MB of log files have been deleted from the system."

Stop-Transcript
# Read-Host "Press any key"