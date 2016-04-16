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

Scaffold RemoveExtWebApi -ModelType $ModelType -Force:$Force

Scaffold RemoveAdminRepositoryClass -ModelType $ModelType -Force:$Force -appoutput:$appoutput
