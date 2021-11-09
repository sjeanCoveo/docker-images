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
$filePath = Join-Path $InstallSourcePath $sxaZipFileName

Write-Host ("Downloading '{0}' to '{1}'..." -f $coveoSxaPackageUrl, $filePath)

Invoke-WebRequest -Uri $coveoSxaPackageUrl -OutFile $filePath -UseBasicParsing

$zipFilePath = Join-Path $InstallSourcePath $sxaZipFileName

if (Test-Path $zipFilePath -PathType Leaf) {
    # Install Azure toolkit
    Write-Host "Prepare Azure toolkit"

    $sat = (Join-Path (Get-Item $PSScriptRoot).Parent.FullName "tools\sat")

    Write-Host "Sitecore Azure Toolkit directory $sat"

    # Ensure Azure SAT destination exists
    if (!(Test-Path $sat -PathType "Container")) {
        Write-Host "Create SAT directory $sat"
        New-Item $sat -ItemType Directory -WhatIf:$false | Out-Null
    }

    $fileUrl = "https://sitecoredev.azureedge.net/~/media/AD7EFDD038704CED855039DA8EAF5856.ashx?date=20201214T083612"
    $filePath = "Sitecore Azure Toolkit 2.5.1-r02522.1082.zip"

    Invoke-WebRequest -Uri $fileUrl -OutFile (Join-Path $sat $filePath) -UseBasicParsing

    if (!(Test-Path (Join-Path $sat "tools\Sitecore.Cloud.Cmdlets.dll") -PathType Leaf)) {
        # extract Sitecore Azure Toolkit
        Get-ChildItem -Path $sat -Filter "*Azure Toolkit*" -Recurse | Select-Object -First 1 | Expand-Archive -DestinationPath $sat -Force
    }

    Write-Host "Import Sitecore Azure Toolkit"
    Import-Module (Join-Path $sat "tools\Sitecore.Cloud.Cmdlets.dll") -Force

    Write-Host "Convert to WDP $zipFilePath"
    ConvertTo-SCModuleWebDeployPackage -Path $zipFilePath -Destination $InstallSourcePath -Force
}