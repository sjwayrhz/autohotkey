#Requires AutoHotkey v2.0
#Include <FindText>
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

clipper :=
    "|<>*124$37.zzzzTzzzzzTzz7zwzzz3zcTzz3zWTzzUTbTznUM7zzXs0TzzXw0DzzXzxXzs7zzlrs3zzwUs3zzy0QCzzz0K7zzzU27zzzU0Dzzzk0Dzzzw0DzzzwA7zzzz17zzzzrbzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"

fish_finder :=
    "|<>*133$39.yC3XC001XQ8k00Ntk0047Ti000Vnks007y03000z00S007k00k00w000007k00000D000006400000s000007w00000z800006800000Vq000077vU000zzk0007zzA200zzzzk0Lzzzzz6zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzU"

; 触发的函数
Trigger() {
    static lastActionTime := 0
    currentTime := A_TickCount

    ; 检查是否已经过了至少1秒
    if (currentTime - lastActionTime < 1000) {
        return
    }

    X := Y := 0
    if (FindText(&X, &Y, 0, 0, A_ScreenWidth, A_ScreenHeight, 0, 0, clipper)
        || FindText(&X, &Y, 0, 0, A_ScreenWidth, A_ScreenHeight, 0, 0, fish_finder)) {
        Send "{Numpad6}"
        lastActionTime := currentTime
    }
}
