#NoEnv
#SingleInstance, Force
#InstallKeybdHook
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

if not A_IsAdmin {
    Run *RunAs "%A_AhkPath%" "%A_ScriptFullPath%"
}

global pythonPath := A_AppData . "\\..\\Local\\Microsoft\\WindowsApps\\python3.10.exe"

; ====== main ======

If (!WinExist("ahk_exe python3.10.exe"))
{
    Run, %pythonPath% ".\baits_ocr.py"
}

f3::
    {
        ; Add rules with invisible window
        Run, netsh advfirewall firewall add rule name="Destiny2-Solo-1" dir=out remoteport=27000-27100 protocol=tcp action=block,, Hide
        Run, netsh advfirewall firewall add rule name="Destiny2-Solo-2" dir=out remoteport=27000-27100 protocol=udp action=block,, Hide
        Run, netsh advfirewall firewall add rule name="Destiny2-Solo-3" dir=in localport=27000-27100 protocol=tcp action=block,, Hide
        Run, netsh advfirewall firewall add rule name="Destiny2-Solo-4" dir=in localport=27000-27100 protocol=udp action=block,, Hide

        Loop
        {
            If (!WinExist("ahk_exe python3.10.exe"))
            {
                Run, %pythonPath% ".\baits_ocr.py"
            }
            Run, ".\pond.ahk",,, pond_pid
            
            Loop
            {
                FileRead, old_bait_nbr, %A_ScriptDir%\baits.txt
                Sleep, 330000
                FileRead, current_bait_nbr, %A_ScriptDir%\baits.txt

                If (current_bait_nbr = old_bait_nbr)
                {
                    Process, close, %pond_pid%
                    Send, {e up}
                    Send, {w up}
                    Send, {a up}
                    Send, {s up}
                    Send, {d up}
                    Send, {Space up}

                    game_restart()
                    break
                }
            }
        }
    }
Return

f4::
    {
        Process, close, %pond_pid%
        ; RunWait, powershell.exe -ExecutionPolicy Bypass -File ".\closer.ps1",, Hide UseErrorLevel

        Run, netsh advfirewall firewall delete rule name="Destiny2-Solo-1",, Hide
        Run, netsh advfirewall firewall delete rule name="Destiny2-Solo-2",, Hide
        Run, netsh advfirewall firewall delete rule name="Destiny2-Solo-3",, Hide
        Run, netsh advfirewall firewall delete rule name="Destiny2-Solo-4",, Hide

        Send, {e up}
        Send, {w up}
        Send, {a up}
        Send, {s up}
        Send, {d up}

        Reload
    }
Return

; ====== function ======

game_restart()
{
    WinKill, Destiny 2
    Sleep, 30000
    Run, steam://rungameid/1085660,, Hide
    Sleep, 30000

    StartTime := A_TickCount
    While (A_TickCount - StartTime <= 100000)
    {
        ImageSearch, OutputVarX, OutputVarY, 0, 0, A_ScreenWidth, A_ScreenHeight, lightfall.png
        if !ErrorLevel
        {
            break
        }
    }

    WinActivate, Destiny 2
    Sleep, 10
    WinActivate, Destiny 2
    Sleep, 10
    Send, {enter}

    StartTime := A_TickCount
    While (A_TickCount - StartTime <= 60000)
    {
        ImageSearch, OutputVarX, OutputVarY, 0, 0, A_ScreenWidth, A_ScreenHeight, emblem.png
        if !ErrorLevel
        {
            break
        }
    }
}
