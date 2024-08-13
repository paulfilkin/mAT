#Requires AutoHotkey v2.0

SubMenuTrados()
{
    TradosMenu := Menu()

    PopUpMenu.Add("Trados", TradosMenu)
    PopUpMenu.SetIcon("Trados", iconTrados, , 24)

    TradosMenu.Add("Studio 2024", HandlerSubMenuTrados)
    TradosMenu.SetIcon("Studio 2024", iconStudio, , 24)

    TradosMenu.Add("Language Cloud", HandlerSubMenuTrados)
    TradosMenu.SetIcon("Language Cloud", iconLanguageCloud, , 24)

    TradosMenu.Add("Multiterm", HandlerSubMenuTrados)
    TradosMenu.SetIcon("Multiterm", iconMultiTerm, , 24)
    
    PopUpMenu.Add()
}

HandlerSubMenuTrados(ItemName, *)
{
    switch ItemName 
    {
        case "Studio 2024":
            Run "c:\Program Files (x86)\Trados\Trados Studio\Studio18\SDLTradosStudio.exe"

        case "Language Cloud":
            Run "https://languagecloud.sdl.com/"

        case "Multiterm 2024":
           ; Run "c:\Program Files (x86)\Trados\MultiTerm\MultiTerm18\MultiTerm.exe"
            SetWorkingDir "c:\Program Files (x86)\Trados\MultiTerm\MultiTerm18"
            Run "MultiTerm.exe"
    }
}