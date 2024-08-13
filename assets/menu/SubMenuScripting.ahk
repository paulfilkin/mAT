#Requires AutoHotkey v2.0

SubMenuScripting()
{
    SubMenuScripting := Menu()

    PopUpMenu.Add("Scripting", SubMenuScripting)
    PopUpMenu.SetIcon("Scripting", iconMenuSettings,,24)

    SubMenuScripting.Add("Edit", HandlerSubMenuScripting)
    SubMenuScripting.SetIcon("Edit", iconVSCode,,24)

    SubMenuScripting.Add("Window Spy", HandlerSubMenuScripting)
    SubMenuScripting.SetIcon("Window Spy", iconWindowSpy,,24)

    SubMenuScripting.Add()
    
    SubMenuScripting.Add("Reload", (*) => Reload())
    SubMenuScripting.SetIcon("Reload", iconReloadApp,,24)

    PopUpMenu.Add()
}

HandlerSubMenuScripting(ItemName, *)
{
    switch ItemName 
    {
        case "Edit":
            Run(A_ComSpec ' /c "c:\Users\pfilkin\Documents\Scripts\AutoHotkey\ahk-v2-popupmenu & code ."', , "Hide")

        case "Window Spy":
            Run "c:\Program Files\AutoHotkey\UX\WindowSpy.ahk"
    }
}
