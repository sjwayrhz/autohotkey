#Include <FindText>
#Include <scarecrow_variables_huawei>

; Global variables to track script state
global isRunning := false
global isHotkeyActive := false
global taxMode := "heavy"  ; "heavy" for 会重税, "free" for 免重税

ClickAndMoveMouse(targetX, targetY) {
    global isRunning
    Sleep 1000
    MouseMove(targetX, targetY)
    SoundPlay "voice\confirm_no_mouse_keyboard.mp3"
    if (FindText(&X := "wait0", &Y := -1, x1, y1, x2, y2, 0.1, 0.1, black)) {
        loop 50 {
            Click
            Sleep(10)
        }
    }
    isRunning := false
}

; Switch to heavy tax mode
^1:: {
    global taxMode
    taxMode := "heavy"
    ToolTip("已切换到会重税模式")
    SetTimer () => ToolTip(), -2000
}

; Switch to tax-free mode
^2:: {
    global taxMode
    taxMode := "free"
    ToolTip("已切换到免重税模式")
    SetTimer () => ToolTip(), -2000
}

; Toggle hotkey active state
`:: {
    global isHotkeyActive, taxMode
    isHotkeyActive := !isHotkeyActive
    if (isHotkeyActive) {
        ToolTip(taxMode = "heavy" ? "会重税-已启用" : "免重税-已启用")
        SoundPlay "voice\monitor_scarecrow_bar.mp3"
    } else {
        ToolTip(taxMode = "heavy" ? "会重税-已禁用" : "免重税-已禁用")
    }
    SetTimer () => ToolTip(), -2000
}

~LButton:: {
    global isRunning, isHotkeyActive, taxMode
    if (isHotkeyActive && !isRunning) {
        isRunning := true
        ToolTip("抢地脚本-" . (taxMode = "heavy" ? "会重税" : "免重税") . "-开启")
        SetTimer () => ToolTip(), -2000
        ; 等待稻草人的黑色空血条消失的瞬间插地
        if (taxMode = "heavy")
            ClickAndMoveMouse(919, 769)  ; 重税坐标
        else
            ClickAndMoveMouse(919, 697)  ; 免税坐标
    }
}