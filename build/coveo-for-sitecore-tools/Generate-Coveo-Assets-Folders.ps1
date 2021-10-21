[CmdletBinding(SupportsShouldProcess = $true)]

param (
    [Parameter()]
    [string[]]$SitecoreVersion
)

$parentFolderPath = (get-item $PSScriptRoot).parent.FullName
$coveoAssetsFolderPath = "$parentFolderPath\windows\$SitecoreVersion\modules\coveo-assets"
$coveoSxaAssetsFolderPath = "$parentFolderPath\windows\$SitecoreVersion\modules\coveo-sxa-assets"

#Creating required folders for Coveo assets
New-Item -Path $coveoAssetsFolderPath -ItemType directory
New-Item -Path "$coveoAssetsFolderPath\tools" -ItemType directory

#Creating required folders fro Coveo SXA assets
New-Item -Path $coveoSxaAssetsFolderPath -ItemType directory
New-Item -Path "$coveoSxaAssetsFolderPath\tools" -ItemType directory

#Copying the Extract-Resource.ps1 script into the tools folders
Copy-Item "$PSScriptRoot\Extract-Resources.ps1" -Destination "$coveoAssetsFolderPath\tools"
Copy-Item "$PSScriptRoot\Extract-Resources.ps1" -Destination "$coveoSxaAssetsFolderPath\tools"