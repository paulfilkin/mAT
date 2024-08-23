#Requires AutoHotkey v2.0

SubMenuPowershell()
{
    ; Create the Powershell menu
    PowershellMenu := Menu()

    ; Add the Powershell menu to the main popup menu
    PopUpMenu.Add("Powershell", PowershellMenu)
    PopUpMenu.SetIcon("Powershell", iconPowershell, , 24)


    
    ; TRADOS STUDIO SUBMENU
    ; Add a submenu under Powershell for "Trados Studio scripts"
    TradosStudioScripts := Menu()
    PowershellMenu.Add("Trados Studio", TradosStudioScripts)
    PowershellMenu.SetIcon("Trados Studio", iconstudioTK, , 24)

    ; Add items to the Trados Studio submenu
    TradosStudioScripts.Add("Trados Studio get-help", HandlerSubMenuPowershell.Bind("Trados Studio"))
    TradosStudioScripts.SetIcon("Trados Studio get-help", iconPowershellHelp, , 24)

    TradosStudioScripts.Add("Create new File-based TM", HandlerSubMenuPowershell.Bind("Trados Studio"))
    TradosStudioScripts.SetIcon("Create new File-based TM", iconCreateFBTM, , 24)

    TradosStudioScripts.Add("Upgrade TMX", HandlerSubMenuPowershell.Bind("Trados Studio"))
    TradosStudioScripts.SetIcon("Upgrade TMX", iconUpgradeTMX, , 24)

    TradosStudioScripts.Add("Create Project (using Project Template)", HandlerSubMenuPowershell.Bind("Trados Studio"))
    TradosStudioScripts.SetIcon("Create Project (using Project Template)", iconCPProjectTemplate, , 24)

    TradosStudioScripts.Add("Export SDLTM to TMX", HandlerSubMenuPowershell.Bind("Trados Studio"))
    TradosStudioScripts.SetIcon("Export SDLTM to TMX", iconExportSDLTMtoTMX, , 24)



    ; GROUPSHARE SUBMENU
    ; Add a submenu under Powershell for "GroupShare scripts"
    GroupShareScripts := Menu()
    PowershellMenu.Add("GroupShare", GroupShareScripts)
    PowershellMenu.SetIcon("GroupShare", icongroupshareTK, , 24)

    ; Add items to the GroupShare submenu
    GroupShareScripts.Add("GroupShare get-help", HandlerSubMenuPowershell.Bind("GroupShare"))
    GroupShareScripts.SetIcon("GroupShare get-help", iconPowershellHelp, , 24)

    GroupShareScripts.Add("Store Credentials", HandlerSubMenuPowershell.Bind("GroupShare"))
    GroupShareScripts.SetIcon("Store Credentials", iconAddCredentials, , 24)

    GroupShareScripts.Add("Sample Features", HandlerSubMenuPowershell.Bind("GroupShare"))
    GroupShareScripts.SetIcon("Sample Features", iconGSDemo, , 24)



    ; LANGUAGECLOUD SUBMENU
    ; Add a submenu under Powershell for "LanguageCloud scripts"
    LanguageCloudScripts := Menu()
    PowershellMenu.Add("LanguageCloud", LanguageCloudScripts)
    PowershellMenu.SetIcon("LanguageCloud", iconlanguagecloudTK, , 24)



    ; Add a separator in the main popup menu
    PopUpMenu.Add()
}


HandlerSubMenuPowershell(SourceMenu, ItemName, *)
{
    ; Define the base path and PowerShell executable path based on the SourceMenu
    if (SourceMenu == "Trados Studio") {
        basePath := "c:\Users\pfilkin\Documents\StudioPowershellToolkit\Scripts\"
        powershellPath := "C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell.exe" ; 32-bit
    }
    else if (SourceMenu == "GroupShare") {
        basePath := "c:\Users\pfilkin\Documents\GroupSharePowershellToolkit\Scripts\"
        powershellPath := "c:\Program Files\PowerShell\7\pwsh.exe" ; 64-bit
    }
    else {
        MsgBox("Unknown menu: " SourceMenu)
        return
    }

    ; Call the helper function with the appropriate script name based on the ItemName
    switch ItemName
    {
        ; Trados Studio
        case "Trados Studio get-help":
            RunPowerShellScript(powershellPath, basePath "00_get-help-Studio.ps1")
        case "Create new File-based TM":
            RunPowerShellScript(powershellPath, basePath "01_create_new_TM.ps1")
        case "Upgrade TMX":
            RunPowerShellScript(powershellPath, basePath "02_upgrade_TMX.ps1")
        case "Create Project (using Project Template)":
            RunPowerShellScript(powershellPath, basePath "03_Create_File-Based_Project.ps1")
        case "Export SDLTM to TMX":
            RunPowerShellScript(powershellPath, basePath "04_Export_TMX.ps1")

        ; GroupShare
        case "GroupShare get-help":
            RunPowerShellScript(powershellPath, basePath "00_groupshare-get-help.ps1")
        case "Store Credentials":
            RunPowerShellScript(powershellPath, basePath "01_Add Credentials.ps1")
        case "Sample Features":
            RunPowerShellScript(powershellPath, basePath "02_Sample_Features.ps1")

        ; LanguageCloud - tbc
    }
}

RunPowerShellScript(powershellPath, filePath)
{
    ; Run the PowerShell script without UAC prompt
    Run(powershellPath ' -ExecutionPolicy Bypass -NoExit -File "' filePath '"')
}
