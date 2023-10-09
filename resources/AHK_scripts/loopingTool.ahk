#singleInstance force
#noEnv
setWorkingDir %A_ScriptDir%
setBatchLines -1

gui, destroy
gui, +alwaysOnTop +lastFound MinSize400x400 +resize
gui, font, s8 cBlack, Verdana

gui, add, text, x10 y5, | Start |
gui, add, edit, x10 y+5 w45 h20 number vMinNumber, 0

gui, add, text, x60 y5, | Final |
gui, add, edit, x60 y+5 w43 h20 number vMaxNumber, 10

gui, add, text, x110 y5, | Replace |
gui, add, edit, x111 y+5 w60 h20 vReplace, #

gui, add, button, x+15 w80 h23 gGenerate, Generate

gui, add, edit, x10 y+5 vInputText Multi vscroll, repeated # times!
gui, Show,, Looping Tool
return

guiEscape:
guiClose:
    gui, destroy
    exitApp
return

guiSize:
    guiControl, move, InputText, % "w" A_GuiWidth-20 "h" A_GuiHeight-65
return

Generate:
    gui, submit, noHide
    gui, destroy
    loop, % (MaxNumber - MinNumber + 1)
    {
        _InputText := strReplace(InputText, Replace, A_Index + MinNumber - 1)
        OutputText .= _InputText "`n"
    }
    clipboard = %OutputText%
    tooltip, Copiado!
    sleep 1000
    tooltip
exitApp