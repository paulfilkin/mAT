$ErrorActionPreference = "Stop"

# Load necessary assemblies for GUI
Add-Type -AssemblyName System.Windows.Forms

$StudioVersion = "Studio18"; # Change this with the actual Trados Studio version
$TemplateFolderPath = "c:\Users\pfilkin\OneDrive - RWS\Documents\Studio 2024\Project Templates\" # Folder containing the templates

# Display a message to indicate the purpose of the script
Write-Host "This script demonstrates how the PowerShell Toolkit can be used to automate small workflows"

# Notify the user that the necessary modules for Trados Studio will be loaded next
Write-Host "Start by loading PowerShell Toolkit modules."

# Determine the script's directory
$scriptPath = $MyInvocation.MyCommand.Path
if (-not $scriptPath) {
    Write-Host "Warning: Script path is null, using current directory as fallback."
    $scriptPath = Get-Location
}
$scriptParentDir = Split-Path $scriptPath -Parent

# Attempt to find the Modules directory first relative to the script location
$modulesDir = Join-Path $scriptParentDir "Modules"

# If the Modules directory is not found, fall back to the default location in Documents
if (-not (Test-Path $modulesDir)) {
    $modulesDir = Join-Path $Env:USERPROFILE "Documents\WindowsPowerShell\Modules"
}

# Import the ToolkitInitializer module to initialise the Trados Studio environment.
$modulePath = Join-Path $modulesDir "ToolkitInitializer\ToolkitInitializer.psm1"
if (Test-Path $modulePath) {
    Import-Module -Name $modulePath
} else {
    Write-Host "ToolkitInitializer module not found at $modulePath"
    exit
}

# Import the specific toolkit modules corresponding to the Trados Studio version being used.
Import-ToolkitModules $StudioVersion

# Defining the necessary properties for Project Creation
$projectName = Read-Host "Please enter the project name"
$projectDestinationPath = "c:\Users\pfilkin\OneDrive - RWS\Documents\Studio 2024\Projects\" + $projectName;
$dueDate = Read-Host "Enter the due date (yyyy-mm-dd)";
$description = "ApiProject"

# Function to open a file dialog to select a template
function Select-Template {
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.InitialDirectory = $TemplateFolderPath
    $OpenFileDialog.Filter = "Project Templates (*.sdltpl)|*.sdltpl"
    $OpenFileDialog.Title = "Select a Project Template"
    
    if ($OpenFileDialog.ShowDialog() -eq "OK") {
        return $OpenFileDialog.FileName
    } else {
        Write-Host "No template selected. Exiting."
        exit
    }
}

# Prompt the user to select a template
$TemplatePath = Select-Template
Write-Host "Selected Template: $TemplatePath"

# Placeholder values (use neutral or minimal values)
$placeholderSourceLanguage = ""
$placeholderTargetLanguages = @("") # An empty array

# Creates the project using the selected template with placeholder values
New-Project -ProjectName $projectName -projectDestination $projectDestinationPath -projectReference $TemplatePath -sourceLanguage $placeholderSourceLanguage -targetLanguages $placeholderTargetLanguages -projectDueDate $dueDate -projectDescription $description;


Write-Host "A new project creation completed using the template."
Write-Host "Now open project and get analyze statistics."

# Retrieving the newly created project as a FileBasedProject instance
$project = Get-Project ($projectDestinationPath);

# Display the project statistics on the console
Get-AnalyzeStatistics $project;

Write-Host "Press any key to continue ..."
Write-Host "Now for each target language create translation package."

# Export packages for all the project target languages
$targetLanguages = Get-Languages $targetLanguages;
foreach($targetLanguage in $targetLanguages)
{
	Export-Package $targetLanguage ("c:\Users\pfilkin\OneDrive - RWS\Documents\Studio 2024\Packages\translationpackage_"+ $targetLanguage.IsoAbbreviation +".sdlppx") $project;
}

Write-Host "Completed."
