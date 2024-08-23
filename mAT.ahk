#Requires AutoHotkey v2.0
#SingleInstance

#Include "assets\init.ahk"

Tray := A_TrayMenu
TraySetIcon iconTrayicon
A_IconTip := "mAT (multifarious Automation Tool)"

; Remove the default menu
Tray.Delete()

Tray.Add("multifarious", CopyrightInfo)
Tray.SetIcon("multifarious", iconCopyright)
Tray.Add()
Tray.Add("Reload", (*) => Reload())
Tray.SetIcon("Reload", iconReloadApp)
Tray.Add("Exit", (*) => ExitApp())
Tray.SetIcon("Exit", iconExit)

LightDarkColorMode()

; Create the main popup menu
PopUpMenu := Menu()

MainMenu()

; Sub-Menus
SubMenuPowershell()
SubMenuGithub()
SubMenuTrados()
SubMenuTools()
SubMenuScripting()



; Main Menu
PopUpMenu.Add("Close Menu", HandlerMainMenu)
PopUpMenu.SetIcon("Close Menu", iconCloseMenu, , 24)


; Show menu - two options
; Alt+M
!M::PopUpMenu.Show()

; Ctrl+Right Mouse Click
^RButton::PopUpMenu.Show()
