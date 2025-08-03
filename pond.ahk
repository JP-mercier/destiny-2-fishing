#NoEnv
#SingleInstance, Force
SetWorkingDir, %A_ScriptDir%

#Include %A_ScriptDir%\Gdip_all.ahk

if not A_IsAdmin
{
    Run *RunAs "%A_AhkPath%" "%A_ScriptFullPath%"
}

; settings
{
    ; character_key
    global air_dodge_key := "{XButton2}"
    global charged_melee_key := "v"
    global heavy_weapon_key := 3
    global kinetic_weapon_key := 1

    ; ui shortcuts
    global open_inventory_key := "p"
    global interaction_key := "e"
    global character_key := "i"
    global map_key := "m"

    ; characters slots
    global hunter_slot := 2
    global titan_slot := 3

    ; others
    global ingame_sens := 7
    global loadout_slot := 9
    global ocr_trigger := "k"

    ; reticle
    global reticle_color := 3
    {
        Switch reticle_color
        {
        Case 1:
            reticle_color := "0xC4302F" ; Bright Red
        Case 2:
            reticle_color := "0x3BDA30" ; Lime Green
        Case 3:
            reticle_color := "0x28CCC9" ; Cyan / Aqua
        Case 4:
            reticle_color := "0xC1762D" ; Burnt Orange / Rust
        Case 5:
            reticle_color := "0xDB3CD4" ; Magenta / Fuchsia
        Case 6:
            reticle_color := "0xD5D52D" ; Yellow
        Case 7:
            reticle_color := "0x353630" ; Black
        }
    }
}

; images
{
    global emblem_path := A_ScriptDir . "\images\emblem.png" ; emblem

    ; 2560x1440
    global lightfall_path := A_ScriptDir . "\images\lightfall.png" ; Lightfall
    global baits_path := A_ScriptDir . "\images\baits.png" ; fishing tackle

    ; 1920x1080
    If (A_ScreenWidth = 1920)
    {
        global lightfall_path := A_ScriptDir . "\images\1080p_lightfall.png" ; Lightfall
        global baits_path := A_ScriptDir . "\images\1080p_baits.png" ; fishing tackle
    }
}

; coords
{
    ; 2560x1440
    global top_reticle_x := 1199
    global top_reticle_y := 688
    global bot_reticle_x := 1203
    global bot_reticle_y := 759

    global top_radar_x := 57
    global top_radar_y := 55
    global bot_radar_x := 265
    global bot_radar_y := 273

    global top_health_x := 1078
    global top_health_y := 53
    global bot_health_x := 1500
    global bot_health_y := 599

    global top_lamp_x := 761
    global top_lamp_y := 517
    global bot_lamp_x := 808
    global bot_lamp_y := 602

    global top_e_x := 1087
    global top_e_y := 1133
    global bot_e_x := 1110
    global bot_e_y := 1156

    global top_blueRes_x := 85
    global top_blueRes_y := 1321
    global bot_blueRes_x := 93
    global bot_blueRes_y := 1333

    global top_ft_lead_x := 1872
    global top_ft_lead_y := 76
    global bot_ft_lead_x := 1881
    global bot_ft_lead_y := 91

    ; 1920x1080
    If (A_ScreenWidth = 1920)
    {
        global top_reticle_x := 900
        global top_reticle_y := 518
        global bot_reticle_x := 902
        global bot_reticle_y := 568

        global top_radar_x := 43
        global top_radar_y := 41
        global bot_radar_x := 200
        global bot_radar_y := 205

        global top_health_x := 808
        global top_health_y := 40
        global bot_health_x := 1125
        global bot_health_y := 449

        global top_lamp_x := 571
        global top_lamp_y := 388
        global bot_lamp_x := 606
        global bot_lamp_y := 452

        global top_e_x := 815
        global top_e_y := 850
        global bot_e_x := 833
        global bot_e_y := 867

        global top_blueRes_x := 63
        global top_blueRes_y := 990
        global bot_blueRes_x := 72
        global bot_blueRes_y := 1003

        global top_ft_lead_x := 1400
        global top_ft_lead_y := 50
        global bot_ft_lead_x := 1411
        global bot_ft_lead_y := 68
    }

    ; 3840x1080
    If (A_ScreenWidth = 3840)
    {
        global top_reticle_x := 1860
        global top_reticle_y := 518
        global bot_reticle_x := 1862
        global bot_reticle_y := 568

        global top_radar_x := 2589
        global top_radar_y := 36
        global bot_radar_x := 2764
        global bot_radar_y := 207

        global top_health_x := 3613
        global top_health_y := 155
        global bot_health_x := 4025
        global bot_health_y := 384

        global top_lamp_x := 3481
        global top_lamp_y := 104
        global bot_lamp_x := 3548
        global bot_lamp_y := 206

        global top_e_x := 3694
        global top_e_y := 851
        global bot_e_x := 3711
        global bot_e_y := 868

        global top_blueRes_x := 2597
        global top_blueRes_y := 991
        global bot_blueRes_x := 2622
        global bot_blueRes_y := 1005

        global top_ft_lead_x := 1400
        global top_ft_lead_y := 50
        global bot_ft_lead_x := 1411
        global bot_ft_lead_y := 68
    }
}

; limiter gui
{
    Gui, +E0x20 -caption +AlwaysOnTop +ToolWindow
    Gui, Color, Black, Gray
    Gui, Font, S14 CWhite Bold, Verdana
    Gui, Add, Text, x30 y13 w70 h30 vMMM, OFF
    Gui, Show, x0 y0 h50 w100, 3074
    WinSet, Transparent, 255, 3074
    global 3074Toggle := 0
}

; parameters
{
    global pToken := Gdip_Startup()

    ; 2560x1440
    global coords := "1243|971|37|21"
    global width := 37
    global height := 21
    global threshold := 0.16

    if (A_ScreenWidth = 1920)
    {
        global coords := "932|728|27|16"
        global width := 27
        global height := 16
        global threshold := 0.12
    }

    if (A_ScreenWidth = 3840)
    {
        global coords := "3803|828|27|16"
        global width := 27
        global height := 16
        global threshold := 0.12
    }

    global res_scalar := 7
    global active_pond := 0
    global pond_state := 0
    global bait_nbr := 0
    global res_pos := 1
    global is_dead := 0
    global spawn := 0
    global old_bait_nbr := 0
    global is_cptn_dead := 0
    global i := 0
    global 2nd_spawn_area := 0
    global movement_increment := 5
    global sweep_pos := 0
}

; ==== main ====
{
    Loop, 2
    {
        3074_toggle()
        Sleep, 1000
    }
    Loop
    {
        FileRead, bait_nbr, %A_ScriptDir%\baits.txt

        ; 1st run
        If (bait_nbr < 497)
        {
            character_select(titan_slot)
            orbit_spawn_select(2)
            initial_run()
        }

        ; ==== bait farm ====
        While (bait_nbr < 497)
        {
            WinActivate, Destiny 2

            ls_run()
            res_exit()
            respawn_point_check()
            If ((is_dead = 1) and (res_pos = 1))
            {
                ls_path_out()
            }
            Else
            {
                trostland_tp()
                initial_run()
            }
        }
        game_restart()

        ; change to hunter
        character_select(hunter_slot)
        orbit_spawn_select(1)

        ; ==== fishing ====
        While (bait_nbr>2)
        {
            WinActivate, Destiny 2
            spawn_to_1st_pond()
            pond_state := pond_check()

            If (pond_state = 0)
            {
                1st_pond_to_2nd_pond()
                If (pond_check()=1)
                {
                    2nd_pond_fishing()
                }
            }
            If (pond_state = 1)
            {
                1st_pond_fishing()
            }
            winding_cove_tp()
            Sleep, 30000 ; 24000
            WinActivate, Destiny 2
        }
        character_screen()
    }
}
Return

; ========== functions ==========

swap_mark()
{
    Send, %character_key%
    Sleep, 1000
    Mouse_Move(1863,1022)

    Sleep, 50

    Mouse_Move(2006,1023)
    Sleep, 10
    Loop, 3
    {
        click
    }

    Sleep, 10
    bait_update()

    Sleep, 25
    Send, %character_key%

    Sleep, 3000
    Mouse_Move(1863,1022)
    Sleep, 50
    Mouse_Move(2006,1023)
    Sleep, 10
    Loop, 3
    {
        click
    }
    Sleep, 100
    Send, {Escape}
}

apply_loadout()
{
    If (loadout_slot != 0)
    {
        Send, %character_key%
        Sleep, 1000

        Send, {Left}
        Sleep, 200

        switch loadout_slot
        {
        case 1:
            Mouse_Move(193, 510)
        case 2:
            Mouse_Move(319, 521)
        case 3:
            Mouse_Move(194, 642)
        case 4:
            Mouse_Move(322, 642)
        case 5:
            Mouse_Move(195, 768)
        case 6:
            Mouse_Move(317, 769)
        case 7:
            Mouse_Move(191, 897)
        case 8:
            Mouse_Move(325, 898)
        case 9:
            Mouse_Move(198, 1027)
        case 10:
            Mouse_Move(322, 1019)
        }

        Sleep, 10
        Click
        Sleep, 10
        Click
        Sleep, 100

        Send, {Escape}
        Sleep, 300
        Send, {Escape}
        Sleep, 3000
    }
    Else
    {
        Sleep, 5000
    }
}

radar_activation()
{
    StartTime := A_TickCount
    While (A_TickCount - StartTime <= 5000)
    {
        PixelSearch, Px, Py, top_radar_x, top_radar_y, bot_radar_x, bot_radar_y, 0xBB473A, 25, Fast RGB
        if !ErrorLevel
        {
            break
        }
    }
}

area_sweep(direction)
{
    If (is_cptn_dead=0)
    {
        Loop, 15
        {
            cam_move(movement_increment * direction, 0)
            PixelSearch, Px, Py, top_reticle_x, top_reticle_y, bot_reticle_x, bot_reticle_y, % reticle_color, 25, Fast RGB
            if !ErrorLevel
            {
                Sleep, 100
                PixelSearch, Px, Py, top_health_x, top_health_y, bot_health_x, bot_health_y, 0xEAA742, 25, Fast RGB
                if !ErrorLevel
                {
                    is_cptn_dead := 1
                    break
                }
            }
            i := i+(1*direction)
            if (is_cptn_dead = 1)
            {
                break
            }
        }
    }
}

cam_move(cam_movement_x, cam_movement_y)
{
    ; Calculate the adjusted mouse movement
    new_x := cam_movement_x * res_scalar / ingame_sens
    new_y := cam_movement_y * res_scalar / ingame_sens

    ; Make the DLL call with the adjusted mouse movement
    DllCall("mouse_event", "UInt", 1, "Int", new_x, "Int", new_y, "UInt", 0, "Int", 0)
}

cptn_detection()
{
    i := 0
    is_cptn_dead := 0

    ; zone 1
    area_sweep(1)
    area_sweep(-1)

    ; zone 2
    If (is_cptn_dead=0)
    {
        i := i+40
        cam_move(200,0)
        area_sweep(1)
        area_sweep(-1)
    }

    ; zone 3
    If (is_cptn_dead=0)
    {
        i := i+130
        cam_move(650,0)
        area_sweep(1)
        area_sweep(-1)
    }
    Send, %charged_melee_key%
    Sleep, 750
    i := 130 - (i*5)
    cam_move(i,0)
}

dead_check()
{
    is_dead := 0

    StartTime := A_TickCount
    Loop
    {
        PixelSearch, Px, Py, top_e_x, top_e_y, bot_e_x, bot_e_y, 0x474747, 25, Fast RGB ; dark gray of the "e"
        if !ErrorLevel
        {
            PixelSearch, Px, Py, top_e_x, top_e_y, bot_e_x, bot_e_y, 0xFDFDFD, 25, Fast RGB ; white of the "e"
            if !ErrorLevel
            {
                StartTime1 := A_TickCount
                While (A_TickCount - StartTime1 <= 3000)
                {
                    PixelSearch, Px, Py, top_blueRes_x, top_blueRes_y, bot_blueRes_x, bot_blueRes_y, 0xC6E0FA, 25, Fast RGB ; res interaction_key
                    if !ErrorLevel
                    {
                        Sleep, 100
                        Send, %interaction_key%
                        break
                    }
                }
                is_dead := 1
                break
            }
        }

        if (A_TickCount - StartTime >= 5000)
        {
            is_dead := 0
            break
        }
    }
}

game_restart()
{
    WinKill, Destiny 2 ; Close Destiny 2 window
    Sleep, 30000 ; Wait for 30 seconds to ensure the window has fully closed
    Run, steam://rungameid/1085660,, Hide ; This launches Destiny 2 through Steam
    Sleep, 30000

    StartTime := A_TickCount
    While (A_TickCount - StartTime <= 80000)
    {
        ImageSearch, OutputVarX, OutputVarY, 0, 0, A_ScreenWidth, A_ScreenHeight, %lightfall_path%
        if !ErrorLevel
        {
            break
        }
    }

    WinActivate, Destiny 2
    Sleep, 10
    Send, {enter}

    StartTime := A_TickCount
    While (A_TickCount - StartTime <= 70000)
    {
        ImageSearch, OutputVarX, OutputVarY, 0, 0, A_ScreenWidth, A_ScreenHeight, %emblem_path%
        if !ErrorLevel
        {
            break
        }
    }
}

ls_path_out()
{
    cam_move(-3875,0)
    Sleep, 100
    Hold_key("w",250)
    Sleep, 100
    cam_move(3875,0)

    Sleep, 100
    cam_move(-2250, 0)
    Sleep, 100
    Hold_key("w",1900)
    Sleep, 100
    cam_move(-1900, 0)
    Sleep, 100
    Hold_key("w",4700)
    Sleep, 100
    cam_move(-1900, 0)
    Sleep, 100
    Hold_key("w", 4850)
    Sleep, 100
    cam_move(-3875,0)
    Sleep, 100
}

respawn_point_check()
{
    res_pos := 1
    PixelSearch, Px, Py, top_lamp_x, top_lamp_y, bot_lamp_x, bot_lamp_y, 0xF5F8EF, 25, Fast RGB
    if !ErrorLevel
    {
        res_pos := 0
    }
}

bait_update()
{
    Send, %open_inventory_key%
    StartTime := A_TickCount
    While (A_TickCount - StartTime <= 10000)
    {
        ImageSearch, x_pos, y_pos, 0, 0, A_ScreenWidth, A_ScreenHeight, %baits_path%
        If !ErrorLevel
        {
            Break
        }
    }
    MouseMove, x_pos, y_pos, 1
    Sleep, 70
    Send, %ocr_trigger%

    StartTime := A_TickCount
    While (A_TickCount - StartTime <= 200)
    {
        If GetKeyState("b", "P")
            Break
    }

    SetTimer, read_file, 1000
}

orbit_spawn_select(spawn)
{
    Send, %map_key%
    Sleep, 1250
    Mouse_Move(942,1274)
    click
    click
    Sleep, 1000
    Mouse_Move(689,1440)
    Sleep, 500
    If (spawn=1)
    {

        If (A_ScreenWidth = 1920)
        {
            MouseMove, 517,637, 1
        }
        Else
        {
            Mouse_Move(690,988)
        }
    }
    If (spawn=2)
    {
        If (A_ScreenWidth = 1920)
        {
            MouseMove, 1396, 565 , 1
        }
        Else
        {
            Mouse_Move(1862,880)
        }
    }
    Sleep, 100
    Click
    Sleep, 750
    Mouse_Move(2174,1202)
    Sleep, 100
    Click
    Sleep, 5000

    bait_update()
    Send, %open_inventory_key%
    Sleep, 6000

    apply_loadout()
    Sleep, 40000 ;19000
}

character_screen()
{
    Sleep, 100
    Send, {Escape}
    Sleep, 1000
    Mouse_Move(913,799)
    Sleep, 10
    Click
    Sleep, 10
    Send, {enter}
    Sleep, 5000
}

character_select(slot)
{
    MouseMove, 1805 * (A_ScreenWidth / 2560), (613+((slot-1) * 150)) * (A_ScreenHeight / 1440), 1
    Sleep, 2000
    Click
    Sleep, 3000

    StartTime := A_TickCount
    While (A_TickCount - StartTime <= 20000)
    {
        PixelSearch, px, py, top_ft_lead_x, top_ft_lead_y, bot_ft_lead_x, bot_ft_lead_y, 0xD7DD00, 25
        If !ErrorLevel
        {
            break
        }
    }
}

1st_pond_fishing()
{
    Hold_key("w", 2000)
    Sleep, 10
    cam_move(-3940, 0)
    Sleep, 500
    fishing()
}

2nd_pond_fishing()
{
    cam_move(2000, 0)
    Sleep, 100
    Hold_key("w",1000)
    Sleep, 100
    cam_move(-2950, 0)
    Sleep, 500
    Hold_key("w",250)
    fishing()
}

winding_cove_tp()
{
    WinActivate, Destiny 2
    Send, %kinetic_weapon_key%
    Sleep, 10
    Send, %map_key%
    Sleep, 750
    Mouse_Move(689,1440)
    Sleep, 500
    If (A_ScreenWidth = 2560)
    {
        Mouse_Move(691,1148)
    }
    Else
    {
        MouseMove, 514, 777,1
    }
    Click, Down
    Sleep, 1200
    Click, Up
}

pond_check()
{
    active_pond := 0

    StartTime := A_TickCount
    Loop
    {
        pBitmap := Gdip_BitmapFromScreen(coords)
        pWhite := simpleColorCheck(pBitmap, width, height)
        Gdip_DisposeImage(pBitmap)
        if (pWhite >= threshold)
        {
            active_pond := 1
            Break
        }
        If (A_TickCount - StartTime > 2000)
        {
            active_pond := 0
            Break
        }
    }
    Return active_pond
}

1st_pond_to_2nd_pond()
{
    Sleep, 10
    cam_move(1850, 0)
    Sleep, 10
    Hold_key("w",2250)
    Sleep, 10
    cam_move(-3970, 0)
    Sleep, 10

    shatterskate()
    Sleep, 600
    Send, {Space}
    Sleep, 1350
    Send, {space}
    Sleep, 10
    Send, {w up}
    Sleep, 750
    Send, %air_dodge_key%
    Sleep, 1000
    Send, %kinetic_weapon_key%
    Sleep, 200
    Hold_key("w",5000)
    Sleep, 100
    Hold_key("s",2000)
    Sleep, 100
}

fishing()
{
    gtfo:= 0

    Sleep, 1000
    While(gtfo=0)
    {
        Loop, 30
        {
            Sleep, 1000
            If (pond_check()=0 or bait_nbr<1)
            {
                gtfo:=1
                break
            }
            Loop, 2
            {
                StartTime := A_TickCount
                While (A_TickCount - StartTime <= 60000)
                {
                    pBitmap := Gdip_BitmapFromScreen(coords)
                    pWhite := simpleColorCheck(pBitmap, width, height)
                    Gdip_DisposeImage(pBitmap)
                    if (pWhite >= threshold)
                    {
                        Break
                    }
                }
                Sleep, 100
                Send, {%interaction_key% down}
                Sleep, 800
                Send, {%interaction_key% Up}
                Sleep, 10
            }
            bait_update()
            Send, %open_inventory_key%
        }
        Sleep, 1000
        fish_pickup()
    }
}

fish_pickup()
{
    Send, o
    Sleep, 10
    Hold_key("s", 300)
    Sleep, 200
    Hold_key("w", 200)
    Sleep, 200
    Hold_key("a", 750)
    Sleep, 200
    Hold_key("w", 750)
    Sleep, 200
    Hold_key("d", 1475)
    Sleep, 200
    Hold_key("s", 765)
    Sleep, 200
    Hold_key("a", 750)
    Sleep, 1500
}

initial_run()
{
    WinActivate, Destiny 2
    Hold_key("d",300)
    Send, %interaction_key%
    Sleep, 10
    Hold_key("w",2400)
    Send, {space}
    Hold_key("w",2200)

    cam_move(-525, 0)
    Hold_key("w",5000)

    cam_move(-450, 0)
    Hold_key("w",2400)

    cam_move(1020, 0)
    Hold_key("w",3850)

    cam_move(-1020, 0)
    Hold_key("w",1300)

    cam_move(-4000, 0)
    Sleep, 1500
    Hold_key("w",1950)

    cam_move(1020, 0)
    Hold_key("w",4000)
    Sleep, 1000

    Hold_key("s",500)
    cam_move(-1020, 0)

    Hold_key("w",1200)
    cam_move(1950, 0)

}

ls_run()
{
    Sleep, 100
    Hold_key("w", 4950)
    cam_move(1950, 0)
    3074_toggle()

    Hold_key("w", 4500)
    cam_move(1450, 0)
    Sleep, 125

    Send, {w down}
    Send, {w down}
    Sleep, 500
    Send, {space}
    Sleep, 950
    Send, {space}
    Sleep, 400
    Send, {w up}
    cam_move(-2000, 0)

    Hold_key("w", 5000)
    cam_move(2650, 0)

    Hold_key("w", 5325)
    Sleep, 10

    cam_move(-2400, 0)
    3074_toggle()
    Hold_key("w", 2000)
    Sleep, 10
    cam_move(2210, 50)
    radar_activation()
    cptn_detection()
    Send, %charged_melee_key%

    Hold_key("w", 1610)
    Sleep, 100
    cam_move(1900, 400)
    Sleep, 10
    Hold_key("a", 200)
    Sleep, 10
    Hold_key("e", 1000)
}

3074_toggle()
{
    3074Toggle := !3074Toggle
    If 3074Toggle
    {
        GuiControl,, MMM, ON
        Run %comspec% /c netsh advfirewall firewall add rule name="3074r1" dir=in remoteport=3074 protocol=UDP action=Block,, Hide
        Run %comspec% /c netsh advfirewall firewall add rule name="3074r2" dir=out remoteport=3074 protocol=UDP action=Block,, Hide
    }
    Else
    {
        GuiControl,, MMM, OFF
        Run %comspec% /c netsh advfirewall firewall delete rule name="3074r1",, Hide
        Run %comspec% /c netsh advfirewall firewall delete rule name="3074r2",, Hide
    }
    Sleep, 300
    WinActivate, Destiny 2
}

trostland_tp()
{
    Sleep, 100
    Send, %map_key%
    Sleep, 750
    Mouse_Move(1200,1440)
    Sleep, 325
    If (A_ScreenWidth = 1920)
    {
        MouseMove, 1398,797, 1
    }
    Else
    {
        Mouse_Move(1858,1125)
    }
    Sleep, 500
    Send, {Click, down}
    Sleep, 1200
    Send, {Click, up}
    Sleep, 5000 ; load delay
    bait_update()
    Send, %open_inventory_key%
    Sleep, 25000
    Send, %kinetic_weapon_key%
}

res_exit()
{
    swap_mark()
    ; swap_marks()

    dead_check()
    If (is_dead = 1)
    {
        Sleep, 1000
        Send, %interaction_key%
        Sleep, 2250
    }
    Else
    {
        is_dead := 0
    }
}

simpleColorCheck(pBitmap, w, h)
{
    x := 0
    y := 0
    white := 0
    total := 0
    loop %h%
    {
        loop %w%
        {
            color := (Gdip_GetPixel(pBitmap, x, y) & 0x00F0F0F0)
            if (color == 0xF0F0F0)
                white += 1
            total += 1
            x+= 1
        }
        x := 0
        y += 1
    }
    pWhite := white/total
    return pWhite
}

spawn_to_1st_pond()
{
    Send, %kinetic_weapon_key%
    Sleep, 10
    cam_move(-2400, -300)
    Sleep, 100
    Hold_key("w", 1350)
    Sleep, 10
    cam_move(-3212, 0)
    Sleep, 100
    shatterskate()
    Sleep, 750
    Send, {Space}
    Sleep, 1000
    Send, {Space}
    Sleep, 2000

    Send, %kinetic_weapon_key%
    Sleep, 3600
    Send, {w up}
    Sleep, 1000
    cam_move(-200, 0)
    Sleep, 10
    
    Loop, 10
    {
        Hold_key("w", 100)
        Sleep, 200
    }
    Sleep, 500
    Hold_key("s", 200)
    Sleep, 100
    Hold_key("a", 200)
    Sleep, 10
    cam_move(3000, 0)
    Sleep, 200
    Send, {Space}
    Sleep, 400
    Send, {Space}
    Sleep, 500
    Hold_key("w", 500)
    cam_move(-1620, 0)
    Sleep, 500
    shatterskate()
    Sleep, 750

    Send, {Space down}
    Sleep, 1000
    Send, {Space up}

    Sleep, 3000
    Send, {w up}
    Send, %kinetic_weapon_key%
    Sleep, 10
    Hold_key("a", 300)
    Sleep, 10
    cam_move(-1200, 0)
    Hold_key("w", 1500)
    cam_move(2475, 0)
    Hold_key("w", 200)
    Hold_key("a", 200)
    Sleep, 200

    Send, {Space}
    Sleep, 100
    Send, {w down}
    Sleep, 500
    Send, {Space}
    Sleep, 2500
    Send, {Space}
    Sleep, 3750
    Send, {w up}
    Sleep, 500
}

shatterskate()
{
    Send, %heavy_weapon_key%
    Sleep, 350
    Click, right
    Click, right
    Sleep, 10
    Send, {Space}
    Send, %air_dodge_key%
    Send, {w down}
}

Hold_key(key, duration)
{
    Send, {%key% down}
    Sleep, duration
    Send, {%key% up}
}

Mouse_Move(cord_x, cord_y)
{
    MouseMove, cord_x * (A_ScreenWidth / 2560), cord_y * (A_ScreenHeight / 1440), 1
}

read_file:
    FileRead, bait_nbr, %A_ScriptDir%\baits.txt
Return