#SingleInstance, Force
SendMode, Input
#NoEnv

#IfWinActive, ahk_exe GameMaker.exe
{
    +SC01B::
        sendraw, {}
        send, {Left}
    return
}