[CmdletBinding(SupportsShouldProcess = $true)]

param(
    [Parameter(Mandatory = $false)]
    [ValidateNotNullOrEmpty()]
    [string]$InstallSourcePath,
    [Parameter()]
    [string[]]$SitecoreVersion,
    [Parameter()]
    [string]$CoveoVersion
)

$coveoSxaPackageUrl = "https://static.cloud.coveo.com/coveoforsitecore/packages/v$CoveoVersion/Coveo%20for%20Sitecore%20SXA%2010.1%20$CoveoVersion.zip"
$sxaZipFileName = "Coveo for Sitecore SXA $SitecoreVersion $CoveoVersion.zip"
$sxaWdpFileName = "Coveo for Sitecore SXA $SitecoreVersion $CoveoVersion.scwdp.zip"
$filePath = Join-Path $InstallSourcePath $sxaZipFileName

if (!(Test-Path $filePath -PathType Leaf)){
    Write-Host ("Downloading '{0}' to '{1}'..." -f $coveoSxaPackageUrl, $filePath)

    Invoke-WebRequest -Uri $coveoSxaPackageUrl -OutFile $filePath -UseBasicParsing

    $zipFilePath = Join-Path $InstallSourcePath $sxaZipFileName
    $wdpFilePath = Join-Path $InstallSourcePath $sxaWdpFileName

    if (Test-Path $zipFilePath -PathType Leaf){
        Write-Host "Convert to WDP $zipFilePath"
        ConvertTo-SCModuleWebDeployPackage -Path $zipFilePath -Destination $wdpFilePath -Force -DisableDacPacOptions "*"
    }
}