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
    run, resources\colorpicker.exe
return

macro:
    run, resources\macro.exe
return

test:
    run, cmd.exe /c C: && powershell -Command "Invoke-WebRequest https://drive.google.com/u/0/uc?id=1iXs_fJLeVNgrDMQLC0ZMyDDInbqHorMm -Outfile resources.zip" && powerShell -Command "Expand-Archive resources.zip -DestinationPath resources"
return

exit:
    Tooltip, Menu: Off
    sleep 200
    ExitApp
return

f5::reload