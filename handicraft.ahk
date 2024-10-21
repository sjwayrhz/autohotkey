#Requires AutoHotkey v2.0

; 全局变量来跟踪脚本状态
global isRunning := false

; 热键设置：按下 Esc 键退出
Esc:: ExitApp
; 热键设置：按下 ` 键切换脚本的运行状态
~MButton:: ToggleScript()

ToggleScript() {
    global isRunning
    isRunning := !isRunning
    if (isRunning) {
        ToolTip("脚本已启动")
        SetTimer(PerformClicks, 10)  ; 开始循环
    } else {
        ToolTip("脚本已停止")
        SetTimer(PerformClicks, 0)  ; 停止循环
    }
    SetTimer(() => ToolTip(), -2000)  ; 2秒后移除提示
}

PerformClicks() {
    if (!isRunning) {
        return  ; 如果脚本不在运行状态，立即退出函数
    }

    ; 第一组点击
    MouseMove(804, 573)
    Click
    Sleep 500
    Click
    Sleep(1000)
    MouseMove(1229, 795)
    Click
    Sleep 500
    Click
    Sleep(9000)

    ; 第二组点击
    MouseMove(804, 547)
    Click
    Sleep 500
    Click
    Sleep(1000)
    MouseMove(1229, 795)
    Click
    Sleep 500
    Click
    Sleep(9000)

    ; 检查是否应该继续运行
    if (isRunning) {
        SetTimer(PerformClicks, -10)  ; 如果仍在运行，则安排下一次执行
    }
}
