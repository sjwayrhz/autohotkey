#Requires AutoHotkey v2.0

#Include <FindText>
#Include <sport_fishing_variables_huawei>

; 热键: 按下ctrl+1键来切换default脚本的启动和停止
^1:: ToggleFishing("default")

; 热键: 按下ctrl+2键来执行船舶自动加速
^2:: ToggleShipAutoRun()

; 热键: 按下ctrl+3键来切换mirage脚本的启动和停止
^3:: ToggleFishing("mirage")

; 全局变量
global activeFunction := "none"  ; 可能的值: "none", "fishing_default", "fishing_mirage", "shipautorun"

; 钓鱼脚本状态的函数
ToggleFishing(method := "default") {
    global activeFunction
    if (activeFunction == "fishing_" . method) {
        StopActiveFunction()
    } else {
        StopActiveFunction()
        activeFunction := "fishing_" . method
        SetTimer(FishingTrigger, 100)
        if (method == "default") {
            SoundPlay "voice\start_fishing_default.mp3"
            ToolTip("默认钓鱼脚本已启动")
        } else {
            SoundPlay "voice\start_fishing_mirage.mp3"
            ToolTip("海市蜃楼钓鱼脚本已启动")
        }
        SetTimer(() => ToolTip(), -2000)
    }
}

; 切换船舶自动加速状态的函数
ToggleShipAutoRun() {
    global activeFunction
    if (activeFunction == "shipautorun") {
        StopActiveFunction()
    } else {
        StopActiveFunction()
        activeFunction := "shipautorun"
        SetTimer(ShipAutoRunTrigger, 1000)
        SoundPlay "voice\start_ship_accelerate.mp3"
        ToolTip("船舶自动加速已启动")
        SetTimer(() => ToolTip(), -2000)
    }
}

; 停止当前活动的功能
StopActiveFunction() {
    global activeFunction
    SetTimer(FishingTrigger, 0)
    SetTimer(ShipAutoRunTrigger, 0)
    activeFunction := "none"
    ToolTip("脚本已暂停")
    SetTimer(() => ToolTip(), -2000)
    SoundPlay "voice\the_script_is_paused.mp3"
}

; 钓鱼功能的触发器
FishingTrigger() {
    global activeFunction
    if (activeFunction != "fishing_default" && activeFunction != "fishing_mirage") {
        return
    }
    if (FindText(&X, &Y, x3, y3, x4, y4, 0.1, 0.1, fish_spawn)) {
        Fishing(activeFunction == "fishing_mirage")
    } else {
        Searching()
    }
}

; 船舶自动加速触发器
ShipAutoRunTrigger() {
    global activeFunction
    if (activeFunction != "shipautorun") {
        return
    }

    static lastActionTime := 0
    currentTime := A_TickCount

    ; 检查是否已经过了至少1秒
    if (currentTime - lastActionTime < 1000) {
        return
    }

    X := Y := 0
    if (FindText(&X, &Y, 0, 0, A_ScreenWidth, A_ScreenHeight, 0, 0, clipper)
    || FindText(&X, &Y, 0, 0, A_ScreenWidth, A_ScreenHeight, 0, 0, fish_finder1)
    || FindText(&X, &Y, 0, 0, A_ScreenWidth, A_ScreenHeight, 0, 0, fish_finder2)) {
        Send "{Numpad6}"
        lastActionTime := currentTime
    }
    if (FindText(&X, &Y, 0, 0, A_ScreenWidth, A_ScreenHeight, 0, 0, speedboat)) {
        Send "c"
        Sleep 1000
        Send "c"
        Sleep 1000
        Send "c"
        lastActionTime := currentTime
    }
}

Searching() {
    global activeFunction
    if (activeFunction != "fishing_default" && activeFunction != "fishing_mirage") {
        return
    }

    timeLimit := (activeFunction == "fishing_default") ? 40000 : 180000
    lastInputTime := A_TickCount

    loop {
        if (activeFunction != "fishing_default" && activeFunction != "fishing_mirage") {
            return
        }

        if (FindText(&X, &Y, x3, y3, x4, y4, 0.1, 0.1, fish_spawn)) {
            SoundPlay "voice\already_hooked.mp3"
            Sleep 1000
            break
        }
        if (FindText(&X, &Y, x5, y5, x6, y6, 0.3, 0.3, fish_spawn)) {
            Send "{Space}"
            SoundPlay "voice\cant_hooked.mp3"
            break
        }

        if (A_TimeIdle < 100) {  ; 检测到用户输入
            lastInputTime := A_TickCount
        }

        if (A_TickCount - lastInputTime >= timeLimit) {
            SoundPlay "voice\cant_hooked.mp3"
            return
        }

        Sleep 100
    }
}

Fishing(useMirageKeys := false) {
    global activeFunction
    static fish_died_status := false
    last_key123_time := 0

    while (activeFunction == "fishing_default" || activeFunction == "fishing_mirage") {
        current_time := A_TickCount

        if (FindText(&X, &Y, x3, y3, x4, y4, 0, 0, fish_died)) {
            SoundPlay "voice\an_enemy_has_been_slayed.mp3"
            Sleep 3000
            break
        }

        if (FindText(&X, &Y, x1, y1, x2, y2, 0.2, 0.2, key5)) {
            Send(useMirageKeys ? mirage_fishing_key5 : default_fishing_key5)
            Sleep 4650
            continue
        }
        if (FindText(&X, &Y, x1, y1, x2, y2, 0.2, 0.2, key4)) {
            Send(useMirageKeys ? mirage_fishing_key4 : default_fishing_key4)
            Sleep 2325
            continue
        }

        if (current_time - last_key123_time > 4968) {
            if (FindText(&X, &Y, x1, y1, x2, y2, 0.2, 0.2, key3)) {
                Send(useMirageKeys ? mirage_fishing_key3 : default_fishing_key3)
                Sleep 400
                Send "{Space}"
                last_key123_time := current_time
                continue
            } else if (FindText(&X, &Y, x1, y1, x2, y2, 0.2, 0.2, key2)) {
                Send(useMirageKeys ? mirage_fishing_key2 : default_fishing_key2)
                Sleep 400
                Send "{Space}"
                last_key123_time := current_time
                continue
            } else if (FindText(&X, &Y, x1, y1, x2, y2, 0.2, 0.2, key1)) {
                Send(useMirageKeys ? mirage_fishing_key1 : default_fishing_key1)
                Sleep 400
                Send "{Space}"
                last_key123_time := current_time
                continue
            }
        }

        Sleep 100
    }
}
