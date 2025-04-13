#Include <FindText>
#Include <scarecrow_variables_2k>

; Global variables to track script state
global isRunning := false
global isHotkeyActive := false

ClickAndMoveMouse() {
    global isRunning
    Sleep 1000
    SoundPlay "voice\confirm_no_mouse_keyboard.mp3"

    ; 检测black血条是否消失
    if (!FindText(&X := "", &Y := "", x1, y1, x2, y2, 0, 0, black)) {
        ; 血条消失了，立即鼠标左键双击（在当前位置）
        Click 2  ; 使用单行代码执行双击
        Sleep 1000
        ; 寻找cancel按钮
        if (FindText(&X := "", &Y := "", 0, 0, A_ScreenWidth, A_ScreenHeight, 0, 0, cancel)) {
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
        ToolTip("混合-已启用")
        SoundPlay "voice\monitor_scarecrow_bar.mp3"
    } else {
        ToolTip("混合-已禁用")
    }
    SetTimer(() => ToolTip(), -2000)
}

~LButton:: {
    global isRunning, isHotkeyActive
    if (isHotkeyActive && !isRunning) {
        isRunning := true
        ToolTip("抢地脚本-混合-开启")
        SetTimer(() => ToolTip(), -2000)
        ; 等待稻草人的黑色空血条消失的瞬间插地
        ClickAndMoveMouse()
    }
}
