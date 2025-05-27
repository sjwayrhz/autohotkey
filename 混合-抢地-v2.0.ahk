#Include <FindText>
#Include <scarecrow_2k>

; Global variables to track script state
global isRunning := false
global isHotkeyActive := false
global fireCheckTimer := 0

ClickAndMoveMouse(targetX, targetY) {
    global isRunning
    Sleep 1000
    MouseMove(targetX, targetY)
    SoundPlay "voice\confirm_no_mouse_keyboard.mp3"
    if (FindText(&X := "wait0", &Y := -1, x1, y1, x2, y2, 0, 0, black)) {
        Click 4
        if (FindText(&X := 'wait', &Y := 3, 0, 0, 0, 0, 0, 0, build)) {
            ; 使用FindText的方法移动到build并点击
            FindText().Click(X, Y, "L")
        }
        loop 10 {
            Click 2
            Sleep(5)
        }
    }
    isRunning := false
}

; Function to check for fire icon
CheckFireIcon() {
    global isHotkeyActive
    if (!isHotkeyActive) {
        if (FindText(&X := "wait", &Y := 1, x3, y3, x4, y4, 0.1, 0.1, fire)) {
            ; ToolTip("火焰图标已出现 请切换到抢地模式")
            SoundPlay "voice\fire_buff_on.mp3"  ; 可选：播放提示音
            ; SetTimer(() => ToolTip(""), -2000)
            ; 暂停检测10秒，避免重复提醒
            SetTimer(CheckFireIcon, 0)
            SetTimer(CheckFireIcon, 10000)
        }
    }
}

; Toggle hotkey active state
`:: {
    global isHotkeyActive, fireCheckTimer
    isHotkeyActive := !isHotkeyActive
    if (isHotkeyActive) {
        ToolTip("抢地-已启用")
        SoundPlay "voice\monitor_scarecrow_bar.mp3"
        ; 停止火焰图标检测定时器
        if (fireCheckTimer) {
            SetTimer(CheckFireIcon, 0)
            fireCheckTimer := 0
        }
    } else {
        ToolTip("抢地-已禁用-探测火焰图标")
        ; 启动火焰图标检测定时器，每1秒检测一次
        SetTimer(CheckFireIcon, 1000)
        fireCheckTimer := 1
    }
    SetTimer(() => ToolTip(), -2000)
}

~LButton:: {
    global isRunning, isHotkeyActive
    if (isHotkeyActive && !isRunning) {
        isRunning := true
        ToolTip("抢地脚本-抢地-开启")
        SetTimer(() => ToolTip(), -2000)
        ; 等待稻草人的黑色空血条消失的瞬间插地
        ClickAndMoveMouse(1024, 852)
    }
}
