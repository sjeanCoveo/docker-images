[CmdletBinding(SupportsShouldProcess = $true)]

param(
    [Parameter()]
    [string[]]$SitecoreVersion,
    [Parameter()]
    [string]$CoveoVersion
)

.\Add-To-SitecorePackagesJson.ps1 `
    -SitecoreVersion $SitecoreVersion `
    -CoveoVersion $CoveoVersion

.\Generate-Coveo-Assets-Folders.ps1 `
    -SitecoreVersion $SitecoreVersion

.\Generate-Coveo-BuildJson.ps1 `
    -SitecoreVersion $SitecoreVersion `
    -CoveoVersion $CoveoVersion
