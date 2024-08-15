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
            RunPowerShellScript(basePath "01_create_new_TM.ps1")
        case "Upgrade TMX":
            RunPowerShellScript(basePath "02_upgrade_TMX.ps1")
        case "Create Project (using Project Template)":
            RunPowerShellScript(basePath "03_Create_File-Based_Project.ps1")
    }
}

RunPowerShellScript(filePath)
{
    ; Run the PowerShell script without UAC prompt
    Run('C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -NoExit -File "' filePath '"')
}
