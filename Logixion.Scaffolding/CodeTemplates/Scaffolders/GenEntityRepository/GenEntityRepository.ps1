[T4Scaffolding.Scaffolder(Description = "Enter a description of RepositoryClass here")][CmdletBinding()]
param(        
	[parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)][string]$ModelType,
	[string]$Project,
	[string]$CodeLanguage,
	[string[]]$TemplateFolders,
	[switch]$Force = $false,
	[string]$appoutput
)

$mynamespace = "LDSCORE"
if (!$appoutput) 
{
$appoutput =$mynamespace+ ".Web.Admin"
}
$physicallocation = (Get-Location).Path
$projectFor = $mynamespace + ".Domain.Interfaces"
$namespace = $projectFor # (Get-Project $projectFor).Properties.Item("DefaultNamespace").Value
$outputPath =  "I" + $ModelType + "Repository"
$modelTypePluralized = Get-PluralizedWord $ModelType
$useModelFromProject = $mynamespace + ".Domain"
$primaryKey = Get-PrimaryKey $ModelType -Project $useModelFromProject

Write-Host "Scaffolding $ModelType  Repository Interface..."

Add-ProjectItemViaTemplate $outputPath -Template GenEntityRepositoryTemplate `
	-Model @{ Namespace = $namespace; EntityName = $ModelType } `
	-SuccessMessage "Added Repository Interface output at $projectFor" `
	-TemplateFolders $TemplateFolders -Project $projectFor -CodeLanguage $CodeLanguage -Force:$Force 
	
		

# get the modelType object from the name
$foundModelType = Get-ProjectType $ModelType -Project $useModelFromProject -BlockUi
$projectForRepository = $mynamespace + ".Infrastructure.Data"
$repositoryOutputPath =  "Repositories\" + $ModelType + "Repository"
$repositoryNamespace = $projectForRepository

Write-Host "Scaffolding $ModelType  Repository..."

$message = "Added Repository output at following Files:
$mynamespace.Infrastructure.Data/Repositories/IRepositoryContext.cs
$mynamespace.Infrastructure.Data/Repositories/DefaultRepositoryContext.cs
$mynamespace.Infrastructure.DependecyResolution/RepositoryModule.cs"


Add-ProjectItemViaTemplate $repositoryOutputPath -Template RepositoryTemplate `
	-Model @{ Namespace = $repositoryNamespace; PrimaryKey = $primaryKey; EntityName = $ModelType; ModelType = $foundModelType; ModelTypePluralized = $modelTypePluralized ; FileLoc=$physicallocation; appoutput=$appoutput} `
	-SuccessMessage $message `
	-TemplateFolders $TemplateFolders -Project $projectForRepository -CodeLanguage $CodeLanguage -Force:$Force

	