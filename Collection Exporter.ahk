;Written by Jammo2k5
#SingleInstance, Force
#Persistent
#InstallKeybdHook
#UseHook, On
#Include FindClick.ahk
#Include Gdip.ahk
coordmode,mouse,client
OutputFile = %A_WorkingDir%/Collection.tmp
formulacounter = 1

Gui,show,w200 h340,Language Select
gui, Add, Text,, Please select your Game Language.
Gui, Add, Radio,w200 vLanguageselect, English (GB)
Gui, Add, Radio,w200 , English (US)
Gui, Add, Radio,w200 , German
Gui, Add, Radio,w200 , Spanish
Gui, Add, Radio,w200 , Spanish (Mexico)
Gui, Add, Radio,w200 , French
Gui, Add, Radio,w200 , Russian
Gui, Add, Radio,w200 , Italian
Gui, Add, Radio,w200 , Korean
Gui, Add, Radio,w200 , Polish
Gui, Add, Radio,w200 , Portuguese
Gui, Add, Radio,w200 , Portuguese (Brazil)
Gui, Add, Radio,w200 , Chinese
Gui, Add, Radio,w200 , Chinese (Tailand)
Gui, Add, Button,gStartsettings, Start
gui,add,button,gCloseApp y291 x50,Cancel
return

UserConfig_a = o100,TransBlack
^F9::
Reload
return

^F8::
pausedbot = 1
return
^F7::
pausedbot = 0
return

Startsettings:
filedelete,%OutputFile%
TitleText := "Card Name,Mana Cost,Type,Class,Set,Rarity,Normal,Golden`n"
Gui,submit
FileRead,CardListMain,%A_WorkingDir%/Cards info/AllSetsAllLanguages.json
cardinfo := parseJson(CardListMain)
cardoneabsent = 0
Process Exist,Hearthstone.exe
GamePID := ErrorLevel
WinGetPos,Lx,Ly,H,W,ahk_pid %GamePID%
winactivate,ahk_pid %GamePID%
;searchx := %Lx%+485
;searchy := %Ly%+697
GUI,2:show,W200 h190,Sets List
gui,2:add,text, x10 y10 w180,Please select the sets of cards you wish to scan.
gui,2:add,Checkbox,vBasicset w180,Basic
gui,2:add,Checkbox,vClassicset w180,Classic (Expert)
gui,2:add,Checkbox,vNaxxset w180,Naxxramas
gui,2:add,Checkbox,vGoblinsset w180,GVG
gui,2:add,Checkbox,vRewardset w180,Reward
gui,2:add,Checkbox,vPromoset w180,Promotion
gui,2:add,button,gStartExport x8 y157,Start
gui,2:add,button,gCloseApp y157 x50,Cancel
gui,2:add,button,gCalibrate y157 x110,Calibrate
return

CloseApp:
exitapp
return

GuiClose:
ExitApp

Calibrate:
Calibratefunc()
return

2GuiClose:
ExitApp

StartExport:
gui,2:submit
msgbox,IMPORTANT!`nThe exporter is about to export the collection, Please makesure you are on the collection screen with crafting mode off and the search box unselected. `n`n`nPlease keep your arms and legs inside the ride at all times (Do not move the mouse) and enjoy the show.
mainFunc()
return


Calibratefunc()
{
	global
	coordmode,mouse,client
	Languagefile()
	hwnd := WinExist("Hearthstone")
	winactivate,ahk_pid %GamePID%
	coordmode,mouse,client
	GetClientSize(hwnd, wgame, hgame) 
	searchboxx := hgame/1.098677517802645
	searchboxy := wgame/2
	;MsgBox Width = %wgame% Height = %hgame%
	wingetpos,HSlocx,HSlocy,HSwith,HSheight,Hearthstone
	HSbordersize := (HSwith-wgame)/2
	HStitlesize:= (HSheight-hgame)-(HSbordersize*2)
	HSclientposy:=HSlocy+HSbordersize+HStitlesize
	HSclientposx:=HSlocx+HSbordersize
	;;;;;;;;;;;;;;;;;;;;;;;; minion image 1 found 2 start
	msgbox,262144,Collection Exporter,Please find a page in your collection where there are 2-8 Minion cards in the 1st two slots of the page.`nThere must be no cards on the bottom row of the page.`nYou may use the search function to isolate cards to make it easier.`nClick ok when the cards are in place.
	;image 1 found 2 start
	imagexstart:= Round(HSclientposx+(wgame/2)-(hgame/1.821247892074199))
	imagexfinish:= Round(HSclientposx+(wgame/2)-(hgame/2.130177514792899))
	imageystart:= Round(HSclientposy+(hgame/2.080924855491329))
	imageyfinish:= Round(HSclientposy+(hgame/2.018691588785047))
	imageheight := imageyfinish-imageystart
	imagewith := imagexfinish-imagexstart
	imageloc := imagexstart . "|" . imageystart . "|" . imagewith . "|" . imageheight
	;msgbox, %imageloc%
	imagepath := A_workingdir . "\Images\card1found2Minion.png"
	Screenshot(imagepath,imageloc)
	;;;;;;;Minion Image 2 found 2 start ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	imagexstart:= Round(HSclientposx+(wgame/2)-(hgame/3.085714285714286))
	imagexfinish:= Round(HSclientposx+(wgame/2)-(hgame/4.044943820224719))
	imageystart:= Round(HSclientposy+(hgame/2.080924855491329))
	imageyfinish:= Round(HSclientposy+(hgame/2.018691588785047))
	imageheight := imageyfinish-imageystart
	imagewith := imagexfinish-imagexstart
	imageloc := imagexstart . "|" . imageystart . "|" . imagewith . "|" . imageheight
	;msgbox, %imageloc%
	imagepath := A_workingdir . "\Images\card2found2Minion.png"
	sleep 200
	winactivate,ahk_pid %GamePID%
	Screenshot(imagepath,imageloc)
	
	;;;;;;;;;;;;;;;;;;;;;;;; Spell image 1 found 2 start
	msgbox,262144,Collection Exporter,Please find a page in your collection where there are 2-8 Spell cards in the 1st two slots of the page.`nThere must be no cards on the bottom row of the page.`nYou may use the search function to isolate cards to make it easier.`nClick ok when the cards are in place.
	;image 1 found 2 start
	imagexstart:= Round(HSclientposx+(wgame/2)-(hgame/1.821247892074199))
	imagexfinish:= Round(HSclientposx+(wgame/2)-(hgame/2.130177514792899))
	imageystart:= Round(HSclientposy+(hgame/2.080924855491329))
	imageyfinish:= Round(HSclientposy+(hgame/2.018691588785047))
	imageheight := imageyfinish-imageystart
	imagewith := imagexfinish-imagexstart
	imageloc := imagexstart . "|" . imageystart . "|" . imagewith . "|" . imageheight
	;msgbox, %imageloc%
	imagepath := A_workingdir . "\Images\card1found2Spell.png"
	Screenshot(imagepath,imageloc)
	
	;;;;;;;spell Image 2 found 2 start ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	imagexstart:= Round(HSclientposx+(wgame/2)-(hgame/3.085714285714286))
	imagexfinish:= Round(HSclientposx+(wgame/2)-(hgame/4.044943820224719))
	imageystart:= Round(HSclientposy+(hgame/2.080924855491329))
	imageyfinish:= Round(HSclientposy+(hgame/2.018691588785047))
	imageheight := imageyfinish-imageystart
	imagewith := imagexfinish-imagexstart
	imageloc := imagexstart . "|" . imageystart . "|" . imagewith . "|" . imageheight
	;msgbox, %imageloc%
	imagepath := A_workingdir . "\Images\card2found2Spell.png"
	sleep 200
	winactivate,ahk_pid %GamePID%
	Screenshot(imagepath,imageloc)
	;;;;;;;;;;;;;;;;;;;;;;;; weapon image 1 found 2 start
	msgbox,262144,Collection Exporter,Please find a page in your collection where there are 2-8 Weapon cards in the 1st two slots of the page.`nThere must be no cards on the bottom row of the page.`nYou may use the search function to isolate cards to make it easier.`nClick ok when the cards are in place.
	;image 1 found 2 start
	imagexstart:= Round(HSclientposx+(wgame/2)-(hgame/1.821247892074199))
	imagexfinish:= Round(HSclientposx+(wgame/2)-(hgame/2.130177514792899))
	imageystart:= Round(HSclientposy+(hgame/2.080924855491329))
	imageyfinish:= Round(HSclientposy+(hgame/2.018691588785047))
	imageheight := imageyfinish-imageystart
	imagewith := imagexfinish-imagexstart
	imageloc := imagexstart . "|" . imageystart . "|" . imagewith . "|" . imageheight
	;msgbox, %imageloc%
	imagepath := A_workingdir . "\Images\card1found2Weapon.png"
	Screenshot(imagepath,imageloc)
	;;;;;;;weapon Image 2 found 2 start ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	imagexstart:= Round(HSclientposx+(wgame/2)-(hgame/3.085714285714286))
	imagexfinish:= Round(HSclientposx+(wgame/2)-(hgame/4.044943820224719))
	imageystart:= Round(HSclientposy+(hgame/2.080924855491329))
	imageyfinish:= Round(HSclientposy+(hgame/2.018691588785047))
	imageheight := imageyfinish-imageystart
	imagewith := imagexfinish-imagexstart
	imageloc := imagexstart . "|" . imageystart . "|" . imagewith . "|" . imageheight
	;msgbox, %imageloc%
	imagepath := A_workingdir . "\Images\card2found2Weapon.png"
	sleep 200
	winactivate,ahk_pid %GamePID%
	Screenshot(imagepath,imageloc)
	;Minion image start;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	winactivate,ahk_pid %GamePID%
	for key, val in cardinfo[languageselect2].Basic
	{
		;msgbox hello
		if (val.type = "Minion") and (val.playerClass = "") and (val.collectible <> "")
		{
			searchtextpre := val.name . " " . val.text . " " . val.artist
			searchtext := RemoveShite(searchtextpre)
			break
		}
	}
	sleep 50
	mouseClick,left,searchboxy,searchboxx
	send,{delete}
	sleep 50
	SetKeyDelay, 1, 0
	clipboard = %searchtext%
	sleep 50
	send ^v
	mouseclick,left,searchboxy,searchboxx-20
	sleep 500
	imagexstart:= Round(HSclientposx+(wgame/2)-(hgame/(1080/(960-365))))
	imagexfinish:= Round(HSclientposx+(wgame/2)-(hgame/(1080/(960-444))))
	imageystart:= Round(HSclientposy+(hgame/(1080/170)))
	imageyfinish:= Round(HSclientposy+(hgame/(1080/182)))
	imageheight := imageyfinish-imageystart
	imagewith := imagexfinish-imagexstart
	imageloc := imagexstart . "|" . imageystart . "|" . imagewith . "|" . imageheight
	;msgbox, %imageloc%
	imagepath := A_workingdir . "\Images\cardnotgoldenMinion.png"
	Screenshot(imagepath,imageloc)
	;;;;;; Weapon image start;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	winactivate,ahk_pid %GamePID%
	for key, val in cardinfo[languageselect2].Basic
	{
		;msgbox hello
		if (val.type = "Weapon") and (val.rarity = "Free") and (val.collectible <> "")
		{
			searchtextpreweap := val.name . " " . val.text . " " . val.artist
			searchtextweap := RemoveShite(searchtextpreweap)
			break
		}
	}
	sleep 50
	mouseClick,left,searchboxy,searchboxx
	send,{delete}
	sleep 50
	SetKeyDelay, 1, 0
	clipboard = %searchtextweap%
	sleep 50
	send ^v
	mouseclick,left,searchboxy,searchboxx-20
	sleep 500
	imagexstart:= Round(HSclientposx+(wgame/2)-(hgame/(1080/(960-354))))
	imagexfinish:= Round(HSclientposx+(wgame/2)-(hgame/(1080/(960-471))))
	imageystart:= Round(HSclientposy+(hgame/(1080/174)))
	imageyfinish:= Round(HSclientposy+(hgame/(1080/193)))
	imageheight := imageyfinish-imageystart
	imagewith := imagexfinish-imagexstart
	imageloc := imagexstart . "|" . imageystart . "|" . imagewith . "|" . imageheight
	;msgbox, %imageloc%
	imagepath := A_workingdir . "\Images\cardnotgoldenWeapon.png"
	Screenshot(imagepath,imageloc)
	;;;;; Spell imagestart;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	winactivate,ahk_pid %GamePID%
	for key, val in cardinfo[languageselect2].Basic
	{
		;msgbox hello
		if (val.type = "Spell") and (val.rarity = "Free") and (val.collectible <> "")
		{
			searchtextprespell := val.name . " " . val.text . " " . val.artist
			searchtextspell := RemoveShite(searchtextprespell)
			break
		}
	}
	mouseClick,left,searchboxy,searchboxx
	send,{delete}
	sleep 50
	SetKeyDelay, 1, 0
	clipboard = %searchtextspell%
	sleep 50
	send ^v
	mouseclick,left,searchboxy,searchboxx-20
	sleep 500
	imagexstart:= Round(HSclientposx+(wgame/2)-(hgame/(1080/(960-352))))
	imagexfinish:= Round(HSclientposx+(wgame/2)-(hgame/(1080/(960-452))))
	imageystart:= Round(HSclientposy+(hgame/(1080/463)))
	imageyfinish:= Round(HSclientposy+(hgame/(1080/472)))
	imageheight := imageyfinish-imageystart
	imagewith := imagexfinish-imagexstart
	imageloc := imagexstart . "|" . imageystart . "|" . imagewith . "|" . imageheight
	;msgbox, %imageloc%
	imagepath := A_workingdir . "\Images\cardnotgoldenSpell.png"
	Screenshot(imagepath,imageloc)
	;;;;; Legendary start;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	winactivate,ahk_pid %GamePID%
	msgbox,262144,Collection Exporter,Please search for a legendary minion you own and have it in the 1st slot of the collection. Click ok when you have done this.
	imagexstart:= Round(HSclientposx+(wgame/2)-(hgame/(1080/(960-381))))
	imagexfinish:= Round(HSclientposx+(wgame/2)-(hgame/(1080/(960-448))))
	imageystart:= Round(HSclientposy+(hgame/(1080/157)))
	imageyfinish:= Round(HSclientposy+(hgame/(1080/180)))
	imageheight := imageyfinish-imageystart
	imagewith := imagexfinish-imagexstart
	imageloc := imagexstart . "|" . imageystart . "|" . imagewith . "|" . imageheight
	;msgbox, %imageloc%
	imagepath := A_workingdir . "\Images\cardnotgoldenMinionLegendary.png"
	Screenshot(imagepath,imageloc)
	;;; card 1 not found start;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	winactivate,ahk_pid %GamePID%
	mouseClick,left,searchboxy,searchboxx
	send,{delete}
	sleep 50
	SetKeyDelay, 1, 0
	clipboard = sdkjgnzdshgkznxoldfnhgoizxhofidghoiadshrougfauisdhgfui
	sleep 50
	send ^v
	mouseclick,left,searchboxy,searchboxx-20
	sleep 50
	sleep 500
	imagexstart:= Round(HSclientposx+(wgame/2)-(hgame/(1080/(960-370))))
	imagexfinish:= Round(HSclientposx+(wgame/2)-(hgame/(1080/(960-476))))
	imageystart:= Round(HSclientposy+(hgame/(1080/221)))
	imageyfinish:= Round(HSclientposy+(hgame/(1080/348)))
	imageheight := imageyfinish-imageystart
	imagewith := imagexfinish-imagexstart
	imageloc := imagexstart . "|" . imageystart . "|" . imagewith . "|" . imageheight
	;msgbox, %imageloc%
	imagepath := A_workingdir . "\Images\card1notfound.png"
	Screenshot(imagepath,imageloc)
	;;;;; card 2 not found start;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	imagexstart:= Round(HSclientposx+(wgame/2)-(hgame/(1080/(960-589))))
	imagexfinish:= Round(HSclientposx+(wgame/2)-(hgame/(1080/(960-704))))
	imageystart:= Round(HSclientposy+(hgame/(1080/221)))
	imageyfinish:= Round(HSclientposy+(hgame/(1080/348)))
	imageheight := imageyfinish-imageystart
	imagewith := imagexfinish-imagexstart
	imageloc := imagexstart . "|" . imageystart . "|" . imagewith . "|" . imageheight
	;msgbox, %imageloc%
	imagepath := A_workingdir . "\Images\card2notfound.png"
	Screenshot(imagepath,imageloc)
	mouseClick,left,searchboxy,searchboxx
	send,{delete}
	sleep 50
	mouseclick,left,searchboxy,searchboxx-20
	sleep 50
	msgbox Calibration complete!
	winactivate,Sets List,
}

Screenshot(outfile, screen) {
	pToken := Gdip_Startup()
	raster := 0x40000000 + 0x00CC0020
	;msgbox % outfile
	pBitmap := Gdip_BitmapFromScreen(screen)
	;msgbox % pBitmap
	Gdip_SaveBitmapToFile(pBitmap, outfile)
	Gdip_DisposeImage(pBitmap)
	Gdip_Shutdown(pToken)
}

MainFunc()
{	
	global
	hwnd := WinExist("Hearthstone")
	; Retrieve the width (w) and height (h) of the client area.
	GetClientSize(hwnd, wgame, hgame)
	;MsgBox Width = %wgame% Height = %hgame%
	searchboxx := hgame/1.098677517802645
	searchboxy := wgame/2
	;gui,3:show,w200 h300 x y%hgame%,
	Gui,3:Font, cblack s16 w10,
	gui,3:add,text,vStatus,Starting
	gui,3:add,text,w180,`nTo pause press ctrl + F8`nTo resume press ctrl + F7`nPlease do not move the mouse while the program is running.
	Gui,3:+LastFound +AlwaysOnTop
	Gui,3:-Caption +ToolWindow
	Languagefile()
	guicontrol,text,Status,Loading Data
	guicontrol,text,Status,Working!
	for key, val in cardinfo[languageselect2]
	{	
		if ((Basicset = 1 and key = "Basic") or (Classicset = 1 and key = "Classic") or (Naxxset = 1 and key = "Curse of Naxxramas") or (Goblinsset = 1 and key = "Goblins vs Gnomes") or (Rewardset = 1 and key = "Reward") or (Promoset = 1 and key = "Promotion"))
		{
			for key2, val2 in val
			{	
				if val2.collectible = -1
				{
					if (val2.type = "Minion" or val2.type = "Weapon" or val2.type = "Spell")
					{
						
						coordmode,mouse,client
						CardName := val2.name
						searchtextpre := val2.name . " " . val2.text . " " . val2.artist
						StringReplace,searchtextintermed,searchtextpre,<b>,%A_SPACE%,1
						StringReplace,searchtextter,searchtextintermed,</b>,%A_SPACE%,1
						StringReplace,searchtextfor,searchtextter,E.M,%A_SPACE%,1
						StringReplace,searchtextfive,searchtextfor,$,%A_SPACE%,1	
						StringReplace,searchtextsix,searchtextfive,+,%A_SPACE%,1
						StringReplace,searchtextseven,searchtextsix,:,%A_SPACE%,1
						StringReplace,searchtext8,searchtextseven,<i>,%A_SPACE%,1
						StringReplace,searchtext9,searchtext8,</i>,%A_SPACE%,1
						StringReplace,searchtext10,searchtext9,/,%A_SPACE%,1
						StringReplace,searchtext11,searchtext10,(,%A_SPACE%,1
						StringReplace,searchtext12,searchtext11,),%A_SPACE%,1
						StringReplace,searchtext13,searchtext12,â€™,',1
						StringReplace,searchtext,searchtext13,.,%A_SPACE%,1

						;msgbox % searchtext
						Cardtype := "images/cardnotgolden" . val2.type . ".png"
						if val2.rarity = "Legendary"
						{
							Cardtype := "images/cardnotgolden" . val2.type . val2.rarity . ".png"
						}
						cardoneabsent = 0
						cardonefoundtwo = 0
						cardtwoabsent = 0
						cardtwofoundtwo = 0
						classcardfound = 0
						CardGolden = 0
						winactivate,ahk_pid %GamePID%
						mouseClick,left,searchboxy,searchboxx
						send,{delete}
						sleep 50
						SetKeyDelay, 1, 0
						;control,editpaste,%searchtext%,,Hearthstone,
						clipboard = %searchtext%
						sleep 50
						send ^v
						;controlsend,ahk_parent,{enter},Hearthstone,
						mouseclick,left,searchboxy,searchboxx-20
						sleep 50
						card2twoimage := "images/card2found2" . val2.type . ".png"
						card1twoimage := "images/card1found2" . val2.type . ".png"
						msgbox %card2twoimage% %card1twoimage% 
						FindClick(Cardtype,"rHearthstone funcclasscardfound !a")
						if val2.type = "Minion"
						{
							FindClick(Cardtype,"rHearthstone funcclasscardfound !a")
						}
						if val2.type = "Spell"
						{
							FindClick(Cardtype,"rHearthstone funcclasscardfound !a")
						}
						if val2.type = "Weapon"
						{
							FindClick(Cardtype,"rHearthstone funcclasscardfound !a")
						}
						FindClick("/Images/card1notfound.png","funccard1notfound rHearthstone !a")
						FindClick(card1twoimage,"funccard1found2 rHearthstone !a")
						FindClick("/Images/card2notfound.png","funccard2notfound rHearthstone !a")
						FindClick(card2twoimage,"funccard2found2 rHearthstone !a")
						If cardoneabsent = 0
						{
							If classcardfound = 1
							{
								If cardonefoundtwo = 1
								{
									CardNormal = 2
								}
								else
								{
									CardNormal = 1
								}
							}
							else if classcardfound = 0
							{
								CardNormal = 0
								If cardonefoundtwo = 1
								{
									CardGolden = 2
								}
								else
								{
									CardGolden = 1
								}
							}
							If cardtwoabsent = 0
							{
								If cardtwofoundtwo = 1
								{
									CardGolden = 2
								}
								else
								{
									CardGolden = 1
								}
							}
						}
						else
						{
							CardNormal = 0
							CardGolden = 0
						}
						if (key = "Basic")
						{
							if val2.playerClass = ""
							{
								outputcard := CardNormal . "	" . CardGolden . "	" .  val2.cost . "	" . val2.name . "	" . key . "	Basic	=if($D" . formulacounter . " = """","""",if($E" . formulacounter . "=""Legendary"",MIN(($A" . formulacounter . "+$B" . formulacounter . "),1),MIN(($A" . formulacounter . "+$B" . formulacounter . ")," . formulacounter . ")))" . "	" . "=if(($A" . formulacounter . "+$B" . formulacounter . ")>0,1,0)" . "	" . val2.type . "	Neutral	" . val2.race . "	" . val2.attack . "	" . val2.health . "`n"
								formulacounter++
							}
							else
							{
								outputcard := CardNormal . "	" . CardGolden . "	" .  val2.cost . "	" . val2.name . "	" . key . "	Basic	=if($D" . formulacounter . " = """","""",if($E" . formulacounter . "=""Legendary"",MIN(($A" . formulacounter . "+$B" . formulacounter . "),1),MIN(($A" . formulacounter . "+$B" . formulacounter . ")," . formulacounter . ")))" . "	" . "=if(($A" . formulacounter . "+$B" . formulacounter . ")>0,1,0)" . "	" . val2.type . "	" . val2.playerClass . "	" . val2.race . "	" . val2.attack . "	" . val2.health . "`n"
								formulacounter++
							}
						}
						else
						{
							if val2.PlayerClass = ""
							{
								outputcard := CardNormal . "	" . CardGolden . "	" .  val2.cost . "	" . val2.name . "	" . val2.rarity . "	" . key . "	=if($D" . formulacounter . " = """","""",if($E" . formulacounter . "=""Legendary"",MIN(($A" . formulacounter . "+$B" . formulacounter . "),1),MIN(($A" . formulacounter . "+$B" . formulacounter . ")," . formulacounter . ")))" . "	" . "=if(($A" . formulacounter . "+$B" . formulacounter . ")>0,1,0)" . "	" . val2.type . "	Neutral	" . val2.race . "	" . val2.attack . "	" . val2.health . "`n"
								formulacounter++
							}
							else
							{
								outputcard := CardNormal . "	" . CardGolden . "	" .  val2.cost . "	" . val2.name . "	" . val2.rarity . "	" . key . "	=if($D" . formulacounter . " = """","""",if($E" . formulacounter . "=""Legendary"",MIN(($A" . formulacounter . "+$B" . formulacounter . "),1),MIN(($A" . formulacounter . "+$B" . formulacounter . ")," . formulacounter . ")))" . "	" . "=if(($A" . formulacounter . "+$B" . formulacounter . ")>0,1,0)" . "	" . val2.type . "	" . val2.playerClass . "	" . val2.race . "	" . val2.attack . "	" . val2.health . "`n"
								formulacounter++
							}
						}
						fileappend,%outputcard%,%OutputFile%
						CardNormal = 0
						CardGolden = 0
					}
				}
				while pausedbot = 1
				{
					guicontrol,text,Status,Paused
					sleep 1000
				}
				guicontrol,text,Status,Working!
			}
		}
	}
FileSelectFile,SaveFile,S 16,,Save your collection.,Textfile (*.txt)
splitpath,SaveFile,,,extension
If (extension != "txt")
{
	SaveFile .= ".txt"
}
filecopy,%outputfile%,%SaveFile%,1
msgbox,All Done you may now continue to play.
exitapp
}

RemoveShite(searchtextpre)
{
	StringReplace,searchtextintermed,searchtextpre,<b>,%A_SPACE%,1
	StringReplace,searchtextter,searchtextintermed,</b>,%A_SPACE%,1
	StringReplace,searchtextfor,searchtextter,E.M,%A_SPACE%,1
	StringReplace,searchtextfive,searchtextfor,$,%A_SPACE%,1	
	StringReplace,searchtextsix,searchtextfive,+,%A_SPACE%,1
	StringReplace,searchtextseven,searchtextsix,:,%A_SPACE%,1
	StringReplace,searchtext8,searchtextseven,<i>,%A_SPACE%,1
	StringReplace,searchtext9,searchtext8,</i>,%A_SPACE%,1
	StringReplace,searchtext10,searchtext9,/,%A_SPACE%,1
	StringReplace,searchtext11,searchtext10,(,%A_SPACE%,1
	StringReplace,searchtext12,searchtext11,),%A_SPACE%,1
	StringReplace,searchtext13,searchtext12,`;,%A_SPACE%,1
	StringReplace,searchtext14,searchtext13,',%A_SPACE%,1
	StringReplace,searchtext,searchtext14,.,%A_SPACE%,1
	return searchtext
}

GetClientSize(hwnd, ByRef w, ByRef h)
{
    VarSetCapacity(rc, 16)
    DllCall("GetClientRect", "uint", hwnd, "uint", &rc)
    w := NumGet(rc, 8, "int")
    h := NumGet(rc, 12, "int")
}

card1notfound()
{
	global
	cardoneabsent = 1
}

card1found2()
{
	global
	cardonefoundtwo = 1
}

card2notfound()
{
	global
	cardtwoabsent = 1
}

card2found2()
{
	global
	cardtwofoundtwo = 1
}

classcardfound()
{
	global
	classcardfound = 1
}

Languagefile()
{	
	global
	if Languageselect = 1
	{
		Languageselect2 = enGB
	}
	if Languageselect = 2
	{
		Languageselect2 = enUS
	}
	if Languageselect = 3
	{
		Languageselect2 = deDE
	}
	if Languageselect = 4
	{
		Languageselect2 = esES
	}
	if Languageselect = 5
	{
		Languageselect2 = exMX
	}
	if Languageselect = 6
	{
		Languageselect2 = frFR
	}
	if Languageselec t= 7
	{
		Languageselect2 = ruRU
	}
	if Languageselect = 8
	{
		Languageselect2 = itIT
	}
	if Languageselect = 9
	{
		Languageselect2 = koKR
	}
	if Languageselect = 10
	{
		Languageselect2 = plPL
	}
	if Languageselect = 11
	{
		Languageselect2 = ptPT
	}
	if Languageselect = 12
	{
		Languageselect2 = ptBR
	}
	if Languageselect = 13
	{
		Languageselect2 = zhCN
	}
	if Languageselect = 14
	{
		Languageselect2 = zhTW
	}
}

BuildJson(obj) 
{
    str := "" , array := true
    for k in obj {
        if (k == A_Index)
            continue
        array := false
        break
    }
    for a, b in obj
        str .= (array ? "" : """" a """: ") . (IsObject(b) ? BuildJson(b) : IsNumber(b) ? b : """" b """") . ", "	
    str := RTrim(str, " ,")
    return (array ? "[" str "]" : "{" str "}")
}

parseJson(jsonStr)
{
    SC := ComObjCreate("ScriptControl") 
    SC.Language := "JScript"
    ComObjError(false)
    jsCode =
    (
    function arrangeForAhkTraversing(obj){
        if(obj instanceof Array){
            for(var i=0 ; i<obj.length ; ++i)
                obj[i] = arrangeForAhkTraversing(obj[i]) ;
            return ['array',obj] ;
        }else if(obj instanceof Object){
            var keys = [], values = [] ;
            for(var key in obj){
                keys.push(key) ;
                values.push(arrangeForAhkTraversing(obj[key])) ;
            }
            return ['object',[keys,values]] ;
        }else
            return [typeof obj,obj] ;
    }
    )
    SC.ExecuteStatement(jsCode "; obj=" jsonStr)
    return convertJScriptObjToAhks( SC.Eval("arrangeForAhkTraversing(obj)") )
}

convertJScriptObjToAhks(jsObj)
{
    if(jsObj[0]="object"){
        obj := {}, keys := jsObj[1][0], values := jsObj[1][1]
        loop % keys.length
            obj[keys[A_INDEX-1]] := convertJScriptObjToAhks( values[A_INDEX-1] )
        return obj
    }else if(jsObj[0]="array"){
        array := []
        loop % jsObj[1].length
            array.insert(convertJScriptObjToAhks( jsObj[1][A_INDEX-1] ))
        return array
    }else
        return jsObj[1]
}


IsNumber(Num)
{
    if Num is number
        return true
    else
        return false
}