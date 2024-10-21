#Include <FindText>
#Include <scarecrow_variables>

; Global variables to track script state
global isRunning := false
global isAutoClickEnabled := false  ; Changed to false by default

ClickAndMoveMouse(targetX, targetY) {
    global isRunning, isAutoClickEnabled
    if (FindText(&X, &Y, x1, y1, x2, y2, 0.2, 0.2, buff_removal_deuff)) {
        Sleep 25
        if (FindText(&X := "wait0", &Y := -1, x1, y1, x2, y2, 0.2, 0.2, buff_removal_deuff)) {
            ToolTip("开始倒计时")
            SetTimer(() => ToolTip(), -2000)
            SoundPlay "voice\countdown.mp3"
            Sleep 19966
            Click("left", 2)
            MouseMove(targetX, targetY)
            loop 50 {
                Click
                Sleep(10)
            }
        }
        ; 执行完一次后禁用自动点击
        isAutoClickEnabled := false
        ToolTip("抢地脚本-已自动禁用")
        SetTimer(() => ToolTip(), -2000)
    }
    isRunning := false
}

; 重税需要ClickAndMoveMouse(919, 739)
; 免税需要ClickAndMoveMouse(919, 669)
MButton:: {
    global isRunning, isAutoClickEnabled
    if (isRunning) {
        ; If script is running, stop it
        isRunning := false
        isAutoClickEnabled := false
        SetTimer(auto_click, 0)  ; Stop the auto_click timer
        ToolTip("抢地脚本-已停止")
    } else {
        ; If script is not running, start it
        isRunning := true
        isAutoClickEnabled := true
        ToolTip("抢地脚本-免重税-开启")
        SetTimer(auto_click, 25)
    }
    SetTimer(() => ToolTip(), -2000)
}

auto_click() {
    global isAutoClickEnabled
    if (isAutoClickEnabled) {
        ClickAndMoveMouse(919, 739)
    } else {
        SetTimer(auto_click, 0)  ; 停止 auto_click 计时器
    }
}
