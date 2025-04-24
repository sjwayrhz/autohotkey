#Include <FindText>
#Include <scarecrow_variables_2k>

; Global variables to track script state
global isRunning := false
global isHotkeyActive := false

ClickAndMoveMouse(targetX, targetY) {
    global isRunning
    Sleep 1000
    MouseMove(targetX, targetY)
    SoundPlay "voice\confirm_no_mouse_keyboard.mp3"
    if (FindText(&X := "wait0", &Y := -1, x1, y1, x2, y2, 0.1, 0.1, black)) {
        Click 10
        if (FindText(&X := 'wait', &Y := 3, 0, 0, A_ScreenWidth, A_ScreenHeight, 0, 0, cancel)) {
            ; 使用FindText的方法移动到cancel并点击
            FindText().Click(X, Y, "L")
        }
        loop 25 {
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
        ToolTip("抢地-已启用")
        SoundPlay "voice\monitor_scarecrow_bar.mp3"
    } else {
        ToolTip("抢地-已禁用")
    }
    SetTimer(() => ToolTip(), -2000)
}

; 重税需要ClickAndMoveMouse(919, 769)
; 免税需要ClickAndMoveMouse(919, 697)
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
