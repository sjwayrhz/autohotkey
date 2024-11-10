#Requires AutoHotkey v2.0

#Include <FindText>
; 全局变量来跟踪脚本状态
global isRunning := false

; 热键: 按下~键来切换脚本的启动和停止
`:: ToggleScript()

; 切换脚本状态的函数
ToggleScript() {
    global isRunning

    if (isRunning) {
        ; 如果脚本正在运行，停止它
        SetTimer(Trigger, 0)
        isRunning := false
        ToolTip("脚本已停止")
        SetTimer(() => ToolTip(), -2000)  ; 2秒后隐藏ToolTip
    } else {
        ; 如果脚本没有运行，启动它
        SetTimer(Trigger, 5000)  ; 每1000毫秒（1秒）执行一次
        isRunning := true
        ToolTip("脚本已启动")
        SetTimer(() => ToolTip(), -2000)  ; 2秒后隐藏ToolTip
    }
}

Text :=
    "|<>*188$58.zzzzzzzzzzzzzzzzzzzznz0UtzxyTzbwmPbzm0700H9iS1bbzzz0aU/bk3tyQmPYi3NDntn9iGtg0zDD0at/aoHwwwmPYiPUztbmNimtgYzaTBUn/aaNznw2TAU1zy00HVt6sE0Tzzzzzzzzzzzzzzzzzzy"

; 触发的函数
Trigger() {
    if (ok := FindText(&X := 'wait', &Y := 3, 0, 0, 0, 0, 0.1, 0.1, Text)) {
        Sleep 2000
        FindText().Click(X, Y, "L")
        SoundPlay "voice\an_enemy_has_been_slayed.mp3"
    }
}
