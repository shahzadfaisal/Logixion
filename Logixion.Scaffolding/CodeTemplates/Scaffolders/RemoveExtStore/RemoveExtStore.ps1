[T4Scaffolding.Scaffolder(Description = "Enter a description of ExtStore here")][CmdletBinding()]
param(  
	[parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)][string]$ModelType,          
    [string]$Project,
	[string]$CodeLanguage,
	[string[]]$TemplateFolders,
	[switch]$Force = $false,
	[string]$appoutput
)

(Get-Project $Project).Object.References.Add("System.Data.Entity") | Out-Null
$mynamespace = "Ldscore"
$projectFor = $mynamespace + ".Web.Admin"
if ($appoutput) 
{
$projectFor = $appoutput
}
$useModelFromProject = $mynamespace + ".Domain"
# get the modelType object from the name
$foundModelType = Get-ProjectType $ModelType -Project $useModelFromProject -BlockUi
$modelTypePluralized = Get-PluralizedWord $foundModelType.Name
$outputPath =  "Web\" + $projectFor + "\app\store\$modelTypePluralized" + "Store.js"
$DefaultNamespace = $projectFor # (Get-Project $projectFor).Properties.Item("DefaultNamespace").Value
$templateName = "ExtStoreTemplate"

Write-Host "Removing $ModelType  Ext.Store from project " $projectFor
Remove-Item $outputPath