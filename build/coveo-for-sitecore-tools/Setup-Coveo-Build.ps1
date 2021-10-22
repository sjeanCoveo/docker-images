[CmdletBinding(SupportsShouldProcess = $true)]

param(
    [Parameter()]
    [ValidatePattern()]
    [string[]]$SitecoreVersion,
    [Parameter()]
    [ValidatePattern()]
    [string]$CoveoVersion
)

& "$PSScriptRoot\Add-To-SitecorePackagesJson.ps1" -SitecoreVersion $SitecoreVersion -CoveoVersion $CoveoVersion
& "$PSScriptRoot\Generate-Coveo-Assets-Folders.ps1" -SitecoreVersion $SitecoreVersion
& "$PSScriptRoot\Generate-Coveo-BuildJson.ps1" -SitecoreVersion $SitecoreVersion -CoveoVersion $CoveoVersion



