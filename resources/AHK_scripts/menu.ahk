#SingleInstance Force
SetWorkingDir %A_ScriptDir%
SendMode Input
Traytip, Menu, On, 1

menu, main_menu, add, Color Picker, colorpicker
menu, main_menu, add, Looping Tool, macro
menu, main_menu, add, Exit, exit

#MButton::
    menu, main_menu, show
return

colorpicker:
    run, colorpicker.exe
return

macro:
    run, macro.exe
return

exit:
    Tooltip, Menu: Off
    sleep 200
    ExitApp
return

f5::reload