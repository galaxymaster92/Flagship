# Set the script to run.
$script = $PSScriptRoot + "\Get-IISLogFiles.ps1"

# Arguments passed to the start process. This allows the execution policy to be bypassed for this session only.
# Bypass the execution policy is required in order to load the WebAdministration module in server 2008R2.
$argumentList = "-executionpolicy bypass -windowstyle normal -nologo -file $script"

#Start-Process powershell -WorkingDirectory $PSScriptRoot -ArgumentList $argumentList -NoNewWindow

Start-Process powershell -Verb runAs -WorkingDirectory $PSScriptRoot -ArgumentList $argumentList
