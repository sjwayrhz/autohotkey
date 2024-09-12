#Requires AutoHotkey v2.0

; 全局变量来跟踪脚本状态
global isRunning := false

; 热键: 按下~键来切换脚本的启动和停止
`:: ToggleScript()

; 热键: 当按下Esc键时，退出脚本
Esc:: ExitApp

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
        SetTimer(Trigger, 1000)  ; 每1000毫秒（1秒）执行一次
        isRunning := true
        ToolTip("脚本已启动")
        SetTimer(() => ToolTip(), -2000)  ; 2秒后隐藏ToolTip
    }
}

; 触发的函数
Trigger() {
    Send("r")
}
