[T4Scaffolding.Scaffolder(Description = "Generates an Ajax-powered grid")][CmdletBinding()]
param(        
	[Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true)]$ModelType,
    [string]$Project,
	[string]$CodeLanguage,
	[string[]]$TemplateFolders,
	[switch]$Force = $false
)

Scaffold MvcScaffolding.Controller $ModelType -Project $Project `
	-CodeLanguage $CodeLanguage -OverrideTemplateFolders $TemplateFolders `
	-NoChildItems -Force:$Force

$controllerName = Get-PluralizedWord $ModelType
Scaffold MvcScaffolding.RazorView $controllerName Index -ModelType $ModelType `
	-Template AjaxEditorView -Project $Project -CodeLanguage $CodeLanguage `
	-OverrideTemplateFolders $TemplateFolders -Force:$Force

Scaffold DbContext $ModelType -DbContextType ((Get-Project $Project).Name + "Context")
