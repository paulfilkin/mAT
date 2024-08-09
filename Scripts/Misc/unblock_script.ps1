# Set the path to the folder you want to process
$folderPath = "c:\Users\pfilkin\Documents\WindowsPowerShell\Modules\"

# Get all files in the folder and its subfolders
$files = Get-ChildItem -Path $folderPath -Recurse -File

# Unblock each file
foreach ($file in $files) {
    try {
        Unblock-File -Path $file.FullName
        Write-Host "Unblocked: $($file.FullName)"
    } catch {
        Write-Host "Failed to unblock: $($file.FullName) - $_"
    }
}

Write-Host "All files processed."
