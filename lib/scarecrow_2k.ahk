#Requires AutoHotkey v2.0

; FileInstall commands
DirCreate "voice"
FileInstall "voice\countdown.mp3", A_WorkingDir "\voice\countdown.mp3", 1
FileInstall "voice\monitor_scarecrow_bar.mp3", A_WorkingDir "\voice\monitor_scarecrow_bar.mp3", 1
FileInstall "voice\confirm_no_mouse_keyboard.mp3", A_WorkingDir "\voice\confirm_no_mouse_keyboard.mp3", 1
FileInstall "voice\fire_buff_on.mp3", A_WorkingDir "\voice\fire_buff_on.mp3", 1

; removal deuff
buff_removal_deuff := "|<>*121$20.zzlzzcTy07z02k09C0U1k02S003UE0k00A006200k108EU3MEEw84C61z3UzkwzwDzz7zzlzzszTyTXzzkTs"
; buff_untouchable
buff_untouchable :=
    "|<>*106$23.zw03zs07zk07zU0DxU0TX00y601sM03kk07200C0HUQ1r0kDY10TW28zw0vjs3zSkDzw0zzk5zzyDzzwTzzzzzzzzyTzzsTzzUzy"

; black表示稻草人被敲击后的黑色血条
black :=
    "|<>*50$87.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzU"
fire :=
    "|<>*120$27.zzz7zzyEzzy07zzU1Tw00Hzk40Dz009zw007z0E0zk007z101zsE07z040TkV03zME0Ty427zVUTzsQ7zz3nzzsTzzz7zzzszzzyDjzznszzzy3zzzUTzU"

; Global variables
; 房屋血条大致坐标
global x1 := 1126
global y1 := 28
global x2 := 1250
global y2 := 68

; 火焰buff大致坐标
global x3 := 1129
global y3 := 67
global x4 := 1162
global y4 := 101

build := "|<>*145$30.z00Y1VU0Y1Uk041Um4YRlW4YnzW4YVUm4ZVUG4ZVUG4YVlnAYnz1oYRU"
cancel := "|<>*145$44.DU00000KA0000071U00001U0yLXkwM0Ea9aMa0092E4BU0yEg3zM6MY90k71g92EY9Rl6EaNaFkC40Q76"