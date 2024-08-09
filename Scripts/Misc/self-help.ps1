# Set the script to use Trados Studio 2024
$StudioVersion = "Studio18";

# Display a message to indicate the purpose of the script
Write-Host "This script demonstrates how the PowerShell Toolkit can be used for a little self-help";

# Notify the user that the necessary modules for Trados Studio will be loaded next
Write-Host "Start by loading PowerShell Toolkit modules.";

# Determine the script's directory
$scriptPath = $MyInvocation.MyCommand.Path
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

# Import the specific toolkit modules corresponding to the SDL Trados Studio version being used.
Import-ToolkitModules $StudioVersion

# List of all modules to retrieve help content from
$moduleNames = @("GetGuids", "PackageHelper", "ProjectHelper", "ProjectServerHelper", 
                "TMHelper", "TMServerHelper", "UserManagerHelper")

# Define the output file path for the help content
$outputFilePath = "c:\Users\pfilkin\Documents\WindowsPowerShell\HelpOutput.txt"

# Initialize the output file
"" | Out-File -FilePath $outputFilePath

# Loop through each module and retrieve help content
foreach ($moduleName in $moduleNames) {
    Write-Host "Processing help for module: $moduleName"
    
    # Get all commands from the current module
    $commands = Get-Command -Module $moduleName

    # Loop through each command and get its full help content
    foreach ($command in $commands) {
        $commandName = $command.Name
        Write-Host "Processing help for command: $commandName"
        
        # Get the full help content for the command
        $helpContent = Get-Help $commandName -Full

        # Append the module name, command name, and help content to the output file
        "Help for module: $moduleName - Command: $commandName" | Out-File -FilePath $outputFilePath -Append
        $helpContent | Out-File -FilePath $outputFilePath -Append
        "`n`n" | Out-File -FilePath $outputFilePath -Append
    }
}

Write-Host "Help content for all commands in specified modules has been written to $outputFilePath"
