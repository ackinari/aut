; - - - - - - - - - Script settings - - - - - - - - -
#SingleInstance Force
#NoEnv
;#NoTrayIcon
SetWorkingDir %A_ScriptDir%
SendMode Input

; - - - - - - - - - User settings - - - - - - - - - -
color_mode := 2 ;1=System ;2=Dark ;3=Light
contextcolor(color_mode)

; - - - - - - - - - - - Menu - - - - - - - - - - - - -
menu, main_menu, add, Help, help
menu, main_menu, default, help

menu, main_menu, add ;; blank line

menu, main_menu, add, Color Picker, colorpicker
menu, main_menu, add, Looping Tool, loopingTool
menu, main_menu, add, Auto Clicker, autoClicker

menu, main_menu, add ;; blank line

menu, main_menu, add, MCBE Temp, minecraftResources
menu, main_menu, add, Update, update
menu, main_menu, add, Settings, settings
    menu, settings_menu, add, Color, color

menu, main_menu, add ;; blank line

menu, main_menu, add, Exit, exit

menu, main_menu, add, Settings, :settings_menu

; - - - - - - - - - - Menu HotKey - - - - - - - - - -
#MButton::
    menu, main_menu, show
return

; - - - - - - - - - Menu Functions - - - - - - - - - -
help:
    msgbox,, %A_ThisMenuItem%, Coming soon!
return

colorpicker:
    run, "..\AHK_scripts\colorpicker.ahk"
return

loopingTool:
    run, "..\AHK_scripts\loopingTool.ahk"
return

autoClicker:
    run, "..\AHK_scripts\autoClicker.ahk"
return

minecraftResources:
    run, "..\AHK_scripts\minecraftResources.ahk"
return

update:
    run, "..\AHK_scripts\updater.ahk"
return

settings:
return

color:
    msgbox, %color_mode%
    color_mode := 3
return

exit:
    Tooltip, Menu: Off
    sleep 200
    ExitApp
return

; - - - - - - - - Other Functions - - - - - - - - - -
contextcolor(color_mode) 
{
    static uxtheme := DllCall("GetModuleHandle", "str", "uxtheme", "ptr")
    static SetPreferredAppMode := DllCall("GetProcAddress", "ptr", uxtheme, "ptr", 135, "ptr")
    static FlushMenuThemes := DllCall("GetProcAddress", "ptr", uxtheme, "ptr", 136, "ptr")
    DllCall(SetPreferredAppMode, "int", color_mode)
    DllCall(FlushMenuThemes)
}