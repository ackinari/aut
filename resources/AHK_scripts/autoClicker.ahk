#MaxThreadsPerHotkey 3
#SingleInstance force
SetWorkingDir %A_ScriptDir%
#NoEnv

menu, tray, icon, ../icons/off.ico
toggle := 0
delay := 100
key := "f1"

gui,destroy
gui,+AlwaysOnTop +Caption +ToolWindow +LastFound -DPIScale
gui,color, FFFFFF
gui,font, s8, Arial
gui,Add, text, x14, Macro Key:
gui,Add, hotkey, x15 w50 h20 v_selectedKey, %key%
gui,Add, text, x10, Macro Delay:
gui,Add, edit, number x15 w50 h20 v_selectedDelay, %delay%
Gui,Add, button, x15 w50 h20 default gSubmit, Ok
gui,Show, w80 h125, - Macro -
return

GuiEscape:
GuiClose:
    gui,destroy
    exitapp
return

Submit:
    gui,submit
    gui,destroy
    if %_selectedKey% {
        if %_selectedDelay% {
            delay := _selectedDelay
        }
        hotkey,%_selectedKey%,macro
        tooltip Macro Key: %_selectedKey%`nMacro Delay: %delay%
        sleep 2000
        tooltip
    }
    else {
        tooltip No key selected
        sleep 2000
        tooltip Press Ctrl + Win to re-select
        sleep 2000
        tooltip
    }
return

macro:
    toggle := !toggle
    soundbeep, 550, 100
    If toggle {
        menu, tray, icon, ../icons/on.ico
        while toggle
        {
            click
            sleep %delay%
        }
        Return
    }
    else {
        menu, tray, icon, ../icons/off.ico
    }
return

^lwin::
    reload
return