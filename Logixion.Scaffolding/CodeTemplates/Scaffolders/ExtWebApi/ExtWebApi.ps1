[T4Scaffolding.Scaffolder(Description = "Enter a description of ExtWebApi here")][CmdletBinding()]
param(        
	[parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)][string]$ModelType,
	[string]$Project,
	[string]$CodeLanguage,
	[string[]]$TemplateFolders,
	[switch]$Force = $false	,
	[switch]$IsMongo = $false
)

$mynamespace = "LDSCORE"
$projectFor = $mynamespace + ".WebAPI"
$namespace = $projectFor # (Get-Project $projectFor).Properties.Item("DefaultNamespace").Value
$outputPath =  "Controllers\api\" + $ModelType + "Controller"
Write-Host "Scaffolding $ModelType ExtWebApi..."

$mongo = "false";
if($IsMongo)
{
$mongo = "true";
}

Add-ProjectItemViaTemplate $outputPath -Template ExtWebApiTemplate `
	-Model @{ Namespace = $namespace; EntityName = $ModelType; mongo = $mongo; } `
	-SuccessMessage "Added ExtWebApi output at $projectFor" `
	-TemplateFolders $TemplateFolders -Project $projectFor -CodeLanguage $CodeLanguage -Force:$Force


$useModelFromProject = $mynamespace + ".Domain"
# get the modelType object from the name
$foundModelType = Get-ProjectType $ModelType -Project $useModelFromProject -BlockUi
$modelOutputPath = "ApiModel\" + $ModelType

Add-ProjectItemViaTemplate $modelOutputPath -Template ExtWebApiModelTemplate `
	-Model @{ Namespace = $namespace; ModelType = [MarshalByRefObject]$foundModelType; EntityName = $ModelType } `
	-SuccessMessage "Added ExtWebApi output at $projectFor second time" `
	-TemplateFolders $TemplateFolders -Project $projectFor -CodeLanguage $CodeLanguage -Force:$Force