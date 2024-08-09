# Run with this to prevent the screen from closing before I can read it
# powershell.exe -ExecutionPolicy Bypass -NoExit -File debug_modules.ps1

# Script for checking paths and loading modules

# Determine the script's directory
$scriptPath = $MyInvocation.MyCommand.Path
$scriptParentDir = Split-Path $scriptPath -Parent

# Attempt to find the Modules directory first relative to the script location
$modulesDir = Join-Path $scriptParentDir "Modules"

# If the Modules directory is not found, fall back to the default location in Documents
if (-not (Test-Path $modulesDir)) {
    $modulesDir = Join-Path $Env:USERPROFILE "Documents\WindowsPowerShell\Modules"
}

# Import the ToolkitInitializer module
$modulePath = Join-Path $modulesDir "ToolkitInitializer\ToolkitInitializer.psm1"
if (Test-Path $modulePath) {
    Import-Module -Name $modulePath
} else {
    Write-Host "ToolkitInitializer module not found at $modulePath"
    exit
}

# Verify module import
if (Get-Module -Name ToolkitInitializer) {
    Write-Host "ToolkitInitializer module imported successfully."
} else {
    Write-Host "Failed to import ToolkitInitializer module."
    exit
}

# Check paths for dependencies
$StudioVersion = "Studio18"

if ("${Env:ProgramFiles(x86)}") {
    $ProgramFilesDir = "${Env:ProgramFiles(x86)}"
} else {
    $ProgramFilesDir = "${Env:ProgramFiles}"
}

$appPath = Join-Path $ProgramFilesDir "Trados\Trados Studio\$StudioVersion"

Write-Host "Script Parent Directory: $scriptParentDir"
Write-Host "Program Files Directory: $ProgramFilesDir"
Write-Host "Expected Trados Studio Path: $appPath"

if (Test-Path $appPath) {
    Write-Host "Trados Studio directory exists: $appPath"
} else {
    Write-Host "Trados Studio directory does not exist: $appPath"
}

foreach ($dll in @("Sdl.ProjectAutomation.FileBased.dll", "Sdl.ProjectAutomation.Core.dll", "Sdl.LanguagePlatform.TranslationMemory.dll", "Sdl.FileTypeSupport.Framework.Core.Utilities.dll", "Sdl.ProjectAutomation.Settings.dll", "Sdl.Desktop.Platform.ServerConnectionPlugin.dll")) {
    if (Test-Path (Join-Path $appPath $dll)) {
        Write-Host "Found $dll"
    } else {
        Write-Host "$dll not found in $appPath"
    }
}

# Modules to load
$moduleNames = @("GetGuids", "PackageHelper", "ProjectHelper", "ProjectServerHelper", "TMHelper", "TMServerHelper", "UserManagerHelper")

foreach ($moduleName in $moduleNames) {
    $modulePath = Join-Path $modulesDir $moduleName
    
    if (Test-Path $modulePath) {
        Import-Module -Name $modulePath -ArgumentList $StudioVersion
        Write-Host "Module $moduleName imported successfully from $modulePath."
    } elseif (Get-Module -ListAvailable -Name $moduleName) {
        Import-Module -Name $moduleName -ArgumentList $StudioVersion
        Write-Host "Module $moduleName imported successfully from a recognised module directory."
    } else {
        Write-Host "Module $moduleName not found. Please ensure it is installed and available in a recognised module directory."
    }
}

# Pause the script to keep the console open for review
Read-Host -Prompt "Press Enter to exit"
