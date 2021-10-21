[CmdletBinding(SupportsShouldProcess = $true)]

param (
    [Parameter()]
    [string[]]$SitecoreVersion
)

$parentFolderPath = (get-item $PSScriptRoot).parent.FullName
$coveoAssetsFolderPath = "$parentFolderPath\windows\$SitecoreVersion\modules\coveo-assets"
$coveoSxaAssetsFolderPath = "$parentFolderPath\windows\$SitecoreVersion\modules\coveo-sxa-assets"

if (!(Test-Path -Path $coveoAssetsFolderPath))
{
    #Creating required folders for Coveo assets
    New-Item -Path $coveoAssetsFolderPath -ItemType directory
    New-Item -Path "$coveoAssetsFolderPath\tools" -ItemType directory
}

if (!(Test-Path -Path $coveoSxaAssetsFolderPath))
{
    #Creating required folders for Coveo SXA assets
    New-Item -Path $coveoSxaAssetsFolderPath -ItemType directory
    New-Item -Path "$coveoSxaAssetsFolderPath\tools" -ItemType directory
}

if (!(Test-Path -Path "$coveoAssetsFolderPath\tools\Extract-Resources.ps1" -PathType Leaf))
{
    #Copying the Extract-Resource.ps1 script into the tool folder
    Copy-Item "$PSScriptRoot\Extract-Resources.ps1" -Destination "$coveoAssetsFolderPath\tools"

}

if (!(Test-Path -Path "$coveoAssetsFolderPath\tools\Extract-Resources.ps1" -PathType Leaf))
{
    #Copying the Extract-Resource.ps1 script into the tool folder
    Copy-Item "$PSScriptRoot\Extract-Resources.ps1" -Destination "$coveoSxaAssetsFolderPath\tools"

}


