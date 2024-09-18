#Requires AutoHotkey v2.0

#Include <FindText>
#Include <variables>

; 热键: 按下`键来切换脚本的启动和停止
`:: ToggleScript()

; 切换脚本状态的函数
ToggleScript() {
    global isRunning

    if (isRunning) {
        ; 如果脚本正在运行，停止它
        isRunning := false
        SetTimer(Trigger, 0)
        ToolTip("脚本已停止")
        SetTimer(() => ToolTip(), -2000)  ; 2秒后隐藏ToolTip
    } else {
        ; 如果脚本没有运行，启动它
        isRunning := true
        SetTimer(Trigger, 1000) ;设置一个trigger,每1秒执行一次
        ToolTip("脚本已启动")
        SetTimer(() => ToolTip(), -2000)  ; 2秒后隐藏ToolTip
    }
}

Trigger() {
    if (!isRunning) {
        return
    }
    if (FindText(&X, &Y, x3, y3, x4, y4, 0.1, 0.1, fish_spawn)) {
        Fishing()
    } else {
        Searching()
    }
}

checkKeyAction(key, sendKey, sleepTime, isJump) {
    if (!isRunning) {
        return false
    }
    local capture := FindText(&X, &Y, x1, y1, x2, y2, 0.3, 0.3, key)
    if (capture) {
        Send sendKey
        Sleep sleepTime
        if (isJump) {
            Sleep 500
            Send "{Space}"
        }
        return true
    }
    return false
}

Searching() {
    ; 检查是否应该继续运行
    if (!isRunning) {
        return
    }
    ; 在这里添加搜索逻辑
}

Fishing() {
    static fish_died_status := false
    fish_died_status := false  ; 重置状态

    while (isRunning) {
        ; 检查鱼是否死亡
        capture_fish_died := FindText(&X, &Y, x3, y3, x4, y4, 0.1, 0.1, fish_died)
        if (capture_fish_died && !fish_died_status) {
            SoundPlay "voice\an_enemy_has_been_slayed.mp3"
            fish_died_status := true
            break
        }

        ; 各种钓鱼动作
        if (checkKeyAction(key5, "{Numpad8}", 4000, false)) {
            ToolTip("Key5 action triggered")
            SetTimer () => ToolTip(), -1000
        }
        if (checkKeyAction(key4, "{Numpad7}", 4000, false)) {
            ToolTip("Key4 action triggered")
            SetTimer () => ToolTip(), -1000
        }
        if (checkKeyAction(key3, "{Numpad5}", 2000, true)) {
            ToolTip("Key3 action triggered")
            SetTimer () => ToolTip(), -1000
        }
        if (checkKeyAction(key2, "{Numpad6}", 2000, true)) {
            ToolTip("Key2 action triggered")
            SetTimer () => ToolTip(), -1000
        }
        if (checkKeyAction(key1, "4", 2000, true)) {
            ToolTip("Key1 action triggered")
            SetTimer () => ToolTip(), -1000
        }

        Sleep 100  ; 添加短暂延迟，避免过度消耗 CPU
    }
}
