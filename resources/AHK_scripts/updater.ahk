#SingleInstance Force
SetWorkingDir %A_ScriptDir%

sleep 10000
CheckAndUpdateVersion()

CheckAndUpdateVersion() {
    Process, Close, menu.exe
    new_version:= URLDownloadToVar("https://raw.githubusercontent.com/ackinari/aut/main/resources/version.txt")
    FileRead, current_version, %AppData%/.akinari/aut-main/resources/version.txt

    If (current_version == new_version) {
        RunCurrentVersion()
    }
    else
    {
        DownloadUpdatedVersion()
        RunCurrentVersion()
    }
}

URLDownloadToVar(url) {
 WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
 WebRequest.Open("GET", url)
 WebRequest.Send()
 Return, WebRequest.ResponseText
}

DownloadUpdatedVersion() {
    If FileExist("C:\Program Files\7-Zip\7z.exe")
    {
        UrlDownloadToFile, https://github.com/ackinari/aut/archive/refs/heads/main.zip, aut.zip
        runwait, "C:\Program Files\7-Zip\7z.exe" x "aut.zip" -o"%AppData%\.akinari" -y,,hide
        FileDelete, aut.zip
    }
    else
    {
        if not A_IsAdmin {
            Run *RunAs "%A_ScriptFullPath%"
        }
        if A_IsAdmin {
            MsgBox, 7z Not Installed
            UrlDownloadToFile, https://www.7-zip.org/a/7z2301-x64.exe, 7z2301-x64.exe
            runwait, 7z2301-x64.exe
            sleep, 500
            FileDelete, 7z2301-x64.exe
            sleep, 1000
            reload
        }
    }

}

RunCurrentVersion() {
    run "%AppData%\.akinari\aut-main\resources\builds\menu.exe"
}