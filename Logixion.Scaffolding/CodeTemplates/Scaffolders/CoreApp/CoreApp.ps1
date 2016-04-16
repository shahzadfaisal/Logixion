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
$appoutput = 'Logixion'

Scaffold CoreApp -ModelType $ModelType -Force:$Force  

Scaffold AppRepositoryClass -ModelType $ModelType -Force:$Force -appoutput:$appoutput  

 Add-Migration $ModelType -ProjectName Logixion.Domain.Repositories -StartUpProjectName Logixion -Force

if( $NoDBUpdate )
{
	Write-Warning "Migrations is added. You need to run Update-database command"
}
else
{
	Update-Database -StartUpProjectName Logixion -ProjectName Logixion.Domain.Repositories
 
