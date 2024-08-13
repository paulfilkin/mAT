#Requires AutoHotkey v2.0

SubMenuTools()
{
    ToolsMenu := Menu()

    PopUpMenu.Add("Tools", ToolsMenu)
    PopUpMenu.SetIcon("Tools", iconTools, , 24)

    ToolsMenu.Add("EditPad Pro", HandlerSubMenuTools)
    ToolsMenu.SetIcon("EditPad Pro", iconeppro, , 24)

    ToolsMenu.Add("Regex Buddy", HandlerSubMenuTools)
    ToolsMenu.SetIcon("Regex Buddy", iconregexbuddy, , 24)

    ToolsMenu.Add("Notepad++", HandlerSubMenuTools)
    ToolsMenu.SetIcon("Notepad++", iconnotepad, , 24)

    ToolsMenu.Add("XLIFF Manager", HandlerSubMenuTools)
    ToolsMenu.SetIcon("XLIFF Manager", iconxliffmanager, , 24)

    ToolsMenu.Add("TMX Validator", HandlerSubMenuTools)
    ToolsMenu.SetIcon("TMX Validator", icontmxvalidator, , 24)

    ToolsMenu.Add("Rainbow", HandlerSubMenuTools)
    ToolsMenu.SetIcon("Rainbow", iconrainbow, , 24)

    ToolsMenu.Add("Checkmate", HandlerSubMenuTools)
    ToolsMenu.SetIcon("Checkmate", iconcheckmate, , 24)

    PopUpMenu.Add()
}

HandlerSubMenuTools(ItemName, *)
{
    switch ItemName 
    {
        case "EditPad Pro":
            Run "c:\Program Files\Just Great Software\EditPad Pro 8\EditPadPro8.exe"

        case "Regex Buddy":
            Run "c:\Program Files\Just Great Software\RegexBuddy 4\RegexBuddy4.exe"

        case "Notepad++":
            Run "c:\Program Files\Notepad++\notepad++.exe"
        
        case "XLIFF Manager":
            Run "c:\Program Files\Maxprograms\XliffManager\XLIFFManager.exe"
        
        case "TMX Validator":
            SetWorkingDir "c:\Program Files\Maxprograms\TMXValidator"
            Run "TMXValidator.exe"
        
        case "Rainbow":
            SetWorkingDir "c:\Users\pfilkin\Documents\Okapi"
            Run "rainbow.exe"
        
        case "Checkmate":
	    SetWorkingDir "c:\Users\pfilkin\Documents\Okapi"
            Run "checkmate.exe"
    }
}