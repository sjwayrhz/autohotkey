#Requires AutoHotkey v2.0

; 初始化全局变量
global isRunning := false
global currentMode := 0  ; 0 = none, 1 = mode1, 2 = mode2, 3 = mode3

; Toggle script on/off with backtick
`::
{
    global isRunning, currentMode
    isRunning := !isRunning
    if (!isRunning) {
        StopActiveTimer()
    } else if (currentMode > 0) {
        ; 如果有活动的模式，重新启动它
        StartTimer(currentMode)
    }
    UpdateToolTip()
}

; Mode 1: Spam key 0
^1::
{
    global isRunning, currentMode
    if (currentMode == 1) {
        return  ; 如果已经在模式1，不做任何事
    }
    StopActiveTimer()
    currentMode := 1
    if (isRunning) {
        StartTimer(1)
    }
    UpdateToolTip()
}

; Mode 2: Cycle F1-F8,F10,F11
^2::
{
    global isRunning, currentMode
    if (currentMode == 2) {
        return  ; 如果已经在模式2，不做任何事
    }
    StopActiveTimer()
    currentMode := 2
    if (isRunning) {
        StartTimer(2)
    }
    UpdateToolTip()
}

; Mode 3: Same as Mode 2
^3::
{
    global isRunning, currentMode
    if (currentMode == 3) {
        return  ; 如果已经在模式3，不做任何事
    }
    StopActiveTimer()
    currentMode := 3
    if (isRunning) {
        StartTimer(3)
    }
    UpdateToolTip()
}

; Function to update tooltip status
UpdateToolTip() {
    global isRunning, currentMode
    status := isRunning ? "Running" : "Paused"
    mode := "Mode: " . currentMode
    ToolTip("Status: " . status . "`n" . mode)
    SetTimer(() => ToolTip(), -1000)  ; Hide tooltip after 1 second
}

; Stop active timer
StopActiveTimer() {
    global currentMode
    if (currentMode == 1) {
        SetTimer(Mode1, 0)
    } else if (currentMode == 2) {
        SetTimer(Mode2, 0)
    } else if (currentMode == 3) {
        SetTimer(Mode3, 0)
    }
}

; Start timer for specific mode
StartTimer(mode) {
    StopActiveTimer()
    switch mode {
        case 1:
            SetTimer(Mode1, 10)
        case 2:
            SetTimer(Mode2, 10)
        case 3:
            SetTimer(Mode3, 10)
    }
}

; Mode 1 function - Spam 0
Mode1() {
    global isRunning, currentMode
    if (!isRunning || currentMode != 1) {
        StopActiveTimer()
        return
    }
    Send("{0}")
}

; Mode 2 function - Cycle F keys
Mode2() {
    static keyIndex := 1
    global isRunning, currentMode
    if (!isRunning || currentMode != 2) {
        StopActiveTimer()
        return
    }
    
    keys := ["F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F10", "F11"]
    Send("{" . keys[keyIndex] . "}")
    keyIndex := Mod(keyIndex, keys.Length) + 1
}

; Mode 3 function - Same as Mode 2
Mode3() {
    static keyIndex := 1
    global isRunning, currentMode
    if (!isRunning || currentMode != 3) {
        StopActiveTimer()
        return
    }
    
    keys := ["F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F10", "F11","f"]
    Send("{" . keys[keyIndex] . "}")
    keyIndex := Mod(keyIndex, keys.Length) + 1
}