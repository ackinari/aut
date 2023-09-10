#SingleInstance force

Gui +LastFound
Gui, Margin, 10, 10
Gui, Add, Text, x5 y5, Insira o texto:
Gui, Add, Edit, x5 y25 w250 h80 vTexto Multi vscroll
Gui, Add, Text, x5 y110, Substituir:
Gui, Add, Edit, x5 y130 w200 h20 vPalavra
Gui, Add, Text, x215 y110, Repetições:
Gui, Add, Edit, x215 y130 w25 h20 vFim
Gui, Add, Button, x5 y155 w100 h30 gGerar, Gerar
Gui, Show, w280 h195, Macro de repetições
return

GuiClose:
  ExitApp
Return

Gerar:
  Gui, Submit, NoHide
  Clipboard := ""
  Loop, %Fim%
  {
    textoNovo := StrReplace(Texto, Palavra, A_Index)
    Clipboard := Clipboard . textoNovo . "`n"
  }
return