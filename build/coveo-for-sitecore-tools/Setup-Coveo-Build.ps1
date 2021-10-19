[CmdletBinding(SupportsShouldProcess = $true)]

param(
    [Parameter(Mandatory = $false)]
    [ValidateNotNullOrEmpty()]
    [string]$InstallSourcePath,
    [Parameter()]
    [string[]]$SitecoreVersion,
    [Parameter()]
    [string]$CoveoVersion,
    [Parameter()]
    [switch]$IncludeSxa
)

Write-Host "SitecoreVersion=$SitecoreVersion CoveoVersion=$CoveoVersion IncludeSxa=$IncludeSxa"

& "$PSScriptRoot\Add-To-SitecorePackagesJson.ps1" -InstallSourcePath $InstallSourcePath -SitecoreVersion $SitecoreVersion -CoveoVersion $CoveoVersion -IncludeSxa:$IncludeSxa
& "$PSScriptRoot\Generate-Coveo-Assets-Folders.ps1" -SitecoreVersion $SitecoreVersion -IncludeSxa:$IncludeSxa
& "$PSScriptRoot\Generate-Coveo-BuildJson.ps1" -SitecoreVersion $SitecoreVersion -CoveoVersion $CoveoVersion -IncludeSxa:$IncludeSxa
