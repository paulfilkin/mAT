#Requires AutoHotkey v2.0

; CopyrightInfo(*) {
;     MsgBox "multifarious`nhttps://multifarious.filkin.com/" "Source code"
; }

CopyrightInfo(*) {
    myGui := Gui("+AlwaysOnTop +ToolWindow -SysMenu", "Source code")

    myGui.AddText(, "The source code for mAT can be found on Github here:`n")

    ; Add a clickable link
    Link := myGui.AddText("cBlue", "https://github.com/paulfilkin/mAT")
    Link.OnEvent("Click", (*) => Run("https://github.com/paulfilkin/mAT"))

    myGui.AddButton("Default", "OK").OnEvent("Click", (*) => myGui.Hide())

    myGui.Show()
}






; 0=Default, 1=AllowDark, 2=ForceDark, 3=ForceLight, 4=Max
LightDarkColorMode(colorMode := 2)
{
    static uxtheme := DllCall("GetModuleHandle", "str", "uxtheme", "ptr")
    static SetPreferredAppMode := DllCall("GetProcAddress", "ptr", uxtheme, "ptr", 135, "ptr")
    static FlushMenuThemes := DllCall("GetProcAddress", "ptr", uxtheme, "ptr", 136, "ptr")
    DllCall(SetPreferredAppMode, "int", colorMode)
    DllCall(FlushMenuThemes)
}
