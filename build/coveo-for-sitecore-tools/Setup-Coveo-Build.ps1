[CmdletBinding(SupportsShouldProcess = $true)]

param(
    [Parameter()]
    [string[]]$SitecoreVersion,
    [Parameter()]
    [string]$CoveoVersion
)

& "$PSScriptRoot\Add-To-SitecorePackagesJson.ps1" -SitecoreVersion $SitecoreVersion -CoveoVersion $CoveoVersion
& "$PSScriptRoot\Generate-Coveo-Assets-Folders.ps1" -SitecoreVersion $SitecoreVersion
& "$PSScriptRoot\Generate-Coveo-BuildJson.ps1" -SitecoreVersion $SitecoreVersion -CoveoVersion $CoveoVersion



