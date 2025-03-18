#Requires AutoHotkey v2.0

; 全局变量来跟踪脚本状态
global isRunning := false
global currentKey := ""  ; 不设置默认值
global isSpecialA := false  ; 用于标记是否使用特殊的A功能

; 热键: 按下Ctrl+A时设置特殊的A功能序列
^A:: {
    global currentKey := "a"
    global isSpecialA := true
    ToolTip("已设置为A特殊功能序列")
    SetTimer(() => ToolTip(), -2000)  ; 2秒后隐藏ToolTip
}

; 热键: 按下Ctrl+F时设置计时器发送f
^F:: {
    global currentKey := "f"
    global isSpecialA := false
    ToolTip("计时器按键已切换为: f")
    SetTimer(() => ToolTip(), -2000)  ; 2秒后隐藏ToolTip
}

; 热键: 按下Ctrl+G时设置计时器发送g
^G:: {
    global currentKey := "g"
    global isSpecialA := false
    ToolTip("计时器按键已切换为: g")
    SetTimer(() => ToolTip(), -2000)  ; 2秒后隐藏ToolTip
}

; 热键: 按下Ctrl+H时设置计时器发送h
^H:: {
    global currentKey := "h"
    global isSpecialA := false
    ToolTip("计时器按键已切换为: h")
    SetTimer(() => ToolTip(), -2000)  ; 2秒后隐藏ToolTip
}

; 热键: 按下重音符号键(`)来切换脚本的启动和停止
`:: ToggleScript()

; 热键: 当按下Esc键时，退出脚本
Esc:: ExitApp

; 切换脚本状态的函数
ToggleScript() {
    global isRunning, currentKey, isSpecialA

    if (currentKey = "") {
        ToolTip("请先选择要发送的按键(Ctrl+A/F/G/H)")
        SetTimer(() => ToolTip(), -2000)
        return
    }

    if (isRunning) {
        ; 如果脚本正在运行，停止它
        if (isSpecialA)
            SetTimer(SpecialASequence, 0)
        else
            SetTimer(TimerTrigger, 0)
        isRunning := false
        ToolTip("计时器已停止")
        SetTimer(() => ToolTip(), -2000)  ; 2秒后隐藏ToolTip
    } else {
        ; 如果脚本没有运行，启动它
        if (isSpecialA) {
            SetTimer(SpecialASequence, 3000)  ; 每3秒执行一次完整序列（考虑到序列内部有延迟）
            ToolTip("特殊A序列已启动")
        } else {
            SetTimer(TimerTrigger, 1000)  ; 每1000毫秒（1秒）执行一次
            ToolTip("计时器已启动")
        }
        isRunning := true
        SetTimer(() => ToolTip(), -2000)  ; 2秒后隐藏ToolTip
    }
}

; 计时器触发的函数 - 用于普通按键
TimerTrigger() {
    global currentKey
    Send(currentKey)
}

; 添加一个全局计数器变量
global sequenceCounter := 0

; 特殊A序列函数 - 执行复杂的自动化序列
SpecialASequence() {
    global sequenceCounter
    
    ; 增加计数器
    sequenceCounter++
    
    ; 1. 按下3键
    Send("3")
    Sleep(500)  ; 休息0.5秒
    
    ; 2. 按下a键
    Send("a")
    Sleep(500)  ; 休息0.5秒
    
    ; 3. 鼠标移动到(1366,1040)
    MouseMove(1366, 1040)
    Sleep(500)  ; 移动后休息0.5秒再点击
    MouseClick("left", , , 2)  ; 执行双击，第三个参数是点击次数
    
    ; 4. 再次按下a键
    Send("a")
    Sleep(500)  ; 休息0.5秒
    
    ; 5. 鼠标移动到(1239,760)
    MouseMove(1239, 760)
    Sleep(500)  ; 移动后休息0.5秒再点击
    MouseClick("left")
    
    ; 只有在偶数次运行时才等待5秒
    if (Mod(sequenceCounter, 2) = 0) {
        Sleep(5000)  ; 休息5秒
    }
}

; 直接触发按键的函数
Trigger(key) {
    Send(key)
}