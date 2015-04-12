/*  
• include Gdip.ahk library from http://www.autohotkey.com/board/topic/29449-gdi-standard-library-145-by-tic/
• To capture a screenshot drag mouse while holding right shift key
• Each screenshot opens its own window from which it can be saved
• Windows + G - take a screenshot from a window (enter window name in the input box)
• Escape - exit
*/

#SingleInstance force
SoundPlay *48
Menu, Tray, Icon, pnidui.dll, 12  


;Work_Dir  := "C:\a\"
Work_Dir = %temp%
SetWorkingDir, %Work_Dir%   
	IfNotExist Screenshots 
	FileCreateDir, Screenshots

folder_path := A_WorkingDir . "\Screenshots\"
index :=2




OnMessage(0x14, "WM_ERASEBKGND")
Gui, -Caption +ToolWindow
Gui, +LastFound
WinSet, TransColor, Black
; Create the pen here so we don't need to create/delete it every time.
RedPen := DllCall("CreatePen", "int", PS_SOLID:=0, "int", 5, "uint", 0xff)
return






RShift & LButton::
	CoordMode, Mouse, Screen
    MouseGetPos, begin_x, begin_y
	MouseGetPos, xorigin, yorigin
    SetTimer, rectangle, 10
    KeyWait, LButton
	SetTimer, rectangle, Off
    Gui, Cancel
    MouseGetPos, end_x, end_y

	if (end_x > begin_x AND end_y > begin_y){
	;file%index% := folder_path "screenshot x" begin_x ",y" begin_y " width"  Abs(end_x-begin_x) ", height" Abs(end_y-begin_y) ".png"
	;screen := begin_x . "|" . begin_y . "|" . Abs(end_x-begin_x) . "|" Abs(end_y-begin_y) ;  X|Y|W|H		
	Capture_x:=begin_x
	Capture_y:=begin_y
	}else  if (end_x < begin_x AND end_y < begin_y){
	Capture_x:=end_x
	Capture_y:=end_y
	}else  if (end_x < begin_x AND end_y > begin_y){
	Capture_x:=end_x
	Capture_y:=begin_y
	}else  if (end_x > begin_x AND end_y < begin_y){
	Capture_x:=begin_x
	Capture_y:=end_y
	}
	
	
	Capture_width:=Abs(end_x-begin_x)
	Capture_height:= Abs(end_y-begin_y)


	screen := Capture_x . "|" . Capture_y . "|" . Capture_width . "|" Capture_height  ;  X|Y|W|H	
	
	;file%index% := folder_path "screenshot x" Capture_x ",y" Capture_y " width"  Capture_width ", height" Capture_height ".png"	
	file%index% := folder_path  "screenshot " A_Now_Format(A_Now)  ", width" Capture_width " height" Capture_height  ".png"

	x:=file%index%
	Screenshot(x,screen)
	sleep 1000
	Gosub, makeGUI
return


 
rectangle:
	CoordMode, Mouse, Screen
    MouseGetPos, x2, y2
    
    ; Has the mouse moved?
    if (x1 y1) = (x2 y2)
        return
    
    ; Allow dragging to the left of the click point.
    if (x2 < xorigin) {
        x1 := x2
        x2 := xorigin
    } else
        x1 := xorigin
    
    ; Allow dragging above the click point.
    if (y2 < yorigin) {
        y1 := y2
        y2 := yorigin
    } else
        y1 := yorigin
    
    Gui, Show, % "NA X" x1 " Y" y1 " W" x2-x1 " H" y2-y1
    Gui, +LastFound
    DllCall("RedrawWindow", "uint", WinExist(), "uint", 0, "uint", 0, "uint", 5)
return
 



makeGUI:
;Gui,%index% : +LastFound +Resize  +Minsize400x330 ; +AlwaysOnTop 
Gui,%index%: Color, 6B8590
Gui,%index%: Margin,0,0
Gui,%index%: Add, Picture, x10 y4 w16 h16 gSave Icon259 AltSubmit, shell32.dll ;

file_GUI:= file%index%
;MsgBox, , , % "makeGUI: " index " - " file1
Gui,%index%: Add, Picture, x0 y24  ,  %file_GUI%
Gui,%index%: Show,, Screenshots - Drozd
index+=1
return

 
 
Save:
;File_num:= "C:\a\My File" A_Gui ".png"
File_num:= file%A_Gui% 
FileSelectFile, FileName , S, %File_num% , Save As, Image Files (*.png)  ;C:\a\My File.png
file:=file%A_Gui% 
FileCopy, %file%, %FileName%
return


#g:: Gosub, FromWindow

FromWindow:
InputBox, window , Window Title, Enter Window Title, , 300, 100,,,,,ahk_class OperaWindowClass

dat:= A_Now_Format(A_Now)
;file := folder_path  "screenshot ”" window "” " A_Now_Format(A_Now) ".png"
file%index%:= folder_path  "screenshot ”" window "” " A_Now_Format(A_Now) ".png"
ID:= WinExist(window)
y:=file%index%
ClipFromWindow(y,ID)
Gosub, makeGUI
index+=1
return


ClipFromWindow(outfile, ID) {
	pToken := Gdip_Startup()
	pBitmap:=Gdip_BitmapFromHWND(ID)
	Gdip_SaveBitmapToFile(pBitmap, outfile, 100)
	
	
	Gdip_DisposeImage(pBitmap)
	Gdip_Shutdown(pToken)
}


Screenshot(outfile, screen) {
	pToken := Gdip_Startup()
	raster := 0x40000000 + 0x00CC0020

	pBitmap := Gdip_BitmapFromScreen(screen,raster)

	Gdip_SaveBitmapToFile(pBitmap, outfile, 100)
	Gdip_DisposeImage(pBitmap)
	Gdip_Shutdown(pToken)
}



A_Now_Format(raw){
   RegExMatch(raw,"^(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})", d)
   date:=d1 "-" d2 "-" d3  " " d4 "-" d5 "-" d6
   return date
}

WM_ERASEBKGND(wParam, lParam)
{
    global x1, y1, x2, y2, RedPen
    Critical 50
    if A_Gui = 1
    {
        ; Retrieve stock brush.
        blackBrush := DllCall("GetStockObject", "int", BLACK_BRUSH:=0x4)
        ; Select pen and brush.
        oldPen := DllCall("SelectObject", "uint", wParam, "uint", RedPen)
        oldBrush := DllCall("SelectObject", "uint", wParam, "uint", blackBrush)
        ; Draw rectangle.
        DllCall("Rectangle", "uint", wParam, "int", 0, "int", 0, "int", x2-x1, "int", y2-y1)
        ; Reselect original pen and brush (recommended by MS).
        DllCall("SelectObject", "uint", wParam, "uint", oldPen)
        DllCall("SelectObject", "uint", wParam, "uint", oldBrush)
        return 1
    }
}




#Include Gdip.ahk


Esc::
FileDelete,  %folder_path%*.png
;FileRecycle,  %folder_path%*.png
;FileRemoveDir,%folder_path%, 1
ExitApp
return




