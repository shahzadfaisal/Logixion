[T4Scaffolding.Scaffolder(Description = "Enter a description of ExtListView here")][CmdletBinding()]
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
$outputPath =  "Web\" + $projectFor + "\app\view\" + $ModelType.ToLower() + "\Summary.js"
$primaryKey = Get-PrimaryKey $ModelType -Project $useModelFromProject
$relatedEntities = [Array](Get-RelatedEntities $ModelType -Project $useModelFromProject)
$DefaultNamespace = $projectFor # (Get-Project $projectFor).Properties.Item("DefaultNamespace").Value
$templateName = "ExtSummary"

Write-Host "Removing $ModelType  ExtSummary from project " $projectFor
Remove-Item $outputPath