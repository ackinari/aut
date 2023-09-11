; script settings
#SingleInstance Force
#NoEnv
;#NoTrayIcon
SetWorkingDir %A_ScriptDir%
SendMode Input

; user settings
;color_mode := 3 ;1=System ;2=Dark ;3=Light
color_mode := 2
contextcolor(color_mode)

; - - - - - - - - - - - MENU - - - - - - - - - - - - - 

menu, main_menu, add, Help, help
menu, main_menu, default, help

menu, main_menu, add ;; blank line

menu, main_menu, add, Color Picker, colorpicker
menu, main_menu, add, Looping Tool, macro

menu, main_menu, add ;; blank line

menu, main_menu, add, Test, test
menu, main_menu, add, Update, update
menu, main_menu, add, Settings, settings

    menu, settings_menu, add, Color, color

menu, main_menu, add ;; blank line

menu, main_menu, add, Exit, exit

menu, main_menu, add, Settings, :settings_menu
; - - - - - - - - - - - MENU - - - - - - - - - - - - - 

; Menu HotKey
#MButton::
    menu, main_menu, show
return

; Button Functions
help:
    msgbox,, %A_ThisMenuItem%, Coming soon!
return

colorpicker:
    run, colorpicker.exe
return

test:
    soundbeep
    menu, main_menu, ToggleCheck, test
    menu, main_menu, ToggleEnable, update
return

macro:
    run, macro.exe
return

update:
    run, updater.exe
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

contextcolor(color_mode) 
{
    static uxtheme := DllCall("GetModuleHandle", "str", "uxtheme", "ptr")
    static SetPreferredAppMode := DllCall("GetProcAddress", "ptr", uxtheme, "ptr", 135, "ptr")
    static FlushMenuThemes := DllCall("GetProcAddress", "ptr", uxtheme, "ptr", 136, "ptr")
    DllCall(SetPreferredAppMode, "int", color_mode)
    DllCall(FlushMenuThemes)
}