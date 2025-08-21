#singleInstance force
#noEnv
setWorkingDir %A_ScriptDir%
setBatchLines -1

gui, destroy
gui, +alwaysOnTop +lastFound MinSize400x400 +resize
gui, font, s8 cBlack, Verdana

gui Add, Tab3, x0 y0 vTab, String|File
gui Tab, 1
    gui, add, text, x10 y30, | Start |
    gui, add, edit, x10 y+5 w45 h20 vMinNumberString, 0,5

    gui, add, text, x60 y30, | Final |
    gui, add, edit, x60 y+5 w43 h20 vMaxNumberString, 5,10

    gui, add, text, x110 y30, | Replace |
    gui, add, edit, x111 y+5 w60 h20 vReplaceString, #,$

    gui, add, button, x+15 y40 w70 h23 ggenerateString, Generate
    
    gui, add, edit, x10 y+10 vInputTextString Multi vscroll, $ repeated # times!

gui Tab, 2
    gui, add, text, x10 y30, |                                        Output                                        |
    gui, add, button, x10 y+3 w20 h20 gselectFolder, >
    gui, add, edit, x+5 w340 h20 vOutputFile, C:\Users\%A_UserName%\Downloads

    gui, add, text, x10 y+5, | Start |
    gui, add, text, x+5, | Final |
    gui, add, text, x+5, | Replace |
    gui, add, text, x+5, | Name |
    gui, add, text, x+5, | Type |

    gui, add, edit, x10 y+3 w45 h20 number vMinNumberFile, 0
    gui, add, edit, x+8 w43 h20 number vMaxNumberFile, 5
    gui, add, edit, x+5 w60 h20 vReplaceFile, #
    gui, add, edit, x+8 w48 h20 vFileName, file_#
    gui, add, ComboBox, x+8 w50 vFileType Choose1, json|txt

    gui, add, button, x+15 w70 h20 ggenerateFile, Generate

    gui, add, edit, x10 y+10 vInputTextFile Multi vscroll, file number #

gui, Show,, Looping Tool
return

guiEscape:
guiClose:
    gui, destroy
    exitApp
return

guiSize:
    guiControl, move, Tab, % "w" A_GuiWidth "h" A_GuiHeight
    guiControl, move, InputTextString, % "w" A_GuiWidth-20 "h" A_GuiHeight-90
    guiControl, move, InputTextFile, % "w" A_GuiWidth-20 "h" A_GuiHeight-130
return

generateString:
    gui, submit, noHide
    gui, destroy

    replacers := []
    minsArr   := []
    maxsArr   := []

    Loop, Parse, ReplaceString, % ","
        replacers.Push(Trim(A_LoopField))

    Loop, Parse, MinNumberString, % ","
        minsArr.Push(Trim(A_LoopField))

    Loop, Parse, MaxNumberString, % ","
        maxsArr.Push(Trim(A_LoopField))

    totalIters := 0
    Loop % replacers.Length() {
        range := maxsArr[A_Index] - minsArr[A_Index] + 1
        if (range > totalIters)
            totalIters := range
    }

    OutputText := ""
    Loop % totalIters {
        line := InputTextString
        idx := A_Index

        Loop % replacers.Length() {
            start := minsArr[A_Index]
            final := maxsArr[A_Index]

            current := start + (idx - 1)
            if (current > final)
                current := final

            line := RegExReplace(line, "\Q" replacers[A_Index] "\E", current, "", 1)
        }
        OutputText .= line "`n"
    }

    clipboard := OutputText
    tooltip, Copiado!
    sleep 1000
    tooltip
exitApp

selectFolder:
    FileSelectFolder, output, , 1, Selecione a pasta de destino
    if (output != "")
        guiControl, text, OutputFile, %output%
return

generateFile:
    gui, submit, noHide
    gui, destroy

    if !FileExist(OutputFile)
        FileCreateDir, %OutputFile%


    loop, % (MaxNumberFile - MinNumberFile + 1)
    {
        _InputText := strReplace(InputTextFile, ReplaceFile, A_Index + MinNumberFile - 1)
        _fileName := strReplace(FileName, ReplaceFile, A_Index + MinNumberFile - 1)
        FileAppend, %_InputText%, %OutputFile%\%_fileName%.%FileType%
    }
    tooltip, Arquivos Criados!
    sleep 1000
    tooltip
exitApp