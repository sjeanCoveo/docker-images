[CmdletBinding(SupportsShouldProcess = $true)]

param (
    [Parameter()]
    [string[]]$SitecoreVersion
)

$parentFolderPath = (get-item $PSScriptRoot).parent.FullName
$coveoAssetsFolderPath = "$parentFolderPath\windows\$SitecoreVersion\modules\coveo-assets"
$coveoSxaAssetsFolderPath = "$parentFolderPath\windows\$SitecoreVersion\modules\coveo-sxa-assets"

Remove-Item $coveoAssetsFolderPath\*.zip | Out-Null
Remove-Item $coveoSxaAssetsFolderPath\*.zip | Out-Null

#Creating required folders for Coveo assets
New-Item -Path $coveoAssetsFolderPath -ItemType directory -Force | Out-Null
New-Item -Path "$coveoAssetsFolderPath\tools" -ItemType directory -Force | Out-Null

#Creating required folders for Coveo SXA assets
New-Item -Path $coveoSxaAssetsFolderPath -ItemType directory -Force | Out-Null
New-Item -Path "$coveoSxaAssetsFolderPath\tools" -ItemType directory -Force | Out-Null

#Copying the Extract-Resource.ps1 script into the tools folders
Copy-Item "$PSScriptRoot\Extract-Resources.ps1" -Destination "$coveoAssetsFolderPath\tools" | Out-Null
Copy-Item "$PSScriptRoot\Extract-Resources.ps1" -Destination "$coveoSxaAssetsFolderPath\tools" | Out-Null
