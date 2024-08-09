# Script for checking paths and loading modules
# Run with this to prevent the screen from closing before you can read it
# powershell.exe -ExecutionPolicy Bypass -NoExit -File checking_paths.ps1

# Import the ToolkitInitializer module
$modulePath = "C:\Users\pfilkin\Documents\WindowsPowerShell\Modules\ToolkitInitializer\ToolkitInitializer.psm1"
if (Test-Path $modulePath) {
    Import-Module -Name $modulePath
    Write-Host "ToolkitInitializer module imported successfully."
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
$scriptPath = $MyInvocation.MyCommand.Path
$scriptParentDiv = Split-Path $scriptPath -Parent;
$StudioVersion = "Studio18"

if ("${Env:ProgramFiles(x86)}") {
    $ProgramFilesDir = "${Env:ProgramFiles(x86)}"
} else {
    $ProgramFilesDir = "${Env:ProgramFiles}"
}

$appPath = "$ProgramFilesDir\Trados\Trados Studio\$StudioVersion\"

Write-Host "`nScript Parent Directory: $scriptParentDiv"
Write-Host "Program Files Directory: $ProgramFilesDir"
Write-Host "Expected Trados Studio Path: $appPath"

if (Test-Path $appPath) {
    Write-Host "Trados Studio directory exists: $appPath"
} else {
    Write-Host "Trados Studio directory does not exist: $appPath"
}

# Expected DLLs and verification
$expectedDlls = @(
    "Sdl.ProjectAutomation.FileBased.dll",
    "Sdl.ProjectAutomation.Core.dll",
    "Sdl.LanguagePlatform.TranslationMemory.dll",
    "Sdl.FileTypeSupport.Framework.Core.Utilities.dll",
    "Sdl.ProjectAutomation.Settings.dll",
    "Sdl.Desktop.Platform.ServerConnectionPlugin.dll"
)

$foundDlls = @()
$missingDlls = @()

foreach ($dll in $expectedDlls) {
    if (Test-Path "$appPath$dll") {
        Write-Host "Found $dll"
        $foundDlls += $dll
    } else {
        Write-Host "$dll not found in $appPath"
        $missingDlls += $dll
    }
}

Write-Host "`nSummary of DLL Check:"
Write-Host "Found DLLs: $($foundDlls -join ', ')"
Write-Host "Missing DLLs: $($missingDlls -join ', ')"

# Check for and import required modules
$modules = @("GetGuids", "PackageHelper", "ProjectHelper", "ProjectServerHelper", "TMHelper", "TMServerHelper", "UserManagerHelper")

foreach ($module in $modules) {
    Write-Host "`nSearching for module: $module"

    $modulePaths = @(
        "$env:USERPROFILE\Documents\WindowsPowerShell\Modules\$module",
        "$scriptParentDiv\$module"
    )

    $moduleFound = $false
    $moduleFoundPath = ""

    foreach ($path in $modulePaths) {
        Write-Host "Looking for $module at $path"

        if (Test-Path $path) {
            Write-Host "Module $module found at $path"
            try {
                Import-Module -Name $module -ArgumentList $StudioVersion -Scope Global
                Write-Host "Module $module imported successfully from $path"
                $moduleFound = $true
                $moduleFoundPath = $path
                break
            } catch {
                Write-Host "Failed to import module $module from ${path}: $($_.Exception.Message)"
            }
        }
    }

    if (-not $moduleFound) {
        Write-Host "Module $module not found in any of the searched paths. Please ensure it is installed and available in a recognized module directory."
    } else {
        Write-Host "Module $module was successfully imported from $moduleFoundPath"
    }
}

# Check if the required cmdlets are available
if (Get-Command -Name New-FileBasedTM -ErrorAction SilentlyContinue) {
    Write-Host "`nNew-FileBasedTM cmdlet is available."
} else {
    Write-Host "`nNew-FileBasedTM cmdlet not found. Verify the module containing this cmdlet is loaded correctly."
}

# Pause the script to keep the console open for review
Read-Host -Prompt "`nPress Enter to exit"
