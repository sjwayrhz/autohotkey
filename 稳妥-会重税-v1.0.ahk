#Include <FindText>
#Include <scarecrow_variables>

; Global variables to track script state
global isRunning := false
global isHotkeyActive := false

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

; Toggle hotkey active state
`:: {
    global isHotkeyActive
    isHotkeyActive := !isHotkeyActive
    if (isHotkeyActive) {
        ToolTip("会重税-已启用")
        SoundPlay "voice\monitor_scarecrow_bar.mp3"
    } else {
        ToolTip("会重税-已禁用")
    }
    SetTimer(() => ToolTip(), -2000)
}

; 重税需要ClickAndMoveMouse(919, 769)
; 免税需要ClickAndMoveMouse(919, 697)
~LButton:: {
    global isRunning, isHotkeyActive
    if (isHotkeyActive && !isRunning) {
        isRunning := true
        ToolTip("抢地脚本-会重税-开启")
        SetTimer(() => ToolTip(), -2000)
        ; 等待稻草人的黑色空血条消失的瞬间插地
        ClickAndMoveMouse(919, 769)
    }
}
