;Written by Jammo2k5
#SingleInstance, Force
#Persistent
#InstallKeybdHook
#UseHook, On
#Include FindClick.ahk
coordmode,mouse,screen
OutputFile = %A_WorkingDir%/Collection.csv
Gui,show,w200 h340,Please Select your Game Language
gui, Add, Text,, Please select your Language.
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
Gui, Add, Radio,w200 , portuguese (Brazil)
Gui, Add, Radio,w200 , Chinese
Gui, Add, Radio,w200 , Chinese (Tailand)
Gui, Add, Button,gStartExport, Start
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

StartExport:
filedelete,%OutputFile%
TitleText := "Mana Cost,Card Name,Type,Class,Set,Rarity,Normal,Golden`n"
fileappend,%TitleText%,%OutputFile%
Gui,submit
msgbox,The exporter is about to export the collection, Please makesure you are on the collection screen with crafting mode off and the search box unselected. `nPlease keep your arms and legs inside the ride at all times (Do not move the mouse) and enjoy the show.
FileRead,CardListMain,%A_WorkingDir%/Cards info/AllSetsAllLanguages.json
cardoneabsent = 0
Process Exist,Hearthstone.exe
GamePID := ErrorLevel
WinGetPos,Lx,Ly,H,W,ahk_pid %GamePID%
winactivate,ahk_pid %GamePID%
winrestore,ahk_pid %GamePID%
winmove,ahk_pid %GamePID%,,100,100,1024,768,
;searchx := %Lx%+485
;searchy := %Ly%+697
MainFunc()
return

MainFunc()
{	
	global
	Languagefile()
	cardinfo := parseJson(CardListMain)
	for key, val in cardinfo[languageselect2]
	{
		for key2, val2 in val
		{	
			if val2.collectible = -1
			{
				if (val2.type = "Minion" or val2.type = "Weapon" or val2.type = "Spell")
				{
					CardName := val2.name
					searchtext = hello
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
					StringReplace,searchtext,searchtext12,.,%A_SPACE%,1
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
					winactivate,ahk_pid %GamePID%
					mouseClick,left,585,797
					send,{delete}
					sleep 200
					SetKeyDelay, 1, 0
					;control,editpaste,%searchtext%,,Hearthstone,
					clipboard = %searchtext%
					sleep 100
					send ^v
					;controlsend,ahk_parent,{enter},Hearthstone,
					mouseclick,left,585,757
					sleep 100
					card2twoimage := "images/card2found2" . val2.type
					card1twoimage := "images/card1found2" . val2.type
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
						pixelsearch,pixelfound,,136,250,137,251,0x4F483F,40,RGB
						if pixelfound = 136
						{
							classcardfound = 1
						}
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
						else
						{
							CardGolden = 0
						}
					}
					else
					{
						CardNormal = 0
						CardGolden = 0
					}
					outputcard := val2.cost . "," . val2.name . "," . val2.type . "," . val2.playerClass . "," . key . "," . val2.rarity . "," . CardNormal . "," . CardGolden "`n"
					if val2.PlayerClass = ""
					{
						winactivate,ahk_pid %NotePID%
						outputcard := val2.cost . "," . val2.name . "," . val2.type . ",Neutral," . key . "," . val2.rarity . "," . CardNormal . "," . CardGolden "`n"
					}
					fileappend,%outputcard%,%OutputFile%
					CardNormal = 0
					CardGolden = 0
				}
			}
			while pausedbot = 1
			{
				sleep 1000
			}
		}
	}
msgbox,All Done you may now continue to play.
exitapp
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