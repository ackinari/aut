; ###################################### ;
; 	color_picker by aKiNaRi	 ;
; ###################################### ;

Gui, 2:Font, s7 bold, MS Sans Serif
Gui, 2:Add, Text, x8 ycenter vtext, FFFFFF

getColor()

getColor()
{
    CoordMode, Mouse, Screen
    CoordMode, Pixel, Screen
    SetBatchLines, -1
    While (!GetKeyState("ctrl"))
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

        ; Atualize o valor do controle de texto (vtext) com a cor selecionada
        GuiControl,, vtext, %color%

        Gui, 2:+AlwaysOnTop -Caption +ToolWindow +LastFound +Border
        GuiControl, 2:, Text, %color%
        Gui, 2:Show, NoActivate x%mX% y%mY% w60 h15
    }
    clipboard = %color%

    Gui, 1:hide
    Gui, 2:hide

    ToolTip, Color Picked! (%color%)
    Sleep 500
    Tooltip
    ;ExitApp
    return
}