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
$appoutput =$mynamespace+ ".Web.App"
}

$physicallocation = (Get-Location).Path
$projectFor = $mynamespace + ".Domain.Interfaces"
$namespace = $projectFor # (Get-Project $projectFor).Properties.Item("DefaultNamespace").Value
$outputPath = "Domain\" +  $projectFor + "\I" + $ModelType + "Repository.cs"
$modelTypePluralized = Get-PluralizedWord $ModelType
$useModelFromProject = $mynamespace + ".Domain"
$primaryKey = Get-PrimaryKey $ModelType -Project $useModelFromProject
	
		

# get the modelType object from the name
$foundModelType = Get-ProjectType $ModelType -Project $useModelFromProject -BlockUi
$projectForRepository = $mynamespace + ".Infrastructure.Data"
$repositoryOutputPath =  "Repositories\" + $ModelType + "Repository"
$repositoryNamespace = $projectForRepository

Write-Host "Scaffolding $ModelType  Repository..."

$message = "Removing Repository output at following Files:
$mynamespace.Infrastructure.Data/Repositories/IRepositoryContext.cs
$mynamespace.Infrastructure.Data/Repositories/DefaultRepositoryContext.cs
$mynamespace.Infrastructure.DependecyResolution/RepositoryModule.cs
$mynamespace.ALM.Mocks/Repositories/FakeDBContext.cs
$mynamespace.ALM.Mocks/Repositories/FakeDBContext.cs
$mynamespace.ALM.Mocks/Repositories/FakeDBContext.cs
$mynamespace.ALM.Mocks/Repositories/FakeDBContext.cs
$mynamespace.WebAPI/Mapping/ModelMapper.cs
/app/view/PageDetail.js
/app/view/data.json
/Views/Shared/_HomeLayout.cshtml"


Add-ProjectItemViaTemplate $repositoryOutputPath -Template RemoveAppRepositoryTemplate `
	-Model @{ Namespace = $repositoryNamespace; PrimaryKey = $primaryKey; EntityName = $ModelType; ModelType = $foundModelType; ModelTypePluralized = $modelTypePluralized ; FileLoc=$physicallocation; appoutput=$appoutput} `
	-SuccessMessage $message `
	-TemplateFolders $TemplateFolders -Project $projectForRepository -CodeLanguage $CodeLanguage -Force:$Force




Write-Host "Scaffolding $ModelType  Repository Interface..."

$repositoryOutputPath = "Infrastructure\" + $projectForRepository + "\Repositories\" + $ModelType + "Repository.cs"

Remove-Item $repositoryOutputPath -Force -Recurse

Remove-Item $outputPath -Force -Recurse