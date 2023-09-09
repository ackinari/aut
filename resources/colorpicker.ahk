; ###################################### ;
; 	color_picker by aKiNaRi	 ;
; ###################################### ;

#SingleInstance, Force
#NoTrayIcon
#NoEnv
SetBatchLines, -1
SendMode Input

CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

Gui, 2:Font, s7 bold, MS Sans Serif
Gui, 2:Add, Text, x8 ycenter vtext, FFFFFF

getColor()

getColor()
{
    While(!GetKeyState("ctrl"))
    {

    MouseGetPos X, Y
    PixelGetColor color, X, Y, RGB
    color := SubStr(color, 3)

    ToolTip, Press "Ctrl" To Pick Current Color

    mX := X - 30
    mY := Y - 95

    Gui, 1:+AlwaysOnTop -Caption +ToolWindow +LastFound +Border
    Gui, 1:Color, %color%
    Gui, 1:Show, NoActivate x%mX% y%mY% w60 h65

    Gui, 2:+AlwaysOnTop -Caption +ToolWindow +LastFound +Border
    Guicontrol,2:, text, %color%
    Gui, 2:Show, NoActivate x%mX% y%mY% w60 h15

    }
    clipboard = %color%

    Gui, 1:hide
    Gui, 2:hide

    ToolTip, Color Picked! (%color%)
    sleep 500
    tooltip
    ExitApp
}