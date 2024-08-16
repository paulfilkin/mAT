#Requires AutoHotkey v2.0

SubMenuPowershell()
{
    ; Create the Powershell menu
    PowershellMenu := Menu()

    ; Add the Powershell menu to the main popup menu
    PopUpMenu.Add("Powershell", PowershellMenu)
    PopUpMenu.SetIcon("Powershell", iconPowershell, , 24)

    ; Add a submenu under Powershell for "Trados Studio scripts"
    TradosStudioScripts := Menu()
    PowershellMenu.Add("Trados Studio", TradosStudioScripts)
    PowershellMenu.SetIcon("Trados Studio", iconStudio, , 24)

    ; Add items to the Trados Studio submenu
    TradosStudioScripts.Add("Create new File-based TM", HandlerSubMenuPowershell)
    TradosStudioScripts.SetIcon("Create new File-based TM", iconCreateFBTM, , 24)

    TradosStudioScripts.Add("Upgrade TMX", HandlerSubMenuPowershell)
    TradosStudioScripts.SetIcon("Upgrade TMX", iconUpgradeTMX, , 24)

    TradosStudioScripts.Add("Create Project (using Project Template)", HandlerSubMenuPowershell)
    TradosStudioScripts.SetIcon("Create Project (using Project Template)", iconCPProjectTemplate, , 24)

    ; Add a separator in the main popup menu
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
