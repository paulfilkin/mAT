#Requires AutoHotkey v2.0

MainMenu()
{
    PopUpMenu.Add("*** mAT Menu ***", HandlerMainMenu)
    PopUpMenu.SetIcon("*** mAT Menu ***", iconMenu, , 24)
    PopUpMenu.Disable("*** mAT Menu ***")
}


; HandlerMainMenu(ItemName, *)
HandlerMainMenu(*)
{}