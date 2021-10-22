[CmdletBinding(SupportsShouldProcess = $true)]

param(
    [Parameter()]
    [string[]]$SitecoreVersion,
    [Parameter()]
    [string]$CoveoVersion
)

$parentPath = (get-item $PSScriptRoot).parent.FullName
$sitecorePackagesPath = "$parentPath\sitecore-packages.json"


$coveoPackageUrl = "https://static.cloud.coveo.com/coveoforsitecore/packages/v$CoveoVersion./Coveo%20for%20Sitecore%2010.0%20$CoveoVersion.scwdp.zip"
$coveoSxaPackageUrl = "https://static.cloud.coveo.com/coveoforsitecore/packages/v$CoveoVersion/Coveo%20for%20Sitecore%20SXA%2010.1%20$CoveoVersion.zip"

$propertyKey = "Coveo for Sitecore $SitecoreVersion $CoveoVersion.scwdp.zip"
$propertyValue = [ordered]@{ url = $coveoPackageUrl; hash = ""; }

$sxaPropertyKey = "Coveo for Sitecore SXA $SitecoreVersion $CoveoVersion.scwdp.zip"
$sxaPropertyValue = [ordered]@{ url = $coveoSxaPackageUrl; hash = ""; }

$json = Get-Content $sitecorePackagesPath | Out-String | ConvertFrom-Json

$propertyExists = $json.PSobject.Properties.name -match "$propertyKey"
$sxaPropertyExists = $json.PSobject.Properties.name -match "$sxaPropertyKey"

if (!$propertyExists)
{
    $json | Add-Member -Type NoteProperty -Name $propertyKey -Value $propertyValue
    $json | ConvertTo-Json | Set-Content $sitecorePackagesPath

    Write-Output "The Coveo for Sitecore package was added to the sitecore-packages.json file"
}
else
{
    Write-Output "sitecore-packages.json already contains the information for the Coveo package"
}

if (!$sxaPropertyExists)
{

    $json | Add-Member -Type NoteProperty -Name $sxaPropertyKey -Value $sxaPropertyValue
    $json | ConvertTo-Json | Set-Content $sitecorePackagesPath

    Write-Output "The Coveo for Sitecore SXA package was added to the sitecore-packages.json file"
}
else
{
    Write-Output "sitecore-packages.json already contains the information for the Coveo SXA package"
}

& "$parentPath\contributing\Sort-SitecorePackagesJson.ps1"


