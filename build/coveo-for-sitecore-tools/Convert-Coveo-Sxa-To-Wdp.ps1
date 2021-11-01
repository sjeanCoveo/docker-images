#This script is for temporary use only as Coveo will release a WDP package for Coveo SXA in their next release
[CmdletBinding(SupportsShouldProcess = $true)]

param(
    [Parameter(Mandatory = $true)]
    [string]$CoveoVersion,
    [Parameter(Mandatory = $true)]
    [string]$SitecoreVersion

)

$buildFolderPath = (Get-Item $PSScriptRoot).parent.FullName
$coveoSxaPackagePath = (Join-Path $buildFolderPath "\windows\$Coveo for Sitecore SXA $SitecoreVersion $CoveoVersion.zip")



# Install Azure toolkit
Write-Host "Prepare Azure toolkit"

$sat = (Join-Path $buildFolderPath "tools\sat")

Write-Host "Sitecore Azure Toolkit directory $sat"

# Ensure Azure SAT destination exists
if (!(Test-Path $sat -PathType "Container"))
{
    Write-Host "Create SAT directory $sat"
    New-Item $sat -ItemType Directory -WhatIf:$false | Out-Null
}

if (!(Test-Path (Join-Path $sat "tools\Sitecore.Cloud.Cmdlets.dll") -PathType Leaf))
{
    # extract Sitecore Azure Toolkit
    Get-ChildItem -Path $Destination -Filter "*Azure Toolkit*" -Recurse | Select-Object -First 1 | Expand-Archive -DestinationPath $sat -Force
}
# import Azure toolkit
Write-Host "Import Sitecore Azure Toolkit"
Import-Module (Join-Path $sat "tools\Sitecore.Cloud.Cmdlets.dll")  -Force

# Convert package

if ($fileName -notlike "*Azure Toolkit*")
{
    $filePath = Join-Path $Destination $fileName
    $expectedScwdpFilePath = $filePath -replace ".zip", ".scwdp.zip"

    if (Test-Path $expectedScwdpFilePath -PathType Leaf)
    {
        Write-Host ("Required WDP found: '{0}'" -f $expectedScwdpFilePath)
    }
    else
    {
        if ($PSCmdlet.ShouldProcess($filePath))
        {
            if (Test-Path $filePath -PathType Leaf)
            {
                    Write-Host "Convert to WDP $filePath"
                    ConvertTo-SCModuleWebDeployPackage -Path $filePath -Destination $Destination -Force
            }
            else
            {
                Throw "Cannot find file: $filePath"
            }
        }
    }
}

$ProgressPreference = $preference
Write-Host "DONE"