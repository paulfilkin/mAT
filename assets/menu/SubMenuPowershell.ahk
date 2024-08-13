#Requires AutoHotkey v2.0

SubMenuPowershell()
{
    PowershellMenu := Menu()

    PopUpMenu.Add("Powershell", PowershellMenu)
    PopUpMenu.SetIcon("Powershell", iconPowershell, , 24)

    PowershellMenu.Add("Create new File-based TM", HandlerSubMenuPowershell)
    PowershellMenu.SetIcon("Create new File-based TM", iconCreateFBTM, , 24)

    PowershellMenu.Add("Upgrade TMX", HandlerSubMenuPowershell)
    PowershellMenu.SetIcon("UPgrade TMX", iconUpgradeTMX, , 24)

    PowershellMenu.Add("Create Project (using Project Template)", HandlerSubMenuPowershell)
    PowershellMenu.SetIcon("Create Project (using Project Template)", iconCPProjectTemplate, , 24)

    PopUpMenu.Add()
}


HandlerSubMenuPowershell(ItemName, *)
{
    ; Define the base path for the PowerShell scripts
    basePath := "c:\Users\pfilkin\Documents\windowspowershell\Scripts\"

    ; Call the helper function with the appropriate script name based on the ItemName
    switch ItemName
    {
        case "Create new File-based TM":
            RunScheduledTaskOrScript(basePath "01_create_new_TM.ps1")
        case "Upgrade TMX":
            RunScheduledTaskOrScript(basePath "02_upgrade_TMX.ps1")
        case "Create Project (using Project Template)":
            RunScheduledTaskOrScript(basePath "03_Create_File-Based_Project.xml")
    }
}


RunScheduledTaskOrScript(filePath)
{
    ; Extract the file name without extension to use as the task name
    fileNameWithoutExt := RegExReplace(filePath, "^.*\\|\..*$", "")
    
    ; Define the scheduled task name based on the script name (without extension)
    taskName := fileNameWithoutExt
    
    ; Check if the scheduled task exists
    result := RunWait('schtasks /query /tn "' taskName '"', , 'Hide UseErrorLevel')
    
    if (result == 0)
    {
        ; If the task exists, run it
        Run('schtasks /run /tn "' taskName '"', , 'Hide')
    }
    else
    {
        ; If the task does not exist, run the script with UAC
        Run('*RunAs C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -NoExit -File "' filePath '"')
    }
}
