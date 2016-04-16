[T4Scaffolding.Scaffolder(Description = "Enter a description of ExtWebApi here")][CmdletBinding()]
param(        
	[parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)][string]$ModelType,
	[string]$Project,
	[string]$CodeLanguage,
	[string[]]$TemplateFolders,
	[switch]$Force = $false	
)

$mynamespace = "LDSCORE"
$projectFor = $mynamespace + ".WebAPI"
$namespace = $projectFor # (Get-Project $projectFor).Properties.Item("DefaultNamespace").Value
$outputPath =  "Services\" + $projectFor + "s"  + "\Controllers\api\" + $ModelType + "Controller.cs"
Write-Host "Removing $ModelType ExtWebApi $ModelTypeController.cs"

Remove-Item $outputPath


$useModelFromProject = $mynamespace + ".Domain"
# get the modelType object from the name
$foundModelType = Get-ProjectType $ModelType -Project $useModelFromProject -BlockUi
$modelOutputPath = "Services\" + $projectFor + "s" + "\ApiModel\" + $ModelType + ".cs"

Write-Host "Removing $ModelType Api Model $ModelType.cs"
Remove-Item $modelOutputPath
