
[T4Scaffolding.ControllerScaffolder("Controller with read/write action and views, using EF data access code", Description = "Adds an ASP.NET MVC controller with views and data access code", SupportsModelType = $true)][CmdletBinding()]
param(     
        [parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)][string]$ModelType,   
		[string]$Project,
		[string]$CodeLanguage,
        [string]$DbContextType,
        [string]$Area,
        [string]$ViewScaffolder = "View",
        [alias("MasterPage")]$Layout,
        [alias("ContentPlaceholderIDs")][string[]]$SectionNames,
        [alias("PrimaryContentPlaceholderID")][string]$PrimarySectionName,
        [switch]$ReferenceScriptLibraries = $false,
        [switch]$Repository = $false,
        [switch]$NoChildItems = $false,
        [string[]]$TemplateFolders,
        [switch]$Force = $false,
        [string]$ForceMode,
	[string]$appoutput
)

# Ensure you've referenced System.Data.Entity
(Get-Project $Project).Object.References.Add("System.Data.Entity") | Out-Null
$mynamespace = "Ldscore"
$useModelFromProject = $mynamespace + ".Domain"
$projectFor = $mynamespace + ".Web.Admin"
if ($appoutput) 
{
$projectFor = $appoutput
}
$foundModelType = Get-ProjectType $ModelType -Project $useModelFromProject -BlockUi
$outputPath =  "Web\" + $projectFor + "\app\model\$ModelType" + "Model.js"
$primaryKey = Get-PrimaryKey $ModelType -Project $useModelFromProject
$relatedEntities = [Array](Get-RelatedEntities $ModelType -Project $useModelFromProject)
$defaultNamespace = $projectFor #(Get-Project $projectFor).Properties.Item("DefaultNamespace").Value
$templateName = "ExtModelTemplate"

Write-Host "Removing $ModelType  Ext.Model from project " $projectFor
Remove-Item $outputPath