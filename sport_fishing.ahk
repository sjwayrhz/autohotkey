#Requires AutoHotkey v2.0

#Include <FindText>
#Include <variables>

; 热键: 按下ctrl+1键来切换脚本的启动和停止
^1:: ToggleFishing()

; 热键: 按下ctrl+2键来执行船舶自动加速
^2:: ToggleShipAutoRun()

; 全局变量
global activeFunction := "none"  ; 可能的值: "none", "fishing", "shipautorun"

; 切换钓鱼脚本状态的函数
ToggleFishing() {
    global activeFunction
    if (activeFunction == "fishing") {
        StopActiveFunction()
    } else {
        StopActiveFunction()
        activeFunction := "fishing"
        SetTimer(FishingTrigger, 1000)
        ToolTip("钓鱼脚本已启动")
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
    ToolTip("所有功能已停止")
    SetTimer(() => ToolTip(), -2000)
}

; 钓鱼功能的触发器
FishingTrigger() {
    global activeFunction
    if (activeFunction != "fishing") {
        return
    }
    if (FindText(&X, &Y, x3, y3, x4, y4, 0.1, 0.1, fish_spawn)) {
        Fishing()
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
        || FindText(&X, &Y, 0, 0, A_ScreenWidth, A_ScreenHeight, 0, 0, fish_finder)) {
        Send "{Numpad6}"
        lastActionTime := currentTime
    }
}

Searching() {
    global activeFunction
    if (activeFunction != "fishing") {
        return
    }
    loop {
        if (FindText(&X, &Y, x3, y3, x4, y4, 0.1, 0.1, fish_spawn)) {
            SoundPlay "voice\already_hooked.mp3"
            break
        }
        Sleep 1000
    }
}

Fishing() {
    global activeFunction
    static fish_died_status := false
    ;fish_died_status := false  ; 重置状态
    last_key123_time := 0  ; 记录最后一次按下 key1, key2, 或 key3 的时间

    while (activeFunction == "fishing") {
        current_time := A_TickCount

        ; 同时检测 key4 和 key5
        if (FindText(&X, &Y, x1, y1, x2, y2, 0.3, 0.3, key4) || FindText(&X, &Y, x1, y1, x2, y2, 0.2, 0.2, key5)) {
            if (FindText(&X, &Y, x1, y1, x2, y2, 0.2, 0.2, key5)) {
                Send "{Numpad8}"
                Sleep 4000
            }
            if (FindText(&X, &Y, x1, y1, x2, y2, 0.3, 0.3, key4)) {
                Send "{Numpad7}"
                Sleep 2000
            }
            ; 检查鱼是否死亡
            if (FindText(&X, &Y, x3, y3, x4, y4, 0.1, 0.1, fish_died)) {
                SoundPlay "voice\an_enemy_has_been_slayed.mp3"
                break
            }
            continue
        }

        ; 处理 key1, key2, 和 key3
        if (current_time - last_key123_time > 3800) {
            if (FindText(&X, &Y, x1, y1, x2, y2, 0.2, 0.2, key3)) {
                Send "{Numpad5}"
                Sleep 600
                Send "{Space}"
                last_key123_time := current_time
                continue
            } else if (FindText(&X, &Y, x1, y1, x2, y2, 0.2, 0.2, key2)) {
                Send "{Numpad6}"
                Sleep 600
                Send "{Space}"
                last_key123_time := current_time
                continue
            } else if (FindText(&X, &Y, x1, y1, x2, y2, 0.2, 0.2, key1)) {
                Send "{Numpad4}"
                Sleep 600
                Send "{Space}"
                last_key123_time := current_time
                continue
            }
        }

        Sleep 100  ; 添加短暂延迟，避免过度消耗 CPU
    }
}
