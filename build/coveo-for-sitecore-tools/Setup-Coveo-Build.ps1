[CmdletBinding(SupportsShouldProcess = $true)]

param(
    [Parameter()]
    [ValidatePattern('[0-9]+\.[0-9]+\.[0-9]+')]
    [string[]]$SitecoreVersion = @("10.1.0"),
    [Parameter()]
    [ValidatePattern('[5]+\.[0]+\.[0-9]+\.[0-9]+')]
    [string]$CoveoVersion = ""
)

Write-Output "Completing setup for Coveo image build..."

& "$PSScriptRoot\Add-To-SitecorePackagesJson.ps1" -SitecoreVersion $SitecoreVersion -CoveoVersion $CoveoVersion
& "$PSScriptRoot\Generate-Coveo-Assets-Folders.ps1" -SitecoreVersion $SitecoreVersion
& "$PSScriptRoot\Generate-Coveo-BuildJson.ps1" -SitecoreVersion $SitecoreVersion -CoveoVersion $CoveoVersion

Write-Output "Ready to build the Coveo for Sitecore image"