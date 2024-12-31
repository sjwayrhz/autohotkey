#Include <FindText>
#Include <scarecrow_variables_huawei>

; Global variables to track script state
global isRunning := false
global isHotkeyActive := false
global taxMode := "heavy"  ; "heavy" for ����˰, "free" for ����˰

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

; Switch to heavy tax mode
^1:: {
    global taxMode
    taxMode := "heavy"
    ToolTip("���л�������˰ģʽ")
    SetTimer () => ToolTip(), -2000
}

; Switch to tax-free mode
^2:: {
    global taxMode
    taxMode := "free"
    ToolTip("���л�������˰ģʽ")
    SetTimer () => ToolTip(), -2000
}

; Toggle hotkey active state
`:: {
    global isHotkeyActive, taxMode
    isHotkeyActive := !isHotkeyActive
    if (isHotkeyActive) {
        ToolTip(taxMode = "heavy" ? "����˰-������" : "����˰-������")
        SoundPlay "voice\monitor_scarecrow_bar.mp3"
    } else {
        ToolTip(taxMode = "heavy" ? "����˰-�ѽ���" : "����˰-�ѽ���")
    }
    SetTimer () => ToolTip(), -2000
}

~LButton:: {
    global isRunning, isHotkeyActive, taxMode
    if (isHotkeyActive && !isRunning) {
        isRunning := true
        ToolTip("���ؽű�-" . (taxMode = "heavy" ? "����˰" : "����˰") . "-����")
        SetTimer () => ToolTip(), -2000
        ; �ȴ������˵ĺ�ɫ��Ѫ����ʧ��˲����
        if (taxMode = "heavy")
            ClickAndMoveMouse(919, 769)  ; ��˰����
        else
            ClickAndMoveMouse(919, 697)  ; ��˰����
    }
}