

# mAT (multifarious Automation Toolkit)
This repository contains the source code for the multifarious Automation Tool (mAT), a custom-built automation tool designed to streamline various tasks related to Trados Studio, PowerShell, and other utilities. The tool is developed using AutoHotkey v2.0 and provides a highly customisable popup menu system that integrates with a wide range of software and scripts.

## Table of Contents

- [Overview](#overview)
- [Installation](#installation)
- [Usage](#usage)
- Menu Structure
  - [Main Menu](#main-menu)
  - [Submenus](#submenus)
- [Customisation](#customisation)
- [File Descriptions](#file-descriptions)
- [License](#license)

## Overview

mAT is designed to be a versatile automation tool that enhances productivity by providing quick access to frequently used applications, scripts, and online resources. It offers an intuitive popup menu that can be accessed through keyboard shortcuts or mouse clicks.

The tool leverages AutoHotkey's scripting capabilities to perform tasks such as launching applications, running PowerShell scripts, and accessing Github repositories.

## Pre-requisites

1. **AutoHotkey v2.0**: Ensure that AutoHotkey v2.0 is installed on your system. You can download it from [here](https://www.autohotkey.com/).
2. **Run the Script**: Execute the main script (`mAT.ahk`) to start the tool.

## Usage

Once the script is running, you can access the mAT menu using the following shortcuts:

- **Alt+M**: Opens the mAT menu.
- **Ctrl+Right Mouse Click**: Opens the mAT menu.

From the menu, you can select various options to launch applications, run scripts, or access online resources.

## Menu Structure

### Main Menu

The main menu provides access to various submenus, each designed to handle different tasks.  The following is just an example of what I have used this for:

### Submenus

1. **Powershell**
   - **Create new File-based TM**: Runs a PowerShell script to create a new Translation Memory for Trados Studio.
   - **Upgrade TMX**: Runs a PowerShell script to upgrade a TMX file to an SDLTM.
   - **Create Project (using Project Template)**: Runs a PowerShell script to create a Trados Studio project based on a selected project template.
2. **Github**
   - Provides quick access to various Github repositories related to Trados and other tools.
3. **Trados**
   - **Studio 2024**: Launches Trados Studio 2024.
   - **Language Cloud**: Opens the Language Cloud website.
   - **Multiterm 2024**: Launches Multiterm 2024.
4. **Tools**
   - **EditPad Pro**: Launches EditPad Pro.
   - **Regex Buddy**: Launches Regex Buddy.
   - **Notepad++**: Launches Notepad++.
   - **XLIFF Manager**: Launches XLIFF Manager.
   - **TMX Validator**: Launches TMX Validator.
   - **Rainbow**: Launches Okapi Rainbow.
   - **Checkmate**: Launches Okapi Checkmate.
5. **Scripting**
   - **Edit**: Opens the script directory in Visual Studio Code.
   - **Window Spy**: Launches the Window Spy tool.
   - **Reload**: Reloads the mAT script.

## Customisation

The mAT tool is highly customisable. You can easily modify the menu structure, add new items, or update existing ones by editing the corresponding script files. Icons for the menu items are stored in the `assets/ico` directory, and you can replace them with your preferred icons.

## File Descriptions

- **mAT.ahk**: The main script that initializes the tool and sets up the tray icon.
- **assets/init.ahk**: Initializes various settings and variables.
- **menu/MainMenu.ahk**: Defines the structure of the main menu.
- **menu/SubMenuGithub.ahk**: Contains the items for the Github submenu.
- **menu/SubMenuPowershell.ahk**: Contains the items for the Powershell submenu.
- **menu/SubMenuTrados.ahk**: Contains the items for the Trados submenu.
- **menu/SubMenuTools.ahk**: Contains the items for the Tools submenu.
- **menu/SubMenuScripting.ahk**: Contains the items for the Scripting submenu.
- **ico/index.ahk**: Defines the paths to the icons used in the menus.
