[T4Scaffolding.Scaffolder(Description = "Enter a description of ExtAll here")][CmdletBinding()]
param(        
    [parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)][string]$ModelType,   
	[string]$Project,
	[string]$CodeLanguage,
	[string[]]$TemplateFolders,
	[switch]$Force = $false,
	[string]$appoutput,
	[switch]$NoDBUpdate 

)
$appoutput = 'LDSCORE.Web.Admin'

Scaffold ExtWebApi -ModelType $ModelType -Force:$Force

Scaffold AdminRepositoryClass -ModelType $ModelType -Force:$Force -appoutput:$appoutput 

Add-Migration $ModelType -ProjectName LDSCORE.Infrastructure.Data -StartUpProjectName LDSCORE.WebAPI -Force

if( $NoDBUpdate )
{
Write-Warning "Migrations is added. You need to run Update-database command"
}
else
{
Update-Database -StartUpProjectName LDSCORE.WebAPI -ProjectName LDSCORE.Infrastructure.Data
}
