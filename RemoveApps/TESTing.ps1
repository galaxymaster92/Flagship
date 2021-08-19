$Package_List = Get-AppxPackage -PackageTypeFilter Bundle -AllUsers | Select-Object -Property Name

 

$Removed_Apps = "Microsoft.BingWeather","Microsoft.GetHelp","Microsoft.Getstarted","Microsoft.Messaging","Microsoft.Microsoft3DViewer","Microsoft.MicrosoftOfficeHub","Microsoft.MicrosoftSolitaireCollection","Microsoft.MixedReality.Portal","Microsoft.OneConnect","Microsoft.People","Microsoft.SkypeApp","Microsoft.Wallet","Microsoft.WindowsAlarms","microsoft.windowscommunicationsapps","Microsoft.WindowsFeedbackHub","Microsoft.WindowsMaps","Microsoft.WindowsSoundRecorder","Microsoft.Xbox.TCUI","Microsoft.XboxApp","Microsoft.XboxGameOverlay","Microsoft.XboxGamingOverlay","Microsoft.XboxIdentityProvider","Microsoft.XboxSpeechToTextOverlay","Microsoft.YourPhone","Microsoft.ZuneMusic","Microsoft.ZuneVideo"

 


foreach ($Package in $Package_List)
{
    if (!($Removed_Apps.Contains($Package.Name)))
    {
        return "installed"
    }
    else
    {
    }
}