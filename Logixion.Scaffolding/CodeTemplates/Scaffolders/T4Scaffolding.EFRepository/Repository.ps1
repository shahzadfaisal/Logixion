[T4Scaffolding.Scaffolder(Description = "Enter a description of ExtStore here")][CmdletBinding()]
param(  
	[parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)][string]$ModelType,          
    [string]$Project,
	[string]$CodeLanguage,
	[string[]]$TemplateFolders,
	[switch]$Force = $false
)

#(Get-Project $Project).Object.References.Add("System.Data.Entity") | Out-Null

# get the modelType object from the name
$foundModelType = Get-ProjectType $ModelType -Project $Project -BlockUi
$outputPath =  "app\$ModelType"
$DefaultNamespace = (Get-Project $Project).Properties.Item("DefaultNamespace").Value
$templateName = "Repository"

Write-Host "Scaffolding $ModelType  Repository..."
Add-ProjectItemViaTemplate $outputPath -Template $templateName -Model @{ 
		ModelType = [MarshalByRefObject]$foundModelType; 
		DefaultNamespace = $DefaultNamespace ;
} -SuccessMessage "Added ExtStore output at $Project" -TemplateFolders $TemplateFolders -Project $Project -CodeLanguage $CodeLanguage -Force:$Force