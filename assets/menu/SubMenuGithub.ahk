#Requires AutoHotkey v2.0

SubMenuGithub()
{
    GithubMenu := Menu()

    PopUpMenu.Add("Github", GithubMenu)
    PopUpMenu.SetIcon("Github", iconGithub, , 24)

    GithubMenu.Add("Trados Studio Powershell Toolkit", HandlerSubMenuGithub)
    GithubMenu.SetIcon("Trados Studio Powershell Toolkit", iconRWS, , 24)

    GithubMenu.Add("Trados GroupShare Powershell Toolkit", HandlerSubMenuGithub)
    GithubMenu.SetIcon("Trados GroupShare Powershell Toolkit", iconRWS, , 24)

    GithubMenu.Add("STraSAK (SDL Trados Studio Automation Kit)", HandlerSubMenuGithub)
    GithubMenu.SetIcon("STraSAK (SDL Trados Studio Automation Kit)", iconSTraSAK, , 24)

    PopUpMenu.Add()
}

HandlerSubMenuGithub(ItemName, *)
{
    switch ItemName 
    {
        case "Trados Studio Powershell Toolkit":
            Run "https://github.com/RWS/Sdl-studio-powershell-toolkit/tree/master/"

        case "Trados GroupShare Powershell Toolkit":
            Run "https://github.com/RWS/groupshare-api-powershell-toolkit/tree/main"

        case "STraSAK (SDL Trados Studio Automation Kit)":
            Run "https://github.com/EvzenP/STraSAK"

    }
}
