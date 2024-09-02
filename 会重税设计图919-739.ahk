#Include <FindText>


Text:="|<>*106$24.zz00zz00zz00zxU0zlU0zVU0z300z300y400y0HUy0vUw3t0s3wEsXzklrTknzSkrzy0zzw1zzzlzzzlzzzzzzzzzyTzzwDzzsDzU"

`::{
	loop {
		ok:=FindText(&X:="wait0", &Y:=-1, 0,0,0,0,0,0,Text)  ; 无限等待等图像消失
		if (ok){
			Send "z"
			break
		}
	}
}


MButton:: {
	Click("left", 2)
	Sleep(10)
	MouseMove(919,739) 
	Loop 50 {
		Click
		Sleep(10)
	}
}
