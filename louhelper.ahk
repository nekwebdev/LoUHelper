#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; Gui Tooltips class
#Include Class_GuiControlTips.ahk
; Basic recommended AHK settings
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode, Mouse, Window
; This is used because alt modifier would send the ctrl modifier as well. Check AHK docs.
#MenuMaskKey vk07

FileInstall, back.bmp, back.bmp
FileInstall, character.bmp, character.bmp
FileInstall, charplay.bmp, charplay.bmp
FileInstall, community.bmp, community.bmp
FileInstall, enter.bmp, enter.bmp
FileInstall, failed.bmp, failed.bmp
FileInstall, ingame.bmp, ingame.bmp
FileInstall, loultima.bmp, loultima.bmp
FileInstall, okerror.bmp, okerror.bmp
FileInstall, open.bmp, open.bmp
FileInstall, config.ini, config.ini
FileInstall, default.ini, default.ini
FileInstall, helper.ico, helper.ico

;Set our icon.
Menu, Tray, Icon, Helper.ico

;Basic Globals
Seperator := Chr(1)

;Get last loaded config
IniRead, UserConfig, config.ini, ConfigSetting, UserConfig
;Get the configs list
gosub, GetConfigs
TempConfig := Configs%UserConfig%
IniRead, MaxSpots, %TempConfig%, GuiSettings, MaxSpots
IniRead, MaxCustom, %TempConfig%, GuiSettings, MaxCustom
IniRead, MaxCustomKeys, %TempConfig%, GuiSettings, MaxCustomKeys
StringTrimRight, TempConfig, TempConfig, 4
guiname := "LoU Helper v1.9 - " . TempConfig

;Get Routine Messages
IniRead, RoutineMessages, config.ini, ConfigRoutineMessages
Loop Parse, RoutineMessages, `n
{
	MessageArray := StrSplit(A_LoopField, "=")
	RoutineMessage%A_Index% := MessageArray[2]
}

;Lists of settings to iterate
Tabs = General|GeneralKeys|Taming|Music|Healing|Hiding|Fishing|Offensive|Lockpicking|Custom|Harvesting|ItemID|ItemTransfer|CustomKeys

GuiSettingsList = MoveCycleCount,MoveToX,MoveToY,MoveFromX,MoveFromY,ItemTransfer,ItemTransferBreak,Survey,OnTop,FromName,WinName,AutoRelog,CharNumber,Sens,LagDelay,KeyDelay,Taming,TamingDelay,Release,ReleaseDelay,ReleaseSens,Lore,LoreDelay,Vet,VetDelay,Music,MusicDelay,Peace,PeaceDelay,Provo,ProvoDelay,Discord,DiscordDelay,Bandages,MagicHeal,CurePot,CureSpell,HealingDelay,Hiding,Stealth,Steps,HidingDelay,Fishing,FishingDelay,FishingX1,FishingY1,Fishing2,FishingX2,FishingY2,FishingTotal,Physical,PhysicalDuration,MagicAtk,DoubleTarget,OffensiveDelay,Lockpicking,LockpickDelay,Box1X,Box1Y,Lockpicking2,Box2X,Box2Y,LockpickingSens,ItemID,ItemIDSourceTLX,ItemIDSourceTLY,ItemIDSourceBRX,ItemIDSourceBRY,ItemIDContainerX,ItemIDContainerY,ItemIDSens,ItemIDDelay,CustomRoutineDelay,HarvestingRoutineDelay,HarvestSens

GuiDPSettingsList = BandagesTarget,MagicHealTarget,CurePotTarget,CureSpellTarget,MagicAtkTarget

GuiHotkeysList = SurveyKey,SelfKey,TargetKey,LastKey,SkillKey,SecondKey,NextTargetKey,LastObjectKey,CenterCamKey,BackpackKey,StopKey,StartKey,LeftKey,RightKey,UpKey,DownKey,TamingKey,ReleaseKey,LoreKey,AllKillKey,AllStopKey,MusicKey,PeaceKey,ProvoKey,DiscordKey,BandagesKey,MagicHealKey,CurePotKey,CureSpellKey,HidingKey,FishingKey1,FishingKey2,FishingKey3,FishingKey4,FishingKey5,FishingKey6,FishingKey7,FishingKey8,FishingKey9,PhysicalKey,MagicAtkKey,Box1Key,Box2Key,GlassKey,LockpickKey

GuiLabelsList = MoveCycleCountLabel,MoveToXLabel,MoveToYLabel,MoveFromXLabel,MoveFromYLabel,SurveyLabel,OptionTitle,TabsList,ConfigLabel,ClientNameLabel,FromNameLabel,ToNameLabel,CharNumberLabel,SensLabel,SelfKeyLabel,TargetKeyLabel,LastKeyLabel,LastObjectLabel,SkillKeyLabel,SecondKeyLabel,NextTargetKeyLabel,CenterCamKeyLabel,BackpackKeyLabel,KeyDelayLabel,LagDelayLabel,StopKeyLabel,StartKeyLabel,UpKeyLabel,LeftKeyLabel,DownKeyLabel,RightKeyLabel,TamingKeyLabel,TamingDelayLabel,ReleaseKeyLabel,ReleaseDelayLabel,ReleaseSensLabel,LoreKeyLabel,LoreDelayLabel,AllKillKeyLabel,AllStopKeyLabel,VetDelayLabel,MusicKeyLabel,MusicDelayLabel,PeaceKeyLabel,PeaceDelayLabel,ProvoKeyLabel,ProvoDelayLabel,DiscordKeyLabel,DiscordDelayLabel,BandagesKeyLabel,MagicHealKeyLabel,CurePotLabel,CureSpellLabel,HealingDelayLabel,HidingKeyLabel,HidingDelayLabel,StepsLabel,FishingTotalLabel,FishingDelayLabel,FishingX1Label,FishingY1Label,FishingX2Label,FishingY2Label,FishingKey1Label,FishingKey2Label,FishingKey3Label,FishingKey4Label,FishingKey5Label,FishingKey6Label,FishingKey7Label,FishingKey8Label,FishingKey9Label,PhysicalKeyLabel,PhysicalDurationLabel,MagicAtkKeyLabel,OffensiveDelayLabel,LockpickKeyLabel,LockpickDelayLabel,Box1XLabel,Box1YLabel,Box1KeyLabel,Box2XLabel,Box2YLabel,Box2KeyLabel,LockpickingSensLabel,ItemIDSourceTLXLabel,ItemIDSourceTLYLabel,ItemIDSourceBRXLabel,ItemIDSourceBRYLabel,ItemIDContainerXLabel,ItemIDContainerYLabel,GlassKeyLabel,ItemIDSensLabel,ItemIDDelayLabel,CustomRoutineDelayLabel,HarvestingRoutineDelayLabel,HarvestSensLabel

GuiSetButtonsList = LoadedConfig,SetName,SetFishing,SetBox,SetSpotTarget,SetCustomCoordsItem,SetCustomCoordsTarget

FishingOptionsList = Fishing2,FishingX2Label,FishingX2,FishingY2Label,FishingY2,SetFishing2

LockpickingOptionsList = Lockpicking2,Box2XLabel,Box2X,Box2YLabel,Box2Y,SetBox2

Loop, %MaxSpots%
{
	GuiSettingsList = %GuiSettingsList%,Spot%A_Index%Active,Spot%A_Index%Scroll,Spot%A_Index%X1,Spot%A_Index%Y1,Spot%A_Index%X2,Spot%A_Index%Y2,Spot%A_Index%X3,Spot%A_Index%Y3,Spot%A_Index%X4,Spot%A_Index%Y4,Spot%A_Index%X5,Spot%A_Index%Y5,Spot%A_Index%X6,Spot%A_Index%Y6

	GuiHotkeysList = %GuiHotkeysList%,Spot%A_Index%ToolKey,Spot%A_Index%RuneKey,Spot%A_Index%ScrollKey

	GuiLabelsList = %GuiLabelsList%,Spot%A_Index%ToolLabel,Spot%A_Index%RuneKeyLabel,Spot%A_Index%ScrollLabel,Spot%A_Index%X1Label,Spot%A_Index%Y1Label,Spot%A_Index%X2Label,Spot%A_Index%Y2Label,Spot%A_Index%X3Label,Spot%A_Index%Y3Label,Spot%A_Index%X4Label,Spot%A_Index%Y4Label,Spot%A_Index%X5Label,Spot%A_Index%Y5Label,Spot%A_Index%X6Label,Spot%A_Index%Y6Label

	Tabs = %Tabs%|Spot%A_Index%
}

Loop, %MaxCustom%
{
	GuiSettingsList = %GuiSettingsList%,Custom%A_Index%Active,Custom%A_Index%CoordsItem,Custom%A_Index%CoordsTarget,Custom%A_Index%CoordsRight,Custom%A_Index%CoordsItemX,Custom%A_Index%CoordsItemY,Custom%A_Index%CoordsTargetX,Custom%A_Index%CoordsTargetY,Custom%A_Index%CoordsRightX,Custom%A_Index%CoordsRightY,Custom%A_Index%PreDelay,Custom%A_Index%PostDelay

	GuiDPSettingsList = %GuiDPSettingsList%,Custom%A_Index%Target

	GuiHotkeysList = %GuiHotkeysList%,Custom%A_Index%Key

	GuiLabelsList = %GuiLabelsList%,Custom%A_Index%KeyLabel,Custom%A_Index%CoordsItemXLabel,Custom%A_Index%CoordsItemYLabel,Custom%A_Index%CoordsTargetXLabel,Custom%A_Index%CoordsTargetYLabel,Custom%A_Index%CoordsRightXLabel,Custom%A_Index%CoordsRightYLabel,Custom%A_Index%PreDelayLabel,Custom%A_Index%PostDelayLabel

	Tabs = %Tabs%|Custom%A_Index%
}

Loop, %MaxCustomKeys%
{
	GuiDPSettingsList = %GuiDPSettingsList%,CustomKeys%A_Index%Key1Mod,CustomKeys%A_Index%Key2Mod,CustomKeys%A_Index%Key3Mod,CustomKeys%A_Index%Key4Mod,CustomKeys%A_Index%Key5Mod

	GuiHotkeysList = %GuiHotkeysList%,CustomKeys%A_Index%Key1InGame,CustomKeys%A_Index%Key2InGame,CustomKeys%A_Index%Key3InGame,CustomKeys%A_Index%Key4InGame,CustomKeys%A_Index%Key5InGame,CustomKeys%A_Index%Key1,CustomKeys%A_Index%Key2,CustomKeys%A_Index%Key3,CustomKeys%A_Index%Key4,CustomKeys%A_Index%Key5

	GuiLabelsList = %GuiLabelsList%,CustomKeys%A_Index%Key1IngameLabel,CustomKeys%A_Index%Key2IngameLabel,CustomKeys%A_Index%Key3IngameLabel,CustomKeys%A_Index%Key4IngameLabel,CustomKeys%A_Index%Key5IngameLabel,CustomKeys%A_Index%Key1Label,CustomKeys%A_Index%Key2Label,CustomKeys%A_Index%Key3Label,CustomKeys%A_Index%Key4Label,CustomKeys%A_Index%Key5Label

	Tabs = %Tabs%|CustomKeys%A_Index%
}

;Global GUI settings
Gui, New, hwndHGUI
Gui, -MinimizeBox

;;GUI elements fixed sizes
SelectionHeight := 197
LeftColumnWidth := 100
SettingsWidth := 340
Line1 := 45
LineHeight := 30
TextOffset := 3
SetOffset := 4
HotkeyWidth := 21
StdLabelWidth := 74
DelayLabelWidth := 61
DelayWidth := 34
CoordLabelWidth := 15
CoordWidth := 30
CheckBoxWidth := 100
SetButtonWidth := 28
ClientNameWidth := 110

;Calculated Sizes
SettingsWidthInside := SettingsWidth - 11
TabHeight := SelectionHeight - 33
TitleX := LeftColumnWidth + 20
Left := LeftColumnWidth + LineHeight
Line1Text := Line1 - TextOffset
Line1Set := Line1 - SetOffset
Line2 := Line1 + LineHeight
Line2Text := Line1Text + LineHeight
Line2Set := Line2 - SetOffset
Line3 := Line2 + LineHeight
Line3Text := Line2Text + LineHeight
Line3Set := Line3 - SetOffset
Line4 := Line3 + LineHeight
Line4Text := Line3Text + LineHeight
Line4Set := Line4 - SetOffset
Line5 := Line4 + LineHeight
Line5Text := Line4Text + LineHeight
Line5Set := Line5 - SetOffset

TT := New GuiControlTips(HGUI)
TT.SetDelayTimes(200, 3000, -1)

Gui, Add, DropDownList, w%LeftColumnWidth% AltSubmit hwndHLoadedConfig vLoadedConfig gLoadConfigReload
TT.Attach(HLoadedConfig, "Choose a custom profile")

Gui, Add, TreeView, R1 h%SelectionHeight% w%LeftColumnWidth% -0x4 AltSubmit -Buttons gTVLabel
	P1 := TV_Add("General",,"Expand")
	P2 := TV_Add("Hotkeys")
	P3 := TV_Add("Taming")
	P4 := TV_Add("Music")
	P5 := TV_Add("Healing")
	P6 := TV_Add("Hiding")
	P7 := TV_Add("Fishing")
	P8 := TV_Add("Offensive")
	P9 := TV_Add("Lockpicking")
	P10 := TV_Add("Item ID")
	P11 := TV_Add("Harvesting",,"Expand")
	Loop, %MaxSpots%
	{
		SpotTab = Spot %A_Index%
		P11C%A_Index% := TV_Add(SpotTab,P11)
	}
	P12 := TV_Add("Custom",,"Expand")
	Loop, %MaxCustom%
	{
		CustomTab = Custom %A_Index%
		P12C%A_Index% := TV_Add(CustomTab,P12)
	}
	P13 := TV_Add("Custom Keys",,"Expand")
	Loop, %MaxCustomKeys%
	{
		CustomKeysTab = Page %A_Index%
		P13C%A_Index% := TV_Add(CustomKeysTab,P13)
	}
	P14 := TV_Add("Item Transfer")

;Here GUI coords offsets are still hard coded, havent figured a clean way to do it yet.

;;Tab Header
Gui, Font, s10 Bold
Gui, Add, Text, x%TitleX% y9 w%SettingsWidth% h20 Center vOptionTitle, General Settings
Gui, Font, s8 Norm
Gui, Add, GroupBox, xp yp+18 w%SettingsWidth% h%TabHeight%
Gui, Add, Tab2, xp yp w0 h0 -Wrap vTabsList, %Tabs%

;;General Settings
Gui, Tab, General

Gui, Add, Checkbox, x%Left% y%Line1% hwndHOnTop vOnTop gOnTop, Window always on top
TT.Attach(HOnTop, "Keep LoU Helper window always on top")
;Change Window name
Gui, Add, Text, x%Left% y%Line2% w%SettingsWidthInside% Center hwndHClientNameLabel vClientNameLabel, Change the client window name:
Gui, Add, Text, x%Left% y%Line3% w%HotkeyWidth% Right vFromNameLabel, Old
Gui, Add, Edit, xp+26 y%Line3Text% w%ClientNameWidth% hwndHFromName vFromName, Legends of Aria
TT.Attach(HFromName, "Initial name of the LoA client")
Gui, Add, Text, xp+125 y%Line3% w%HotkeyWidth% Right vToNameLabel, New
Gui, Add, Edit, xp+26 y%Line3Text% w%ClientNameWidth% hwndHWinName vWinName, Legends of Aria
TT.Attach(HWinName, "New name, this is the name that will be used by LoU Helper")
Gui, Add, Button, xp+115 y%Line3Set% w%SetButtonWidth% hwndHSetName vSetName gSetName, Set
TT.Attach(HSetName, "Set your LoA Client window to the new name")
;Auto-Relog
Gui, Add, Checkbox, x%Left% y%Line4% w%CheckBoxWidth% hwndHAutoRelog vAutoRelog, Auto-Relog (warning)
TT.Attach(HAutoRelog, "Activate the autorelog feature. Will make window active and block input each loop.")
Gui, Add, Text, xp+110 y%Line4% w81 Right vCharNumberLabel, Character #
Gui, Add, Edit, xp+86 y%Line4Text% w14 hwndHCharNumber vCharNumber, 1
TT.Attach(HCharNumber, "Character number, 1 to 4, top to bottom")
Gui, Add, Text, xp+24 y%Line4% w%StdLabelWidth% Right vSensLabel, Tolerance
Gui, Add, Edit, xp+79 y%Line4Text% w%HotkeyWidth% hwndHSens vSens, 60
TT.Attach(HSens, "Tolerance for Image Search. Raise if it never matches")
;Misc
Gui, Add, Text, x%Left% y%Line5% w%DelayLabelWidth% Right vLagDelayLabel, Lag Delay
Gui, Add, Edit, xp+65 y%Line5Text% w%DelayWidth% vLagDelay

;;General Hotkey Settings
Gui, Tab, GeneralKeys
;Stop Keys
Gui, Add, Text, x%Left% y%Line1% w%StdLabelWidth% Right vStopKeyLabel, Stop Key
Gui, Add, Edit, xp+79 y%Line1Text% w%HotkeyWidth% vStopKey, F4
Gui, Add, Text, xp+31 y%Line1% w%StdLabelWidth% Right vStartKeyLabel, Start
Gui, Add, Edit, xp+79 y%Line1Text% w%HotkeyWidth% vStartKey, F5
Gui, Add, Text, xp+31 y%Line1% w%StdLabelWidth% Right vLastObjectLabel, Last Object
Gui, Add, Edit, xp+79 y%Line1Text% w%HotkeyWidth% vLastObjectKey,
;Targeting keys
Gui, Add, Text, x%Left% y%Line2% w%StdLabelWidth% Right vSelfKeyLabel, Target Self
Gui, Add, Edit, xp+79 y%Line2Text% w%HotkeyWidth% vSelfKey, g
Gui, Add, Text, xp+31 y%Line2% w%StdLabelWidth% Right vTargetKeyLabel, Current Target
Gui, Add, Edit, xp+79 y%Line2Text% w%HotkeyWidth% vTargetKey, y
Gui, Add, Text, xp+31 y%Line2% w%StdLabelWidth% Right vLastKeyLabel, Last Target
Gui, Add, Edit, xp+79 y%Line2Text% w%HotkeyWidth% vLastKey, t
;Skills
Gui, Add, Text, x%Left% y%Line3% w%StdLabelWidth% Right vSkillKeyLabel, Main Skill
Gui, Add, Edit, xp+79 y%Line3Text% w%HotkeyWidth% vSkillKey, q
Gui, Add, Text, xp+31 y%Line3% w%StdLabelWidth% Right vSecondKeyLabel, Second Skill
Gui, Add, Edit, xp+79 y%Line3Text% w%HotkeyWidth% vSecondKey, e
Gui, Add, Text, xp+31 y%Line3% w%StdLabelWidth% Right vNextTargetKeyLabel, Next Target
Gui, Add, Edit, xp+79 y%Line3Text% w%HotkeyWidth% vNextTargetKey
;Misc1
Gui, Add, Text, x%Left% y%Line4% w%StdLabelWidth% Right vCenterCamKeyLabel, Center Cam
Gui, Add, Edit, xp+79 y%Line4Text% w%HotkeyWidth% vCenterCamKey, z
Gui, Add, Text, xp+31 y%Line4% w%StdLabelWidth% Right vBackpackKeyLabel, Open Bag
Gui, Add, Edit, xp+79 y%Line4Text% w%HotkeyWidth% vBackpackKey, b
Gui, Add, Text, xp+31 y%Line4% w%StdLabelWidth% Right vKeyDelayLabel, Key Delay
Gui, Add, Edit, xp+79 y%Line4Text% w%HotkeyWidth% vKeyDelay, 60
;Movement
Gui, Add, Text, x%Left% y%Line5% w36 Right vUpKeyLabel, Up
Gui, Add, Edit, xp+41 y%Line5Text% w%DelayWidth% vUpKey, w
Gui, Add, Text, xp+40 y%Line5% w36 Right vLeftKeyLabel, Left
Gui, Add, Edit, xp+41 y%Line5Text% w%DelayWidth% vLeftKey, a
Gui, Add, Text, xp+41 y%Line5% w36 Right vDownKeyLabel, Down
Gui, Add, Edit, xp+41 y%Line5Text% w%DelayWidth% vDownKey, s
Gui, Add, Text, xp+41 y%Line5% w36 Right vRightKeyLabel, Right
Gui, Add, Edit, xp+41 y%Line5Text% w%DelayWidth% vRightKey, d

;;Taming Settings
Gui, Tab, Taming
;Taming
Gui, Add, Checkbox, x%Left% y%Line1% w%CheckBoxWidth% vTaming gTamingOptions, Taming
Gui, Add, Text, xp+110 y%Line1% w%StdLabelWidth% Right vTamingKeyLabel, Taming Key
Gui, Add, Edit, xp+79 y%Line1Text% w%HotkeyWidth% vTamingKey
Gui, Add, Text, xp+31 y%Line1% w%DelayLabelWidth% Right vTamingDelayLabel, Delay
Gui, Add, Edit, xp+66 y%Line1Text% w%DelayWidth% vTamingDelay, 0
;Release
Gui, Add, Checkbox, x%Left% y%Line2% w%CheckBoxWidth% Disabled vRelease gReleaseOptions, Release
Gui, Add, Text, xp+110 y%Line2% w%StdLabelWidth% Right vReleaseKeyLabel, Release Key
Gui, Add, Edit, xp+79 y%Line2Text% w%HotkeyWidth% vReleaseKey
Gui, Add, Text, xp+31 y%Line2% w%DelayLabelWidth% Right vReleaseDelayLabel, Delay
Gui, Add, Edit, xp+66 y%Line2Text% w%DelayWidth% vReleaseDelay, 0
;Lore
Gui, Add, Checkbox, x%Left% y%Line3% w%CheckBoxWidth% vLore, Lore
Gui, Add, Text, xp+110 y%Line3% w%StdLabelWidth% Right vLoreKeyLabel, Lore Key
Gui, Add, Edit, xp+79 y%Line3Text% w%HotkeyWidth% vLoreKey
Gui, Add, Text, xp+31 y%Line3% w%DelayLabelWidth% Right vLoreDelayLabel, Delay
Gui, Add, Edit, xp+66 y%Line3Text% w%DelayWidth% vLoreDelay, 0
;Veterinary
Gui, Add, Checkbox, x%Left% y%Line4% w40 vVet, Vet
Gui, Add, Text, xp+58 y%Line4% w40 Right vAllKillKeyLabel, All Kill
Gui, Add, Edit, xp+45 y%Line4Text% w%HotkeyWidth% vAllKillKey
Gui, Add, Text, xp+41 y%Line4% w40 Right vAllStopKeyLabel, All Stop
Gui, Add, Edit, xp+45 y%Line4Text% w%HotkeyWidth% vAllStopKey
Gui, Add, Text, xp+31 y%Line4% w%DelayLabelWidth% Right vVetDelayLabel, Delay
Gui, Add, Edit, xp+66 y%Line4Text% w%DelayWidth% vVetDelay, 0

Gui, Add, Text, xp-151 y%Line5% w150 Right vReleaseSensLabel, Tolerance for image searching
Gui, Add, Edit, xp+155 y%Line5Text% w%CoordWidth% HwndHReleaseSens vReleaseSens, 100
TT.Attach(HReleaseSens, "Tolerance for Image Search. Raise if it never matches with the correct release.bmp. Over 100 is too much")

;;Music Settings
Gui, Tab, Music
;Music
Gui, Add, Checkbox, x%Left% y%Line1% w%CheckBoxWidth% vMusic gMusicOptions, Music
Gui, Add, Text, xp+110 y%Line1% w%StdLabelWidth% Right vMusicKeyLabel, Music Key
Gui, Add, Edit, xp+79 y%Line1Text% w%HotkeyWidth% vMusicKey
Gui, Add, Text, xp+31 y%Line1% w%DelayLabelWidth% Right vMusicDelayLabel, Delay
Gui, Add, Edit, xp+66 y%Line1Text% w%DelayWidth% vMusicDelay, 0
;Peace
Gui, Add, Checkbox, x%Left% y%Line2% w%CheckBoxWidth% vPeace gMusicOptions, Peace
Gui, Add, Text, xp+110 y%Line2% w%StdLabelWidth% Right vPeaceKeyLabel, Peace Key
Gui, Add, Edit, xp+79 y%Line2Text% w%HotkeyWidth% vPeaceKey
Gui, Add, Text, xp+31 y%Line2% w%DelayLabelWidth% Right vPeaceDelayLabel, Delay
Gui, Add, Edit, xp+66 y%Line2Text% w%DelayWidth% vPeaceDelay, 0
;Provoke
Gui, Add, Checkbox, x%Left% y%Line3% w%CheckBoxWidth% vProvo gMusicOptions, Provoke
Gui, Add, Text, xp+110 y%Line3% w%StdLabelWidth% Right vProvoKeyLabel, Provoke Key
Gui, Add, Edit, xp+79 y%Line3Text% w%HotkeyWidth% vProvoKey
Gui, Add, Text, xp+31 y%Line3% w%DelayLabelWidth% Right vProvoDelayLabel, Delay
Gui, Add, Edit, xp+66 y%Line3Text% w%DelayWidth% vProvoDelay, 0
;Discord
Gui, Add, Checkbox, x%Left% y%Line4% w%CheckBoxWidth% vDiscord gMusicOptions, Discord
Gui, Add, Text, xp+110 y%Line4% w%StdLabelWidth% Right vDiscordKeyLabel, Discord Key
Gui, Add, Edit, xp+79 y%Line4Text% w%HotkeyWidth% vDiscordKey
Gui, Add, Text, xp+31 y%Line4% w%DelayLabelWidth% Right vDiscordDelayLabel, Delay
Gui, Add, Edit, xp+66 y%Line4Text% w%DelayWidth% vDiscordDelay, 0

;;Healing Settings
Gui, Tab, Healing
;Bandages
Gui, Add, Checkbox, x%Left% y%Line1% w%CheckBoxWidth% vBandages, Bandages
Gui, Add, Text, xp+110 y%Line1% w%StdLabelWidth% Right vBandagesKeyLabel, Bandages Key
Gui, Add, Edit, xp+79 y%Line1Text% w%HotkeyWidth% vBandagesKey
Gui, Add, Dropdownlist, xp+31 y%Line1Text% w%CheckBoxWidth% AltSubmit vBandagesTarget, |Self|Current|Last
;Magic Heal
Gui, Add, Checkbox, x%Left% y%Line2% w%CheckBoxWidth% vMagicHeal, Magic
Gui, Add, Text, xp+110 y%Line2% w%StdLabelWidth% Right vMagicHealKeyLabel, Spell Key
Gui, Add, Edit, xp+79 y%Line2Text% w%HotkeyWidth% vMagicHealKey
Gui, Add, Dropdownlist,  xp+31 y%Line2Text% w%CheckBoxWidth% AltSubmit vMagicHealTarget, |Self|Current|Last
;Cure Potion
Gui, Add, Checkbox, x%Left% y%Line3% w%CheckBoxWidth% vCurePot, Cure Potion
Gui, Add, Text, xp+110 y%Line3% w%StdLabelWidth% Right vCurePotLabel, Cure Potion Key
Gui, Add, Edit, xp+79 y%Line3Text% w%HotkeyWidth% vCurePotKey
Gui, Add, Dropdownlist,  xp+31 y%Line3Text% w%CheckBoxWidth% AltSubmit vCurePotTarget, |Self|Current|Last
;Cure Spell
Gui, Add, Checkbox, x%Left% y%Line4% w%CheckBoxWidth% vCureSpell, Cure Spell
Gui, Add, Text, xp+110 y%Line4% w%StdLabelWidth% Right vCureSpellLabel, Cure Spell Key
Gui, Add, Edit, xp+79 y%Line4Text% w%HotkeyWidth% vCureSpellKey
Gui, Add, Dropdownlist, xp+31 y%Line4Text% w%CheckBoxWidth% AltSubmit vCureSpellTarget, |Self|Current|Last
;Healing Delay
Gui, Add, Text, x%Left% y%Line5% w%DelayLabelWidth% Right vHealingDelayLabel, Delay
Gui, Add, Edit, xp+72 y%Line5Text% w%DelayWidth% vHealingDelay

;;Hiding Settings
Gui, Tab, Hiding
;Hiding
Gui, Add, Checkbox, x%Left% y%Line1% w%CheckBoxWidth% vHiding gHidingOptions, Hiding
Gui, Add, Text, xp+110 y%Line1% w%StdLabelWidth% Right vHidingKeyLabel, Hiding Key
Gui, Add, Edit, xp+79 y%Line1Text% w%HotkeyWidth% vHidingKey
Gui, Add, Text, xp+31 y%Line1% w%DelayLabelWidth% Right vHidingDelayLabel, Delay
Gui, Add, Edit, xp+66 y%Line1Text% w%DelayWidth% vHidingDelay, 0
;Stealth
Gui, Add, Checkbox, x%Left% y%Line2% w%CheckBoxWidth% vStealth Disabled, Stealth
Gui, Add, Text, xp+110 y%Line2% w%StdLabelWidth% Right vStepsLabel, Steps
Gui, Add, Edit,  xp+79 y%Line2Text% w%HotkeyWidth% vSteps, 3

;;Fishing Settings
Gui, Tab, Fishing
;Fishing
Gui, Add, Checkbox, x%Left% y%Line1% vFishing gFishingOptions, Fishing
;Fishing Spot 1
Gui, Add, Text, xp+63 y%Line1% w%CoordLabelWidth% vFishingX1Label, X1
Gui, Add, Edit, xp+20 y%Line1Text% w%CoordWidth% vFishingX1
Gui, Add, Text, xp+40 y%Line1% w%CoordLabelWidth% vFishingY1Label, Y1
Gui, Add, Edit, xp+20 y%Line1Text% w%CoordWidth% vFishingY1
Gui, Add, Button, xp+40 y%Line1Set% w%SetButtonWidth% vSetFishing1 gSetFishing, Set
Gui, Add, Text, xp+37 y%Line1% w%DelayLabelWidth% Right vFishingDelayLabel, Delay
Gui, Add, Edit, xp+66 y%Line1Text% w%DelayWidth% vFishingDelay, 0

;Fishing Spot 2
Gui, Add, Checkbox, x%Left% y%Line2% vFishing2 Disabled, Fishing2
Gui, Add, Text, xp+63 y%Line2% w%CoordLabelWidth% vFishingX2Label Disabled, X2
Gui, Add, Edit, xp+20 y%Line2Text% w%CoordWidth% vFishingX2 Disabled
Gui, Add, Text, xp+40 y%Line2% w%CoordLabelWidth% vFishingY2Label Disabled, Y2
Gui, Add, Edit, xp+20 y%Line2Text% w%CoordWidth% vFishingY2 Disabled
Gui, Add, Button, xp+40 y%Line2Set% w%SetButtonWidth% vSetFishing2 gSetFishing Disabled, Set
Gui, Add, Text, xp+37 y%Line2% w%StdLabelWidth% Right vFishingTotalLabel, Total Rods
Gui, Add, Edit, xp+79 y%Line2Text% w%HotkeyWidth% vFishingTotal
;Fishing Rods
Gui, Add, Text, x%Left% y%Line3% w%StdLabelWidth% Right vFishingKey1Label, Fishing Rod 1
Gui, Add, Edit, xp+79 y%Line3Text% w%HotkeyWidth% vFishingKey1
Gui, Add, Text, xp+31 y%Line3% w%StdLabelWidth% Right vFishingKey2Label, Fishing Rod 2
Gui, Add, Edit, xp+79 y%Line3Text% w%HotkeyWidth% vFishingKey2
Gui, Add, Text, xp+31 y%Line3% w%StdLabelWidth% Right vFishingKey3Label, Fishing Rod 3
Gui, Add, Edit, xp+79 y%Line3Text% w%HotkeyWidth% vFishingKey3
Gui, Add, Text, x%Left% y%Line4% w%StdLabelWidth% Right vFishingKey4Label, Fishing Rod 4
Gui, Add, Edit, xp+79 y%Line4Text% w%HotkeyWidth% vFishingKey4
Gui, Add, Text, xp+31 y%Line4% w%StdLabelWidth% Right vFishingKey5Label, Fishing Rod 5
Gui, Add, Edit, xp+79 y%Line4Text% w%HotkeyWidth% vFishingKey5
Gui, Add, Text, xp+31 y%Line4% w%StdLabelWidth% Right vFishingKey6Label, Fishing Rod 6
Gui, Add, Edit, xp+79 y%Line4Text% w%HotkeyWidth% vFishingKey6
Gui, Add, Text, x%Left% y%Line5% w%StdLabelWidth% Right vFishingKey7Label, Fishing Rod 7
Gui, Add, Edit, xp+79 y%Line5Text% w%HotkeyWidth% vFishingKey7
Gui, Add, Text, xp+31 y%Line5% w%StdLabelWidth% Right vFishingKey8Label, Fishing Rod 8
Gui, Add, Edit, xp+79 y%Line5Text% w%HotkeyWidth% vFishingKey8
Gui, Add, Text, xp+31 y%Line5% w%StdLabelWidth% Right vFishingKey9Label, Fishing Rod 9
Gui, Add, Edit, xp+79 y%Line5Text% w%HotkeyWidth% vFishingKey9

;;Offensive Settings
Gui, Tab, Offensive
;Physical
Gui, Add, Checkbox, x%Left% y%Line1% w%CheckBoxWidth% vPhysical, Physical
Gui, Add, Text, xp+110 y%Line1% w%StdLabelWidth% Right vPhysicalKeyLabel, Attack Key
Gui, Add, Edit, xp+79 y%Line1Text% w%HotkeyWidth% vPhysicalKey
Gui, Add, Text, xp+31 y%Line1% w%DelayLabelWidth% Right vPhysicalDurationLabel, Duration
Gui, Add, Edit, xp+66 y%Line1Text% w%DelayWidth% vPhysicalDuration
;Magic
Gui, Add, Checkbox, x%Left% y%Line2% w%CheckBoxWidth% vMagicAtk, Magical
Gui, Add, Text, xp+110 y%Line2% w%StdLabelWidth% Right vMagicAtkKeyLabel, Spell Key
Gui, Add, Edit, xp+79 y%Line2Text% w%HotkeyWidth% vMagicAtkKey
Gui, Add, Dropdownlist, xp+31 y%Line2Text% w%CheckBoxWidth% AltSubmit vMagicAtkTarget, |Self|Current|Last
;Misc
Gui, Add, Checkbox, x%Left% y%Line3% w%CheckBoxWidth% vDoubleTarget, Double Target
Gui, Add, Text, xp+110 y%Line3% w%DelayLabelWidth% Right vOffensiveDelayLabel, Delay
Gui, Add, Edit, xp+66 y%Line3Text% w%DelayWidth% vOffensiveDelay, 0

;;Lockpicking Settings
Gui, Tab, Lockpicking
;Lockpicking
Gui, Add, Checkbox, x%Left% y%Line1% w%CheckBoxWidth% vLockpicking gLockpickingOptions, Lockpicking
Gui, Add, Text, xp+110 y%Line1% w%StdLabelWidth% Right vLockpickKeyLabel, Lockpick Key
Gui, Add, Edit, xp+79 y%Line1Text% w%HotkeyWidth% vLockpickKey
Gui, Add, Text, xp+31 y%Line1% w%DelayLabelWidth% Right vLockpickDelayLabel, Delay
Gui, Add, Edit, xp+66 y%Line1Text% w%DelayWidth% vLockpickDelay, 0
;Locked Box 1
Gui, Add, Text, x%Left% y0 w0
Gui, Add, Text, xp+63 y%Line2% w%CoordLabelWidth% vBox1XLabel, X1
Gui, Add, Edit, xp+20 y%Line2Text% w%CoordWidth% vBox1X
Gui, Add, Text, xp+40 y%Line2% w%CoordLabelWidth% vBox1YLabel, Y1
Gui, Add, Edit, xp+20 y%Line2Text% w%CoordWidth% vBox1Y
Gui, Add, Button, xp+40 y%Line2Set% w%SetButtonWidth% vSetBox1 gSetBox, Set
Gui, Add, Text, xp+37 y%Line2% w%StdLabelWidth% Right vBox1KeyLabel, Box 1 Key
Gui, Add, Edit, xp+79 y%Line2Text% w%HotkeyWidth% vBox1Key

;Locked Box 2
Gui, Add, Checkbox, x%Left% y%Line3% vLockpicking2 Disabled, Box 2
Gui, Add, Text, xp+63 y%Line3% w%CoordLabelWidth% vBox2XLabel Disabled, X2
Gui, Add, Edit, xp+20 y%Line3Text% w%CoordWidth% vBox2X Disabled
Gui, Add, Text, xp+40 y%Line3% w%CoordLabelWidth% vBox2YLabel Disabled, Y2
Gui, Add, Edit, xp+20 y%Line3Text% w%CoordWidth% vBox2Y Disabled
Gui, Add, Button, xp+40 y%Line3Set% w%SetButtonWidth% vSetBox2 gSetBox Disabled, Set
Gui, Add, Text, xp+37 y%Line3% w%StdLabelWidth% Right vBox2KeyLabel, Box 2 Key
Gui, Add, Edit, xp+79 y%Line3Text% w%HotkeyWidth% vBox2Key

Gui, Add, Text, x%Left% y0 w0
Gui, Add, Text, xp+135 y%Line4% w150 Right vLockpickingSensLabel, Tolerance for image searching
Gui, Add, Edit, xp+155 y%Line4Text% w%CoordWidth% HwndHLockpickingSens vLockpickingSens, 100
TT.Attach(HLockpickingSens, "Tolerance for Image Search. Raise if it never matches with the correct charge.bmp. Over 100 is too much")

;;ItemID Settings
Gui, Tab, ItemID
Gui, Add, Checkbox, x%Left% y%Line1% vItemID gItemIDOptions, Item ID
;Top left corner
Gui, Add, Text, xp+58 y%Line1% w64 Right vItemIDSourceTLXLabel, Top Left X
Gui, Add, Edit, xp+77 y%Line1Text% w%CoordWidth% vItemIDSourceTLX
Gui, Add, Text, xp+40 y%Line1% w64 Right vItemIDSourceTLYLabel, Top Left Y
Gui, Add, Edit, xp+77 y%Line1Text% w%CoordWidth% vItemIDSourceTLY
Gui, Add, Button, xp+40 y%Line1Set% w%SetButtonWidth% vSetItemIDSourceTL gSetItemID, Set
;Bottom right corner
Gui, Add, Text, x%Left% y0 w0
Gui, Add, Text, xp+58 y%Line2% w72 Right vItemIDSourceBRXLabel, Bottom Right X
Gui, Add, Edit, xp+77 y%Line2Text% w%CoordWidth% vItemIDSourceBRX
Gui, Add, Text, xp+40 y%Line2% w72 Right vItemIDSourceBRYLabel, Bottom Right Y
Gui, Add, Edit, xp+77 y%Line2Text% w%CoordWidth% vItemIDSourceBRY
Gui, Add, Button, xp+40 y%Line2Set% w%SetButtonWidth% vSetItemIDSourceBR gSetItemID, Set
;Container
Gui, Add, Text, x%Left% y0 w0
Gui, Add, Text, xp+58 y%Line3% w64 Right vItemIDContainerXLabel, Container X
Gui, Add, Edit, xp+77 y%Line3Text% w%CoordWidth% vItemIDContainerX
Gui, Add, Text, xp+40 y%Line3% w64 Right vItemIDContainerYLabel, Container Y
Gui, Add, Edit, xp+77 y%Line3Text% w%CoordWidth% vItemIDContainerY
Gui, Add, Button, xp+40 y%Line3Set% w%SetButtonWidth% vSetItemIDContainerT gSetItemID, Set
;Glass
Gui, Add, Text, x%Left% y%Line4% w80 Right vGlassKeyLabel, Magnifying Glass
Gui, Add, Edit, xp+85 y%Line4Text% w%HotkeyWidth% vGlassKey
Gui, Add, Text, xp+50 y%Line4% w150 Right vItemIDSensLabel, Tolerance for image searching
Gui, Add, Edit, xp+155 y%Line4Text% w%CoordWidth% HwndHItemIDSens vItemIDSens, 100
TT.Attach(HItemIDSens, "Tolerance for Image Search. Raise if it never matches with the correct unidentifed.bmp. Over 100 is too much")
;Delay
Gui, Add, Text, x%Left% y%Line5% w%DelayLabelWidth% Right vItemIDDelayLabel, Delay
Gui, Add, Edit, xp+72 y%Line5Text% w%DelayWidth% vItemIDDelay

;;Harvesting Settings
Gui, Tab, Harvesting
Gui, Add, Text, x%Left% y0 w0
Gui, Add, Button, xp+60 y%Line1Set% w200 vAddSpotTab gAddSpotTab, Add a new harvesting spot
Gui, Add, Text, x%Left% y0 w0
Gui, Add, Checkbox, x%Left% y%Line2% vSurvey, Survey
Gui, Add, Text, xp+25 y%Line2% w200 Right vSurveyLabel, Survey tool
Gui, Add, Edit, xp+205 y%Line2Text% w50 vSurveyKey
Gui, Add, Text, x%Left% y0 w0
Gui, Add, Button, xp+60 y%Line3Set% w200 vRemoveSpotTab gRemoveSpotTab, Remove last harvesting spot
Gui, Add, Text, x%Left% y0 w0
Gui, Add, Text, xp+25 y%Line4% w200 Right vHarvestSensLabel, Tolerance for image searching
Gui, Add, Edit, xp+205 y%Line4Text% w%DelayWidth% HwndHHarvestSens vHarvestSens, 50
TT.Attach(HHarvestSens, "Tolerance for Image Search. Raise if it never matches with the correct charge.bmp. Over 100 is too much")
Gui, Add, Text, x%Left% y0 w0
Gui, Add, Text, xp+25 y%Line5% w200 Right vHarvestingRoutineDelayLabel, Delay between two harvesting spots
Gui, Add, Edit, xp+205 y%Line5Text% w%DelayWidth% vHarvestingRoutineDelay, 0
Loop, %MaxSpots%
{
	Gui, Tab, Spot%A_Index%
	;Tool and Rune
	Gui, Add, Checkbox, x%Left% y%Line1% vSpot%A_Index%Active, Harvest this spot
	Gui, Add, Text, xp+110 y%Line1% w%StdLabelWidth% Right vSpot%A_Index%ToolLabel, Tool Key
	Gui, Add, Edit, xp+79 y%Line1Text% w%HotkeyWidth% vSpot%A_Index%ToolKey
	Gui, Add, Text, xp+31 y%Line1% w%StdLabelWidth% Right vSpot%A_Index%RuneKeyLabel, Rune Key
	Gui, Add, Edit, xp+79 y%Line1Text% w%HotkeyWidth% vSpot%A_Index%RuneKey
	Gui, Add, Text, x%Left% y0 w0
	Gui, Add, Text, xp+110 y%Line2% w%StdLabelWidth% Right vSpot%A_Index%ScrollLabel, Recall Scroll
	Gui, Add, Edit, xp+79 y%Line2Text% w%HotkeyWidth% vSpot%A_Index%ScrollKey
	Gui, Add, Checkbox, xp+31 y%Line2% vSpot%A_Index%Scroll, Use Scroll

	;Target 1
	Gui, Add, Text, x%Left% y%Line3% w%CoordLabelWidth% vSpot%A_Index%X1Label, X1
	Gui, Add, Edit, xp+20 y%Line3Text% w%CoordWidth% vSpot%A_Index%X1
	Gui, Add, Text, xp+40 y%Line3% w%CoordLabelWidth% vSpot%A_Index%Y1Label, Y1
	Gui, Add, Edit, xp+20 y%Line3Text% w%CoordWidth% vSpot%A_Index%Y1
	Gui, Add, Button, xp+40 y%Line3Set% w%SetButtonWidth% vSetSpot%A_Index%Target1 gSetSpotTarget, Set
	;Target 2
	Gui, Add, Text, xp+52 y%Line3% w%CoordLabelWidth% vSpot%A_Index%X2Label, X2
	Gui, Add, Edit, xp+20 y%Line3Text% w%CoordWidth% vSpot%A_Index%X2
	Gui, Add, Text, xp+40 y%Line3% w%CoordLabelWidth% vSpot%A_Index%Y2Label, Y2
	Gui, Add, Edit, xp+20 y%Line3Text% w%CoordWidth% vSpot%A_Index%Y2
	Gui, Add, Button, xp+40 y%Line3Set% w%SetButtonWidth% vSetSpot%A_Index%Target2 gSetSpotTarget, Set
	;Target 3
	Gui, Add, Text, x%Left% y%Line4% w%CoordLabelWidth% vSpot%A_Index%X3Label, X3
	Gui, Add, Edit, xp+20 y%Line4Text% w%CoordWidth% vSpot%A_Index%X3
	Gui, Add, Text, xp+40 y%Line4% w%CoordLabelWidth% vSpot%A_Index%Y3Label, Y3
	Gui, Add, Edit, xp+20 y%Line4Text% w%CoordWidth% vSpot%A_Index%Y3
	Gui, Add, Button, xp+40 y%Line4Set% w%SetButtonWidth% vSetSpot%A_Index%Target3 gSetSpotTarget, Set
	;Target 4
	Gui, Add, Text, xp+52 y%Line4% w%CoordLabelWidth% vSpot%A_Index%X4Label, X4
	Gui, Add, Edit, xp+20 y%Line4Text% w%CoordWidth% vSpot%A_Index%X4
	Gui, Add, Text, xp+40 y%Line4% w%CoordLabelWidth% vSpot%A_Index%Y4Label, Y4
	Gui, Add, Edit, xp+20 y%Line4Text% w%CoordWidth% vSpot%A_Index%Y4
	Gui, Add, Button, xp+40 y%Line4Set% w%SetButtonWidth% vSetSpot%A_Index%Target4 gSetSpotTarget, Set
	;Target 5
	Gui, Add, Text, x%Left% y%Line5% w%CoordLabelWidth% vSpot%A_Index%X5Label, X5
	Gui, Add, Edit, xp+20 y%Line5Text% w%CoordWidth% vSpot%A_Index%X5
	Gui, Add, Text, xp+40 y%Line5% w%CoordLabelWidth% vSpot%A_Index%Y5Label, Y5
	Gui, Add, Edit, xp+20 y%Line5Text% w%CoordWidth% vSpot%A_Index%Y5
	Gui, Add, Button, xp+40 y%Line5Set% w%SetButtonWidth% vSetSpot%A_Index%Target5 gSetSpotTarget, Set
	;Target 6
	Gui, Add, Text, xp+52 y%Line5% w%CoordLabelWidth% vSpot%A_Index%X6Label, X6
	Gui, Add, Edit, xp+20 y%Line5Text% w%CoordWidth% vSpot%A_Index%X6
	Gui, Add, Text, xp+40 y%Line5% w%CoordLabelWidth% vSpot%A_Index%Y6Label, Y6
	Gui, Add, Edit, xp+20 y%Line5Text% w%CoordWidth% vSpot%A_Index%Y6
	Gui, Add, Button, xp+40 y%Line5Set% w%SetButtonWidth% vSetSpot%A_Index%Target6 gSetSpotTarget, Set
}

;;Custom Settings
Gui, Tab, Custom
Gui, Add, Text, x%Left% y0 w0
Gui, Add, Button, xp+60 y%Line1Set% w200 vAddCustomTab gAddCustomTab, Add a new custom routine
Gui, Add, Button, xp y%Line3Set% w200 vRemoveCustomTab gRemoveCustomTab, Remove last custom routine
Gui, Add, Text, x%Left% y0 w0
Gui, Add, Text, xp+25 y%Line5% w200 Right vCustomRoutineDelayLabel, Delay between two custom routines
Gui, Add, Edit, xp+205 y%Line5Text% w%DelayWidth% vCustomRoutineDelay, 0

Loop, %MaxCustom%
{
	Gui, Tab, Custom%A_Index%
	;Custom basics
	Gui, Add, Checkbox, x%Left% y%Line1% w%CheckBoxWidth% vCustom%A_Index%Active, Custom
	Gui, Add, Text, xp+110 y%Line1% w%StdLabelWidth% Right vCustom%A_Index%KeyLabel, Skill Hotkey
	Gui, Add, Edit, xp+79 y%Line1Text% w%HotkeyWidth% vCustom%A_Index%Key
	Gui, Add, Dropdownlist, xp+31 y%Line1Text% w%CheckBoxWidth% AltSubmit vCustom%A_Index%Target, |Self|Current|Last|Last Object

	;Checkbox and double mouse click coords
	Gui, Add, Checkbox, x%Left% y%Line2% vCustom%A_Index%CoordsItem, Use Coords
	Gui, Add, Text, xp+172 y%Line2% w%CoordLabelWidth% vCustom%A_Index%CoordsItemXLabel, X
	Gui, Add, Edit, xp+20 y%Line2Text% w%CoordWidth% vCustom%A_Index%CoordsItemX
	Gui, Add, Text, xp+40 y%Line2% w%CoordLabelWidth% vCustom%A_Index%CoordsItemYLabel, Y
	Gui, Add, Edit, xp+20 y%Line2Text% w%CoordWidth% vCustom%A_Index%CoordsItemY
	Gui, Add, Button, xp+40 y%Line2Set% w%SetButtonWidth% vSetCustom%A_Index%CoordsItem gSetCustomCoordsItem, Set

	;Checkbox and double mouse click coords
	Gui, Add, Checkbox, x%Left% y%Line3% vCustom%A_Index%CoordsTarget, Target Coords
	Gui, Add, Text, xp+172 y%Line3% w%CoordLabelWidth% vCustom%A_Index%CoordsTargetXLabel, X
	Gui, Add, Edit, xp+20 y%Line3Text% w%CoordWidth% vCustom%A_Index%CoordsTargetX
	Gui, Add, Text, xp+40 y%Line3% w%CoordLabelWidth% vCustom%A_Index%CoordsTargetYLabel, Y
	Gui, Add, Edit, xp+20 y%Line3Text% w%CoordWidth% vCustom%A_Index%CoordsTargetY
	Gui, Add, Button, xp+40 y%Line3Set% w%SetButtonWidth% vSetCustom%A_Index%CoordsTarget gSetCustomCoordsTarget, Set

	;Checkbox and right mouse click coords
	Gui, Add, Checkbox, x%Left% y%Line4% vCustom%A_Index%CoordsRight, Right Click Coords
	Gui, Add, Text, xp+172 y%Line4% w%CoordLabelWidth% vCustom%A_Index%CoordsRightXLabel, X
	Gui, Add, Edit, xp+20 y%Line4Text% w%CoordWidth% vCustom%A_Index%CoordsRightX
	Gui, Add, Text, xp+40 y%Line4% w%CoordLabelWidth% vCustom%A_Index%CoordsRightYLabel, Y
	Gui, Add, Edit, xp+20 y%Line4Text% w%CoordWidth% vCustom%A_Index%CoordsRightY
	Gui, Add, Button, xp+40 y%Line4Set% w%SetButtonWidth% vSetCustom%A_Index%CoordsRight gSetCustomCoordsRight, Set

	;Delay After Using key
	Gui, Add, Text, x%Left% y%Line5% w%DelayLabelWidth% Right vCustom%A_Index%PreDelayLabel, Pre Delay
	Gui, Add, Edit, xp+72 y%Line5Text% w%DelayWidth% vCustom%A_Index%PreDelay
	Gui, Add, Text, xp+148 y%Line5% w%DelayLabelWidth% Right vCustom%A_Index%PostDelayLabel, Post Delay
	Gui, Add, Edit, xp+66 y%Line5Text% w%DelayWidth% vCustom%A_Index%PostDelay
}

;;Custom Keys
Gui, Tab, CustomKeys
Gui, Add, Text, x%Left% y0 w0
Gui, Add, Button, xp+60 y%Line1Set% w200 vAddCustomKeysTab gAddCustomKeysTab, Add a new custom hotkeys page
Gui, Add, Button, xp y%Line3Set% w200 vRemoveCustomKeysTab gRemoveCustomKeysTab, Remove last custom hotkeys page
Loop, %MaxCustomKeys%
{
	Gui, Tab, CustomKeys%A_Index%

	Gui, Add, Text, x%Left% y0 w0
	Gui, Add, Text, xp+20 y%Line1% w84 Right vCustomKeys%A_Index%Key1IngameLabel, In Game Hotkey
	Gui, Add, Edit, xp+89 y%Line1Text% w%HotkeyWidth% vCustomKeys%A_Index%Key1InGame
	Gui, Add, Text, xp+31 y%Line1% w80 Right vCustomKeys%A_Index%Key1Label, New Hotkey
	Gui, Add, Dropdownlist, xp+85 y%Line1Text% w45 AltSubmit vCustomKeys%A_Index%Key1Mod, |Alt|Ctrl|Shift
	Gui, Add, Edit, xp+55 y%Line1Text% w%HotkeyWidth% vCustomKeys%A_Index%Key1

	Gui, Add, Text, x%Left% y0 w0
	Gui, Add, Text, xp+20 y%Line2% w84 Right vCustomKeys%A_Index%Key2IngameLabel, In Game Hotkey
	Gui, Add, Edit, xp+89 y%Line2Text% w%HotkeyWidth% vCustomKeys%A_Index%Key2InGame
	Gui, Add, Text, xp+31 y%Line2% w80 Right vCustomKeys%A_Index%Key2Label, New Hotkey
	Gui, Add, Dropdownlist, xp+85 y%Line2Text% w45 AltSubmit vCustomKeys%A_Index%Key2Mod, |Alt|Ctrl|Shift
	Gui, Add, Edit, xp+55 y%Line2Text% w%HotkeyWidth% vCustomKeys%A_Index%Key2

	Gui, Add, Text, x%Left% y0 w0
	Gui, Add, Text, xp+20 y%Line3% w84 Right vCustomKeys%A_Index%Key3IngameLabel, In Game Hotkey
	Gui, Add, Edit, xp+89 y%Line3Text% w%HotkeyWidth% vCustomKeys%A_Index%Key3InGame
	Gui, Add, Text, xp+31 y%Line3% w80 Right vCustomKeys%A_Index%Key3Label, New Hotkey
	Gui, Add, Dropdownlist, xp+85 y%Line3Text% w45 AltSubmit vCustomKeys%A_Index%Key3Mod, |Alt|Ctrl|Shift
	Gui, Add, Edit, xp+55 y%Line3Text% w%HotkeyWidth% vCustomKeys%A_Index%Key3

	Gui, Add, Text, x%Left% y0 w0
	Gui, Add, Text, xp+20 y%Line4% w84 Right vCustomKeys%A_Index%Key4IngameLabel, In Game Hotkey
	Gui, Add, Edit, xp+89 y%Line4Text% w%HotkeyWidth% vCustomKeys%A_Index%Key4InGame
	Gui, Add, Text, xp+31 y%Line4% w80 Right vCustomKeys%A_Index%Key4Label, New Hotkey
	Gui, Add, Dropdownlist, xp+85 y%Line4Text% w45 AltSubmit vCustomKeys%A_Index%Key4Mod, |Alt|Ctrl|Shift
	Gui, Add, Edit, xp+55 y%Line4Text% w%HotkeyWidth% vCustomKeys%A_Index%Key4

	Gui, Add, Text, x%Left% y0 w0
	Gui, Add, Text, xp+20 y%Line5% w84 Right vCustomKeys%A_Index%Key5IngameLabel, In Game Hotkey
	Gui, Add, Edit, xp+89 y%Line5Text% w%HotkeyWidth% vCustomKeys%A_Index%Key5InGame
	Gui, Add, Text, xp+31 y%Line5% w80 Right vCustomKeys%A_Index%Key5Label, New Hotkey
	Gui, Add, Dropdownlist, xp+85 y%Line5Text% w45 AltSubmit vCustomKeys%A_Index%Key5Mod, |Alt|Ctrl|Shift
	Gui, Add, Edit, xp+55 y%Line5Text% w%HotkeyWidth% vCustomKeys%A_Index%Key5
}
;;ItemTransfer Settings
Gui, Tab, ItemTransfer
Gui, Add, Checkbox, x%Left% y%Line1% vItemTransfer, Item Transfer
;Item transfer cycles to run
Gui, Add, Text, xp+85 y%Line1% w30 Right vMoveCycleCountLabel, Move cycles
Gui, Add, Edit, xp+50 y%Line1% w30 vMoveCycleCount
;Move/drag FROM list location
Gui, Add, Text, x%Left% y0 w0
Gui, Add, Text, xp+58 y%Line2% w64 Right vMoveFromXLabel, Move From X
Gui, Add, Edit, xp+77 y%Line2Text% w%CoordWidth% vMoveFromX
Gui, Add, Text, xp+40 y%Line2% w64 Right vMoveFromYLabel, Move From Y
Gui, Add, Edit, xp+77 y%Line2Text% w%CoordWidth% vMoveFromY
Gui, Add, Button, xp+40 y%Line2Set% w%SetButtonWidth% vSetMoveF gSetMove, Set
;Move/drag TO location
Gui, Add, Text, x%Left% y0 w0
Gui, Add, Text, xp+58 y%Line3% w64 Right vMoveToXLabel, Move To X
Gui, Add, Edit, xp+77 y%Line3Text% w%CoordWidth% vMoveToX
Gui, Add, Text, xp+40 y%Line3% w64 Right vMoveToYLabel, Move To Y
Gui, Add, Edit, xp+77 y%Line3Text% w%CoordWidth% vMoveToY
Gui, Add, Button, xp+40 y%Line3Set% w%SetButtonWidth% vSetMoveT gSetMove, Set
;Inside or outside main loop
Gui, Add, Text, x%Left% y0 w0
Gui, Add, Checkbox, x%Left% y%Line4% vItemTransferBreak, Stop After Running

Gui, Tab
;Routine indicator
Gui,Add,Text, cGreen x%Left% y%SelectionHeight% w190 Center vRoutine Hidden, Doing Stuff
;Loops indicator
Gui,Add,Text, cRed xp+20 yp+20 vLoopCounterLabel Hidden, Loops:
Gui,Add,Text, cRed xp+40 yp w%CoordWidth% Hidden vLoopCounter, 0
;Relogs indicator
Gui,Add,Text, cRed xp+40 yp Hidden vRelogCounterLabel, Relogs:
Gui,Add,Text, cRed xp+45 yp w20 Hidden vRelogCounter, 0
;Start/Stop
Gui,Font,Bold
Gui,Add,Button, xp+55 yp-19 w60 h30 vSave gSave, Save
Gui,Add,Button, xp+70 yp w60 h30 vMainGo gMainLoop, Start
Gui,Add,Button, xp yp w60 h30 Hidden vMainStop gStop, Stop
Gui,Font,Norm

;Get the configs list
GoSub, GetConfigs
;Seleft the one from config.ini
GuiControl,choose,LoadedConfig,%UserConfig%
;Load config settings
GoSub, LoadConfig
;Adjust gui settings
GoSub, AdjustGui

; Start GUI
Gui, Show , , %guiname%
return

TVLABEL:
	if (A_GuiEvent == "Normal")
	{
		if (A_EventInfo == P1)
		{
			GuiControl,, OptionTitle, General Settings
			GuiControl, choose, TabsList, General
		}
		else if (A_EventInfo == P2)
		{
			GuiControl,, OptionTitle, General Hotkey Settings
			GuiControl, choose, TabsList, GeneralKeys
		}
		else if (A_EventInfo == P3)
		{
			GuiControl,, OptionTitle, Taming Settings
			GuiControl, choose, TabsList, Taming
		}
		else if (A_EventInfo == P4)
		{
			GuiControl,, OptionTitle, Music Settings
			GuiControl, choose, TabsList, Music
		}
		else if (A_EventInfo == P5)
		{
			GuiControl,, OptionTitle, Healing Settings
			GuiControl, choose, TabsList, Healing
		}
		else if (A_EventInfo == P6)
		{
			GuiControl,, OptionTitle, Hiding Settings
			GuiControl, choose, TabsList, Hiding
		}
		else if (A_EventInfo == P7)
		{
			GuiControl,, OptionTitle, Fishing Settings
			GuiControl, choose, TabsList, Fishing
		}
		else if (A_EventInfo == P8)
		{
			GuiControl,, OptionTitle, Offensive Settings
			GuiControl, choose, TabsList, Offensive
		}
		else if (A_EventInfo == P9)
		{
			GuiControl,, OptionTitle, Lockpicking Settings
			GuiControl, choose, TabsList, Lockpicking
		}
		else if (A_EventInfo == P10)
		{
			GuiControl,, OptionTitle, Item ID Settings
			GuiControl, choose, TabsList, ItemID
		}
		else if (A_EventInfo == P11)
		{
			GuiControl,, OptionTitle, Harvesting Settings
			GuiControl, choose, TabsList, Harvesting
		}
		else if (A_EventInfo == P12)
		{
			GuiControl,, OptionTitle, Custom Settings
			GuiControl, choose, TabsList, Custom
		}
		else if (A_EventInfo == P13)
		{
			GuiControl,, OptionTitle, Custom Hotkeys Settings
			GuiControl, choose, TabsList, CustomKeys
		}
		else if (A_EventInfo == P14)
		{
			GuiControl,, OptionTitle, Item Transfer
			GuiControl, choose, TabsList, ItemTransfer
		}
		Loop, %MaxSpots%
		{
			if (A_EventInfo == P11C%A_Index%)
			{
				GuiControl,, OptionTitle, Harvesting Spot %A_Index% Settings
				GuiControl, choose, TabsList, Spot%A_Index%
			}
		}

		Loop, %MaxCustom%
		{
			if (A_EventInfo == P12C%A_Index%)
			{
				GuiControl,, OptionTitle, Custom Routine %A_Index% Settings
				GuiControl, choose, TabsList, Custom%A_Index%
			}
		}

		Loop, %MaxCustomKeys%
		{
			if (A_EventInfo == P13C%A_Index%)
			{
				GuiControl,, OptionTitle, Custom Hotkeys Page %A_Index%
				GuiControl, choose, TabsList, CustomKeys%A_Index%
			}
		}
	}
return

GETCONFIGS:
   ItemList := ""

   Loop, *.ini
   {
		if (A_LoopFileName != "config.ini")
		{
			FilePath := A_LoopFileLongPath
			StringSplit, Item, A_LoopReadLine, .
			ItemList .= A_LoopFileName . Seperator . FilePath . "`n"
		}
   }
   StringTrimRight, ItemList, ItemList, 1
   Sort, ItemList
   ConfigIndex := 0
   Loop, Parse, ItemList, `n
   {
		StringSplit, Item, A_LoopField, %Seperator%
		GuiControl, , LoadedConfig, %Item1%
		ConfigIndex += 1
		Configs%ConfigIndex% := Item1
   }

   ItemList := ""
   ; GuiControl, Choose, PFL, 1
Return

LOADCONFIGRELOAD:
	gosub, LoadConfig
	Reload
return

LOADCONFIG:
	Gui, Submit, NoHide
	UserConfig := Configs%LoadedConfig%
	;Load gui config
	Loop, parse, GuiSettingsList, `,
	{
		IniRead, %A_LoopField%, %UserConfig%, GuiSettings, % A_LoopField
		guicontrol,,%A_LoopField%,% %A_LoopField%
	}

	Loop, parse, GuiDPSettingsList, `,
	{
		IniRead, %A_LoopField%, %UserConfig%, GuiSettings, % A_LoopField
		guicontrol,choose,%A_LoopField%,% %A_LoopField%
	}

	;Load hotkeys config
	Loop, parse, GuiHotkeysList, `,
	{
		IniRead, %A_LoopField%, %UserConfig%, Hotkeys, % A_LoopField
		guicontrol,,%A_LoopField%,% %A_LoopField%
	}

	;Register hotkeys
	try
	{
		Hotkey,%StopKey%,Stop
		Hotkey,%StartKey%,Start
		Loop, %MaxCustomKeys%
		{
			i := 1
			while (i < 6)
			{
				if CustomKeys%A_Index%Key%i%Mod = 2
					CustomModifier := "!"
				else if CustomKeys%A_Index%Key%i%Mod = 3
					CustomModifier := "^"
				else if CustomKeys%A_Index%Key%i%Mod = 4
					CustomModifier := "+"
				CustomHotkey := CustomModifier . CustomKeys%A_Index%Key%i%
				;Hotkey,%customHotkey%,CustomKeys%A_Index%Key%i%Routine
				Hotkey,%CustomHotkey%,CUSTOMKEYSROUTINE
				i++
			}
		}
	}

	;Save loaded config
	IniWrite, %LoadedConfig%, config.ini, ConfigSetting, UserConfig
return

Loop, %MaxCustomKeys%
{
	i := 1
	while (i < 6)
	{
		CustomKeys%A_Index%Key%i%Routine:
			MsgBox, Pushed
		return
		i++
	}
}

ADJUSTGUI:
	;Adjust Gui according to config values
	if (OnTop)
		Gui,+AlwaysOnTop

	if (!Taming)
		GuiControl, Disable, Release
	else
		GuiControl, Enable, Release

	if (Music)
	{
		GuiControl, Disable, Provo
		GuiControl, Disable, Peace
		GuiControl, Disable, Discord
	}
	else if (Provo)
	{
		GuiControl, Disable, Music
		GuiControl, Disable, Peace
		GuiControl, Disable, Discord
	}
	else if (Peace)
	{
		GuiControl, Disable, Provo
		GuiControl, Disable, Music
		GuiControl, Disable, Discord
	}
	else if (Discord)
	{
		GuiControl, Disable, Provo
		GuiControl, Disable, Peace
		GuiControl, Disable, Music
	}

	if (Hiding)
		GuiControl, Enable, Stealth

	if (!Fishing) {
		Loop, parse, FishingOptionsList, `,
			GuiControl, Disable, %A_LoopField%
	}
	else
	{
		Loop, parse, FishingOptionsList, `,
			GuiControl, Enable, %A_LoopField%
	}

	if (!Lockpicking) {
		Loop, parse, LockpickingOptionsList, `,
			GuiControl, Disable, %A_LoopField%
	}
	else
	{
		Loop, parse, LockpickingOptionsList, `,
			GuiControl, Enable, %A_LoopField%
	}

	SetKeyDelay,%KeyDelay%
return

STOP:
	Gui, Submit, NoHide
	breakvar := 1
return

SAVE:
	Gui, Submit, NoHide
	;Save gui config
	Loop, parse, GuiSettingsList, `,
		IniWrite, % %A_LoopField%, %UserConfig%, GuiSettings, % A_LoopField
	Loop, parse, GuiDPSettingsList, `,
		IniWrite, % %A_LoopField%, %UserConfig%, GuiSettings, % A_LoopField
	;Save hotkeys config
	Loop, parse, GuiHotkeysList, `,
		IniWrite, % %A_LoopField%, %UserConfig%, Hotkeys, % A_LoopField
return

ONTOP:
	Gui, Submit, NoHide
	if (OnTop)
		Gui,+AlwaysOnTop
	else
		Gui,-AlwaysOnTop
return

SETNAME:
	Gui, Submit, NoHide
	WinSetTitle, %FromName%, , %WinName%
	if ErrorLevel = 1
	{
		MsgBox, Can't rename %FromName% to %WinName%
		return
	}
	MsgBox, Client Window renamed to %WinName%
return

TAMINGOPTIONS:
	Gui, Submit, NoHide
	if (Taming)
		GuiControl, Enable, Release
	else
	{
		Release = 0
		guicontrol,,Release,0
		GuiControl, Disable, Release
	}
return

RELEASEOPTIONS:
	Gui, Submit, NoHide
	if (Release)
	{
		if (!FileExist("release.bmp"))
		{
			MsgBox release.bmp is missing. You need to create it as per the wiki
			Release = 0
			guicontrol,,Release,0
			return
		}
	}
return

MUSICOPTIONS:
	Gui, Submit, NoHide
	if (Music)
	{
		Provo = 0
		Peace = 0
		Discord = 0
		guicontrol,,Provo,0
		guicontrol,,Peace,0
		guicontrol,,Discord,0
		GuiControl, Disable, Provo
		GuiControl, Disable, Peace
		GuiControl, Disable, Discord

	}
	else if (Provo) {
		Music = 0
		Peace = 0
		Discord = 0
		guicontrol,,Music,0
		guicontrol,,Peace,0
		guicontrol,,Discord,0
		GuiControl, Disable, Music
		GuiControl, Disable, Peace
		GuiControl, Disable, Discord
	}
	else if (Peace) {
		Music = 0
		Provo = 0
		Discord = 0
		guicontrol,,Music,0
		guicontrol,,Provo,0
		guicontrol,,Discord,0
		GuiControl, Disable, Music
		GuiControl, Disable, Provo
		GuiControl, Disable, Discord
	}
	else if (Discord) {
		Music = 0
		Provo = 0
		Peace = 0
		guicontrol,,Music,0
		guicontrol,,Provo,0
		guicontrol,,Peace,0
		GuiControl, Disable, Music
		GuiControl, Disable, Provo
		GuiControl, Disable, Peace
	}
	else
	{
		GuiControl, Enable, Music
		GuiControl, Enable, Provo
		GuiControl, Enable, Peace
		GuiControl, Enable, Discord
	}
return

HIDINGOPTIONS:
	Gui, Submit, NoHide
	if (Hiding)
		GuiControl, Enable, Stealth
	else
	{
		Stealth = 0
		guicontrol,,Stealth,0
		GuiControl, Disable, Stealth
	}
return

FISHINGOPTIONS:
	Gui, Submit, NoHide
	if (Fishing)
	{
		Loop, parse, FishingOptionsList, `,
			GuiControl, Enable, %A_LoopField%
	}
	else
	{
		Fishing2 = 0
		GuiControl,,Fishing2,0
		Loop, parse, FishingOptionsList, `,
		{
			GuiControl, Disable, %A_LoopField%
		}
	}
return

SETFISHING:
	StringRight, TargetNum, A_GuiControl, 1
	XCoord = FishingX%TargetNum%
	YCoord = FishingY%TargetNum%
	SetGuiCoords(XCoord,YCoord,WinName)
return

LOCKPICKINGOPTIONS:
	Gui, Submit, NoHide
	if (Lockpicking)
	{
		if (!FileExist("charge.bmp"))
		{
			MsgBox charge.bmp is missing. You need to create it as per the wiki
			Lockpicking = 0
			guicontrol,,Lockpicking,0
			return
		}
		Loop, parse, LockpickingOptionsList, `,
			GuiControl, Enable, %A_LoopField%
	}
	else
	{
		Lockpicking2 = 0
		GuiControl,,Lockpicking2,0
		Loop, parse, LockpickingOptionsList, `,
		{
			GuiControl, Disable, %A_LoopField%
		}
	}
return

SETBOX:
	StringRight, TargetNum, A_GuiControl, 1
	XCoord = Box%TargetNum%X
	YCoord = Box%TargetNum%Y
	SetGuiCoords(XCoord,YCoord,WinName)
return

ITEMIDOPTIONS:
	if (!FileExist("unidentified.bmp"))
	{
		MsgBox unidentified.bmp is missing. You need to create it as per the wiki
		ItemID = 0
		guicontrol,,ItemID,0
		return
	}

SETITEMID:
	StringRight, CoordType, A_GuiControl, 1
	if (CoordType = "L")
		SetGuiCoords("ItemIDSourceTLX","ItemIDSourceTLY",WinName)
	else if (CoordType = "R")
		SetGuiCoords("ItemIDSourceBRX","ItemIDSourceBRY",WinName)
	else if (CoordType = "T")
		SetGuiCoords("ItemIDContainerX","ItemIDContainerY",WinName)
return

SETMOVE:
	StringRight, CoordType, A_GuiControl, 1
	if (CoordType = "F")
		SetGuiCoords("MoveFromX","MoveFromY",WinName)
	else if (CoordType = "T")
		SetGuiCoords("MoveToX","MoveToY",WinName)
return

ADDCUSTOMTAB:
	if (MaxCustom = 50)
	{
		MsgBox, Max Tab limit reached. Remove a custom routine.
		return
	}
	MaxCustom++

	MsgBox, 4, Add Custom Tab, This will add a new custom routine, confirm?
	IfMsgBox Yes
	{
		;Write our new MaxCustom in config.ini
		IniWrite, %MaxCustom%, %UserConfig%, GuiSettings, MaxCustom
		;Save new custom tab default values
		IniWrite, 0, %UserConfig%, GuiSettings, Custom%MaxCustom%Active
		IniWrite, 0, %UserConfig%, GuiSettings, Custom%MaxCustom%CoordsItem
		IniWrite, 0, %UserConfig%, GuiSettings, Custom%MaxCustom%CoordsTarget
		IniWrite, 0, %UserConfig%, GuiSettings, Custom%MaxCustom%CoordsRight
		IniWrite, 0, %UserConfig%, GuiSettings, Custom%MaxCustom%CoordsItemX
		IniWrite, 0, %UserConfig%, GuiSettings, Custom%MaxCustom%CoordsItemY
		IniWrite, 0, %UserConfig%, GuiSettings, Custom%MaxCustom%CoordsTargetX
		IniWrite, 0, %UserConfig%, GuiSettings, Custom%MaxCustom%CoordsTargetY
		IniWrite, 0, %UserConfig%, GuiSettings, Custom%MaxCustom%CoordsRightX
		IniWrite, 0, %UserConfig%, GuiSettings, Custom%MaxCustom%CoordsRightY
		IniWrite, 0, %UserConfig%, GuiSettings, Custom%MaxCustom%PreDelay
		IniWrite, 0, %UserConfig%, GuiSettings, Custom%MaxCustom%PostDelay
		IniWrite, % "", %UserConfig%, GuiSettings, Custom%MaxCustom%Target
		IniWrite, % "", %UserConfig%, Hotkeys, Custom%MaxCustom%Key
		Reload
	}
return

REMOVECUSTOMTAB:
	If (MaxCustom = 0)
	{
		MsgBox, No custom routine to remove
	}
	else
	{
		MaxCustom--
		MsgBox, 4, Remove Custom Tab, This will remove the last custom routine on the list, confirm?
		IfMsgBox Yes
		{
			IniWrite, %MaxCustom%, %UserConfig%, GuiSettings, MaxCustom
			Reload
		}
	}
return

SETCUSTOMCOORDSITEM:
	RegExMatch(A_GuiControl, "O)SetCustom(?<m1>\d+)", CustomNumTemp)
	CustomNum := CustomNumTemp["m1"]
	XCoord = Custom%CustomNum%CoordsItemX
	YCoord = Custom%CustomNum%CoordsItemY
	SetGuiCoords(XCoord,YCoord,WinName)
return

SETCUSTOMCOORDSTARGET:
	RegExMatch(A_GuiControl, "O)SetCustom(?<m1>\d+)", CustomNumTemp)
	CustomNum := CustomNumTemp["m1"]
	XCoord = Custom%CustomNum%CoordsTargetX
	YCoord = Custom%CustomNum%CoordsTargetY
	SetGuiCoords(XCoord,YCoord,WinName)
return

SETCUSTOMCOORDSRIGHT:
	RegExMatch(A_GuiControl, "O)SetCustom(?<m1>\d+)", CustomNumTemp)
	CustomNum := CustomNumTemp["m1"]
	XCoord = Custom%CustomNum%CoordsRightX
	YCoord = Custom%CustomNum%CoordsRightY
	SetGuiCoords(XCoord,YCoord,WinName)
return

ADDSPOTTAB:
	if (!FileExist("charge.bmp"))
		{
			MsgBox charge.bmp is missing. You need to create it as per the wiki
			return
		}

	if (MaxSpots = 50)
		{
			MsgBox, Max Tab limit reached. Remove a harvesting spot.
			return
		}
	MaxSpots++
	MsgBox, 4, Add Harvesting Tab, This will add a new harvesting spot, confirm?
	IfMsgBox Yes
	{
		;Write our new MaxCustom in config.ini
		IniWrite, %MaxSpots%, %UserConfig%, GuiSettings, MaxSpots
		;Save new custom tab default values
		IniWrite, 0, %UserConfig%, GuiSettings, Spot%MaxSpots%Active
		IniWrite, 0, %UserConfig%, GuiSettings, Spot%MaxSpots%Scroll
		IniWrite, 0, %UserConfig%, GuiSettings, Spot%MaxSpots%X1
		IniWrite, 0, %UserConfig%, GuiSettings, Spot%MaxSpots%Y1
		IniWrite, 0, %UserConfig%, GuiSettings, Spot%MaxSpots%X2
		IniWrite, 0, %UserConfig%, GuiSettings, Spot%MaxSpots%Y2
		IniWrite, 0, %UserConfig%, GuiSettings, Spot%MaxSpots%X3
		IniWrite, 0, %UserConfig%, GuiSettings, Spot%MaxSpots%Y3
		IniWrite, 0, %UserConfig%, GuiSettings, Spot%MaxSpots%X4
		IniWrite, 0, %UserConfig%, GuiSettings, Spot%MaxSpots%Y4
		IniWrite, 0, %UserConfig%, GuiSettings, Spot%MaxSpots%X5
		IniWrite, 0, %UserConfig%, GuiSettings, Spot%MaxSpots%Y5
		IniWrite, 0, %UserConfig%, GuiSettings, Spot%MaxSpots%X6
		IniWrite, 0, %UserConfig%, GuiSettings, Spot%MaxSpots%Y6
		IniWrite, % "", %UserConfig%, Hotkeys, Spot%MaxSpots%ToolKey
		IniWrite, % "", %UserConfig%, Hotkeys, Spot%MaxSpots%RuneKey
		IniWrite, % "", %UserConfig%, Hotkeys, Spot%MaxSpots%ScrollKey
		Reload
	}
return

REMOVESPOTTAB:
	If (MaxSpots = 0)
	{
		MsgBox, No harvesting spot to remove
	}
	else
	{
		MaxSpots--
		MsgBox, 4, Remove Harvesting Tab, This will remove the last harvesting spot on the list, confirm?
		IfMsgBox Yes
		{
			IniWrite, %MaxSpots%, %UserConfig%, GuiSettings, MaxSpots
			Reload
		}
	}
return

SETSPOTTARGET:
	RegExMatch(A_GuiControl, "SetSpot(\d+)", SpotNum)
	StringRight, TargetNum, A_GuiControl, 1
	XCoord = Spot%SpotNum1%X%TargetNum%
	YCoord = Spot%SpotNum1%Y%TargetNum%
	SetGuiCoords(XCoord,YCoord,WinName)
return

ADDCUSTOMKEYSTAB:
	if (MaxCustomKeys = 50)
	{
		MsgBox, Max Tab limit reached. Remove a custom hotkeys page.
		return
	}
	MaxCustomKeys++

	MsgBox, 4, Add Custom Hotkeys Tab, This will add a new custom hotkeys page, confirm?
	IfMsgBox Yes
	{
		;Write our new MaxCustomKeys in config.ini
		IniWrite, %MaxCustomKeys%, %UserConfig%, GuiSettings, MaxCustomKeys
		;Save new custom hotkeys page default values
		i := 1
		while (i < 6)
		{
			IniWrite, % "", %UserConfig%, Hotkeys, CustomKeys%MaxCustomKeys%Key%i%InGame
			IniWrite, 1, %UserConfig%, GuiSettings, CustomKeys%MaxCustomKeys%Key%i%Mod
			IniWrite, % "", %UserConfig%, Hotkeys, CustomKeys%MaxCustomKeys%Key%i%
			i++
		}
		Reload
	}
return

REMOVECUSTOMKEYSTAB:
	If (MaxCustomKeys = 0)
	{
		MsgBox, No custom routine to remove
	}
	else
	{
		MaxCustomKeys--
		MsgBox, 4, Remove Custom Hotkeys Tab, This will remove the last custom hotkeys page on the list, confirm?
		IfMsgBox Yes
		{
			IniWrite, %MaxCustomKeys%, %UserConfig%, GuiSettings, MaxCustomKeys
			Reload
		}
	}
return

CUSTOMKEYSROUTINE:
	Loop, %MaxCustomKeys%
	{
		i := 1
		while (i < 6)
		{
			if CustomKeys%A_Index%Key%i%Mod = 2
				CustomModifier := "!"
			else if CustomKeys%A_Index%Key%i%Mod = 3
				CustomModifier := "^"
			else if CustomKeys%A_Index%Key%i%Mod = 4
				CustomModifier := "+"
			CustomHotkey := CustomModifier . CustomKeys%A_Index%Key%i%
			if ( A_ThisHotkey == CustomHotkey)
				SendHotkey(WinName,CustomKeys%A_Index%Key%i%InGame)
			i++
		}
	}
return

MAINLOOP:
	GoSub, Save
	GuiState("Disable")
	GuiControl, Hide, MainGo
	GuiControl, Hide, SaveButton
	GuiControl, Show, MainStop
	GuiControl,,Routine,
	GuiControl, Show, Routine
	GuiControl, Show, LoopCounter
	GuiControl, Show, LoopCounterLabel
	GuiControl, Show, RelogCounter
	GuiControl, Show, RelogCounterLabel

	WinActivate, %WinName%
	Sleep 1000
	WinGetPos, X, Y, Width, Height, %WinName%

	;Make sure loop is started
	breakvar := 0

	;Init counters
	LoopCounter := 0
	RelogCounter := 0
	FishingCounter := 1
	LockpickCounter := 1
	Harvested := 0

	;Harvesting coords:
	Loop, %MaxSpots%
	{
		Spot%A_Index%Coords := [[Spot%A_Index%X1,Spot%A_Index%Y1],[Spot%A_Index%X2,Spot%A_Index%Y2],[Spot%A_Index%X3,Spot%A_Index%Y3],[Spot%A_Index%X4,Spot%A_Index%Y4],[Spot%A_Index%X5,Spot%A_Index%Y5],[Spot%A_Index%X6,Spot%A_Index%Y6]]
	}

	Loop
	{
		if breakvar = 1
			break

		;Check for delog
		if (AutoRelog)
		{
			WinGet, winid ,, A
			BlockInput, On
			WinActivate, %WinName%
			image_argument := "*" . Sens . " steam_play.bmp"
			ImageSearch, FoundX, FoundY, 0, 0, %Width%, %Height%, %image_argument%
			if ErrorLevel = 1
			{
				;We are still in game
				WinActivate, ahk_id %winid%
				BlockInput, Off
			}
			else
			{
				;Need to relog
				WinActivate, ahk_id %winid%
				BlockInput, Off
				CheckDelog(WinName,CharNumber)
				if breakvar = 1
					break
				RelogCounter++
				guicontrol,,RelogCounter, %RelogCounter%
				Sleep 1000
				WinActivate, %WinName%
				Sleep 1000

				;Open Bag if lockpicking
				if (Lockpicking)
					SendHotkey(WinName,BackpackKey)

				;Target closest
				if (Vet or Lore or Physical or MagicAtk)
					SendHotkey(WinName,NextTargetKey)
			}
			image_argument := "*" . Sens . " leg_play.bmp"
			ImageSearch, FoundX, FoundY, 0, 0, %Width%, %Height%, %image_argument%
			if ErrorLevel = 1
			{
				;We are still in game
				WinActivate, ahk_id %winid%
				BlockInput, Off
			}
			else
			{
				;Need to relog
				WinActivate, ahk_id %winid%
				BlockInput, Off
				CheckDelog(WinName,CharNumber)
				if breakvar = 1
					break
				RelogCounter++
				guicontrol,,RelogCounter, %RelogCounter%
				Sleep 1000
				WinActivate, %WinName%
				Sleep 1000

				;Open Bag if lockpicking
				if (Lockpicking)
					SendHotkey(WinName,BackpackKey)

				;Target closest
				if (Vet or Lore or Physical or MagicAtk)
					SendHotkey(WinName,NextTargetKey)
			}
		}

		if breakvar = 1
			break

		;Hide first
		if (Hiding)
		{
			GuiControl,,Routine, %RoutineMessage1%
			;If Odd loop go left, else go right
			if (LoopCounter&1)
				Direction = %LeftKey%
			else
				Direction = %RightKey%

			;Hide
			SendHotkey(WinName,HidingKey)
			Sleep %LagDelay%

			;Stealth around
			if (Stealth) {
				GuiControl,,Routine, %RoutineMessage2%
				Sleep 1000
				i := 0
				while (i < Steps)
				{
					StealthDelay := 9300 / Steps
					HoldHotkey(WinName,Direction,100)
					Sleep %StealthDelay%
					i++
					if breakvar = 1
						break
				}
				Sleep %LagDelay%
			}
			else
			{
				;Hide to break Hiding
				SendHotkey(WinName,HidingKey)
				Sleep %LagDelay%
				SendHotkey(WinName,HidingKey)
				Sleep 50
				SendHotkey(WinName,HidingKey)
				Sleep 50
			}
			SleepTime := HidingDelay /2
			if breakvar = 1
				break
			Sleep %SleepTime%
			if breakvar = 1
				break
			Sleep %SleepTime%
		}

		if breakvar = 1
			break

		;Healing
		if (Bandages) {
			GuiControl,,Routine, %RoutineMessage3%
			SendHotkey(WinName,BandagesKey)
			Sleep %LagDelay%
			if (BandagesTarget = 2)
				SendHotkey(WinName,SelfKey)
			else if (BandagesTarget = 3)
				SendHotkey(WinName,TargetKey)
			else if (BandagesTarget = 4)
				SendHotkey(WinName,LastKey)
			Sleep %LagDelay%
		}

		if breakvar = 1
			break

		if (MagicHeal) {
			GuiControl,,Routine, %RoutineMessage4%
			SendHotkey(WinName,MagicHealKey)
			Sleep %LagDelay%
			if (MagicHealTarget = 2)
				SendHotkey(WinName,SelfKey)
			else if (MagicHealTarget = 3)
				SendHotkey(WinName,TargetKey)
			else if (MagicHealTarget = 4)
				SendHotkey(WinName,LastKey)
			Sleep %LagDelay%
		}

		if breakvar = 1
			break

		if (CurePot) {
			GuiControl,,Routine, %RoutineMessage5%
			SendHotkey(WinName,CurePotKey)
			Sleep %LagDelay%
			if (CurePotTarget = 2)
				SendHotkey(WinName,SelfKey)
			else if (CurePotTarget = 3)
				SendHotkey(WinName,TargetKey)
			else if (CurePotTarget = 4)
				SendHotkey(WinName,LastKey)
			Sleep %LagDelay%
		}

		if breakvar = 1
			break

		if (CureSpell) {
			GuiControl,,Routine, %RoutineMessage6%
			SendHotkey(WinName,CureSpellKey)
			Sleep %LagDelay%
			if (CureSpellTarget = 2)
				SendHotkey(WinName,SelfKey)
			else if (CureSpellTarget = 3)
				SendHotkey(WinName,TargetKey)
			else if (CureSpellTarget = 4)
				SendHotkey(WinName,LastKey)
			Sleep %LagDelay%
		}

		if breakvar = 1
			break

		if (Bandages or MagicHeal or CurePot or CureSpell)
			Sleep %HealingDelay%

		if breakvar = 1
			break

		;Offensive
		if (Physical)
		{
			GuiControl,,Routine, %RoutineMessage7%
			SendHotkey(WinName,PhysicalKey)
			Sleep %PhysicalDuration%
			SendHotkey(WinName,PhysicalKey)
			Sleep %LagDelay%
		}

		if breakvar = 1
			break

		if (MagicAtk)
		{
			GuiControl,,Routine, %RoutineMessage8%
			SendHotkey(WinName,MagicAtkKey)
			Sleep %LagDelay%
			if (MagicAtkTarget = 2)
				SendHotkey(WinName,SelfKey)
			else if (MagicAtkTarget = 3)
				SendHotkey(WinName,TargetKey)
			else if (MagicAtkTarget = 4)
				SendHotkey(WinName,LastKey)
			Sleep %LagDelay%

			if (DoubleTarget) {
				Sleep 1000
				if (MagicAtkTarget = 2)
					SendHotkey(WinName,SelfKey)
				else if (MagicAtkTarget = 3)
					SendHotkey(WinName,TargetKey)
				else if (MagicAtkTarget = 4)
					SendHotkey(WinName,LastKey)
			}
			SendHotkey(WinName,SkillKey)
			Sleep %LagDelay%
		}

		if breakvar = 1
			break

		if (Physical or MagicAtk)
		{
			Sleep %OffensiveDelay%
		}

		if breakvar = 1
			break

		;Animal Lore
		if (Lore)
		{
			GuiControl,,Routine, %RoutineMessage9%
			;Use magnifier on target
			SendHotkey(WinName,LoreKey)
			Sleep %LagDelay%
			SendHotkey(WinName,TargetKey)
			Sleep %LagDelay%
			Sleep %LoreDelay%
		}

		if breakvar = 1
			break

		;Play Music
		if (Music)
		{
			i := 0
			while (i < 1)
			{
				GuiControl,,Routine, %RoutineMessage10%
				;Play music
				SendHotkey(WinName,Musickey)
				Sleep %LagDelay%
				Sleep %MusicDelay%
				i++
				if breakvar = 1
					break
			}
		}
		else if (Provo)
		{
			GuiControl,,Routine, %RoutineMessage11%
			;Provoke current target
			SendHotkey(WinName,ProvoKey)
			Sleep %LagDelay%
			SendHotkey(WinName,TargetKey)
			Sleep %LagDelay%
			SendHotkey(WinName,NextTargetKey)
			Sleep %LagDelay%
			SendHotkey(WinName,NextTargetKey)
			Sleep %LagDelay%
			SendHotkey(WinName,TargetKey)
			Sleep %ProvoDelay%
		}
		else if (Peace)
		{
			GuiControl,,Routine, %RoutineMessage12%
			;Peace current target
			SendHotkey(WinName,peaceKey)
			Sleep %LagDelay%
			SendHotkey(WinName,TargetKey)
			Sleep %LagDelay%
			Sleep %PeaceDelay%
		}
		else if (Discord)
		{
			GuiControl,,Routine, %RoutineMessage13%
			;Discord current target
			SendHotkey(WinName,DiscordKey)
			Sleep %LagDelay%
			SendHotkey(WinName,TargetKey)
			Sleep %LagDelay%
			Sleep %DiscordDelay%
		}

		if breakvar = 1
			break

		;Lockpicking
		if (Lockpicking)
		{
			if (Lockpicking2)
			{
				;If Odd loop Box1, else Box2
				if (LoopCounter&1)
				{
					BoxX := Box1X
					BoxY := Box1Y
					BoxKey := Box1Key
					GuiControl,,Routine, %RoutineMessage14%
				}
				else
				{
					BoxX := Box2X
					Boxy := Box2Y
					BoxKey := Box2Key
					GuiControl,,Routine, %RoutineMessage15%
				}
			}
			else
			{
				BoxX := Box1X
				BoxY := Box1Y
				BoxKey := Box1Key
				GuiControl,,Routine, %RoutineMessage14%
			}

			;Try to pick Box
			SendHotkey(WinName,LockpickKey)
			Sleep %LagDelay%
			;Click Box
			WinActivate, %WinName%
			Sleep 100
			MouseMove, BoxX, BoxY, 0
			Send, {LButton Down}
			Sleep 100
			Send, {LButton Up}
			Sleep 1500

			if breakvar = 1
			break

			;Look for the Charge bar
			WinActivate, %WinName%
			image_argument := "*" . LockpickingSens . " charge.bmp"
			lOffset := 300
			lX1 := Width/2 - Width/8
			lY1 := Height/2
			lX2 := Width/2 + Width/8
			lY2 := Height/2 + Height/4
			ImageSearch, FoundX, FoundY, lX1, lY1, lX2, lY2, %image_argument%

			if ErrorLevel = 1
			{
				GuiControl,,Routine, %RoutineMessage16%
				;MsgBox, Need to relock
				;We did not get to pick, relock chest
				SendHotkey(WinName,BoxKey)
				Sleep %LagDelay%
				;Click Box 1
				WinActivate, %WinName%
				Sleep 100
				MouseMove, BoxX, BoxY, 0
				Send, {LButton Down}
				Sleep 100
				Send, {LButton Up}
				Sleep %LagDelay%
			}
			else
				Sleep %LockpickDelay%
		}

		if breakvar = 1
			break

		;Check if we need to release a pet
		if (Release)
		{
			GuiControl,,Routine, %RoutineMessage17%
			;Release target
			SendHotkey(WinName,ReleaseKey)
			Sleep %LagDelay%
			SendHotkey(WinName,TargetKey)
			Sleep %LagDelay%

			;Look for pop up
			WinActivate, %WinName%
			image_argument := "*" . ReleaseSens . " release.bmp"
			if ImageClick(WinName,Width,Height,image_argument)
			{
				;Clear current target to not waste a loop
				SendHotkey(WinName,NextTargetKey)
				Sleep 200
			}
			Sleep %ReleaseDelay%
		}

		if breakvar = 1
			break

		;Tab and tame a new target
		if (Taming)
		{
			GuiControl,,Routine, %RoutineMessage18%
			;Target and tame
			SendHotkey(WinName,NextTargetKey)
			Sleep 200
			SendHotkey(WinName,TamingKey)
			Sleep %LagDelay%
			SendHotkey(WinName,TargetKey)
			Sleep %LagDelay%
			Sleep %TamingDelay%
		}

		if breakvar = 1
			break

		if (Fishing)
		{
			if (Fishing2)
			{
				;If Odd loop fish1, else fish2
				if (LoopCounter&1)
				{
					FishingX := FishingX1
					FishingY := FishingY1
					GuiControl,,Routine, %RoutineMessage19%
				}
				else
				{
					FishingX := FishingX2
					FishingY := FishingY2
					GuiControl,,Routine, %RoutineMessage20%
				}
			}
			else
			{
				FishingX := FishingX1
				FishingY := FishingY1
				GuiControl,,Routine, %RoutineMessage19%
			}

			if (FishingTotal > 1)
			{
				if (FishingCounter = FishingTotal + 1)
					FishingCounter := 1
				SendHotkey(WinName,FishingKey%FishingCounter%)
				Sleep 2500
			}
			SendHotkey(WinName,SkillKey)
			Sleep %LagDelay%

			WinActivate, %WinName%
			Sleep 100
			SendHotkey(WinName,CenterCamKey)
			Sleep 100
			MouseMove, FishingX, FishingY, 0
			Send, {LButton Down}
			Sleep 100
			Send, {LButton Up}
			Sleep %LagDelay%
			Sleep %FishingDelay%
			FishingCounter++
		}

		if breakvar = 1
			break

		if (Vet)
		{
			GuiControl,,Routine, %RoutineMessage21%
			SendHotkey(WinName,AllKillKey)
			Sleep %LagDelay%
			SendHotkey(WinName,TargetKey)
			Sleep %LagDelay%
			Sleep %VetDelay%
			SendHotkey(WinName,AllStopKey)
			Sleep %LagDelay%
		}

		if breakvar = 1
			break

		;Item ID
		if (ItemID)
		{
			;check for identified
			;Look for the Charge bar
			WinActivate, %WinName%
			image_argument := "*" . ItemIDSens . " unidentified.bmp"
			MiddleX := (ItemIDSourceBRX - ItemIDSourceTLX)/2 + ItemIDSourceTLX
			MiddleY := (ItemIDSourceBRY - ItemIDSourceTLY)/2 + ItemIDSourceTLY
			CenterX := Width/2
			CenterY := Height/2
			ImageSearch, FoundX, FoundY, ItemIDSourceTLX, ItemIDSourceTLY, ItemIDSourceBRX, ItemIDSourceBRY, %image_argument%
			if ErrorLevel = 1
			{
				;First line is identified, drag it off
				WinActivate, %WinName%
				MouseMove, MiddleX, MiddleY, 0
				Send, {LButton Down}
				Sleep 100
				MouseMove, ItemIDContainerX, ItemIDContainerY, 0
				Sleep %LagDelay%
				Send, {LButton Up}
				Sleep %LagDelay%
				Send, {LButton Down}
				Sleep 100
				Send, {LButton Up}
				Sleep %LagDelay%
				MouseMove, CenterX, CenterY, 0
				Sleep 100
			}
			else
			{
				WinActivate, %WinName%
				SendHotkey(WinName,GlassKey)
				Sleep %LagDelay%
				MouseMove, MiddleX, MiddleY, 0
				Send, {LButton Down}
				Sleep 100
				Send, {LButton Up}
				Sleep %LagDelay%
				MouseMove, CenterX, CenterY, 0
				Sleep 1500
			}
			Sleep %ItemIDDelay%
		}

		if breakvar = 1
			break

			;Item Transfer
			if (ItemTransfer)
			{
				WinActivate, %WinName%
				i := 0
				while (i < MoveCycleCount)
				{
					WinActivate, %WinName%
					MouseMove, MoveFromX, MoveFromY, 0
					Send, {LButton Down}
					Sleep 250
					MouseMove, MoveToX, MoveToY, 0
					Sleep %LagDelay%
					Send, {LButton Up}
					i++
				}
				Send, {LButton Down}
				Sleep %LagDelay%
				Send, {LButton Up}
				Sleep %LagDelay%
				if (ItemTransferBreak)
				{
					break
				}
			}

			if breakvar = 1
				break

		;Harvesting
		Loop, %MaxSpots% {
			if (Spot%A_Index%Active)
			{
				GuiControl,,Routine, %RoutineMessage22% %A_Index%
				HarvestSpot(WinName, Width, Height, Spot%A_Index%RuneKey, Spot%A_Index%Scroll, Spot%A_Index%ScrollKey, Spot%A_Index%ToolKey, Spot%A_Index%Coords)
				Harvested := 1
			}
		}

		if (Harvested)
		{
			MsgBox, Harvesting done
			break
		}

		if breakvar = 1
			break

		;Custom Routines
		Loop, %MaxCustom% {
			if (Custom%A_Index%Active)
			{
				GuiControl,,Routine, %RoutineMessage23% %A_Index%
				; use a hotkey or double click a specific coord
				if (!Custom%A_Index%CoordsItem)
					SendHotkey(WinName,Custom%A_Index%Key)
				else
				{
					;Double click Mouse
					WinActivate, %WinName%
					Sleep 100
					MouseMove, Custom%A_Index%CoordsItemX, Custom%A_Index%CoordsItemY, 0
					Sleep 50
					Send, {LButton Down}
					Sleep 100
					Send, {LButton Up}
					Sleep 50
					Send, {LButton Down}
					Sleep 100
					Send, {LButton Up}
				}
				Sleep %LagDelay%
				if breakvar = 1
					break
				SleepCustomDelay := Custom%A_Index%PreDelay
				Sleep %SleepCustomDelay%

				; right click a specific coord
				if (Custom%A_Index%CoordsRight)
				{
					;Right click Mouse
					WinActivate, %WinName%
					Sleep 100
					MouseMove, Custom%A_Index%CoordsRightX, Custom%A_Index%CoordsRightY, 0
					Sleep 50
					Send, {RButton Down}
					Sleep 100
					Send, {RButton Up}
					Sleep 500
				}
				
				; use a target hotkey or single click a specific coord
				if (!Custom%A_Index%CoordsTarget)
				{
					if (Custom%A_Index%Target = 2)
						SendHotkey(WinName,SelfKey)
					else if (Custom%A_Index%Target = 3)
						SendHotkey(WinName,TargetKey)
					else if (Custom%A_Index%Target = 4)
						SendHotkey(WinName,LastKey)
					else if (Custom%A_Index%Target = 5)
						SendHotkey(WinName,LastObjectKey)
				}
				else
				{
					;Double click Mouse
					WinActivate, %WinName%
					Sleep 100
					MouseMove, Custom%A_Index%CoordsTargetX, Custom%A_Index%CoordsTargetY, 0
					Sleep 50
					Send, {LButton Down}
					Sleep 100
					Send, {LButton Up}
				}
				
				Sleep %LagDelay%
				if breakvar = 1
					break
				SleepCustomDelay := Custom%A_Index%PostDelay

				; breaks up the custom post delay for easier breaking during long sleeps
				PostDelayLoopCount := Floor(SleepCustomDelay/1000)
				PostDelaySleepRemainder := Mod(SleepCustomDelay, 1000)
				Loop, %PostDelayLoopCount%
				{
					Sleep 1000
					if breakvar = 1
						break
				}
				Sleep %PostDelaySleepRemainder%
			}
			if breakvar = 1
				break
			Sleep %CustomRoutineDelay%
		}

		Sleep 100
		if breakvar = 1
			break

		LoopCounter++
		guicontrol,,LoopCounter, %LoopCounter%
	}

	breakvar := 0
	; Fix GUI
	CleanUpGui(guiname)
return


START:
	GoSub, MainLoop
return

GUICLOSE:
	ExitApp

;FUNCTIONS

;Harvesting routine
HarvestSpot(Window, WinWidth, WinHeight, HarvestRuneKey, HarvestScroll, HarvestScrollKey, HarvestToolKey, HarvestCoords)
{
	Global LagDelay
	Global SkillKey
	Global CenterCamKey
	Global breakvar
	Global HarvestSens
	Global HarvestingRoutineDelay
	Global SurveyKey
	Global Survey

	if breakvar = 1
		return

	;Go to Harvest spot
	SendHotkey(Window,HarvestRuneKey)
	Sleep %LagDelay%
	if (HarvestScroll)
	{
		SendHotkey(Window,HarvestScrollKey)
		Sleep %LagDelay%
	}
	;Find a way to make sure you have recalled
	Sleep %HarvestingRoutineDelay%
	SendHotkey(Window,HarvestToolKey)
	Sleep 3000

	i := 1
	while i < 7
	{
		;Skip empty coords
		if ((HarvestCoords[i][1] < 1) or (HarvestCoords[i][2] < 1)) {
			i++
			Continue
		}
		if breakvar = 1
				return
		WinActivate, %Window%
		SendHotkey(Window,SkillKey)
		Sleep %LagDelay%
		SendHotkey(Window,CenterCamKey)
		Sleep %LagDelay%
		MouseMove, HarvestCoords[i][1], HarvestCoords[i][2], 0
		Sleep %LagDelay%
		Send, {LButton Down}
		Sleep 100
		Send, {LButton Up}
		Sleep 1000
		breakvar2 := 0

		Loop
		{
			Sleep 100
			if breakvar = 1
				return
			;Try survey
			if(survey)
			{
				SendHotkey(Window,SurveyKey)
				MouseMove, HarvestCoords[i][1], HarvestCoords[i][2], 0
				Sleep %LagDelay%
				Send, {LButton Down}
				Sleep 100
				Send, {LButton Up}
			}

			;Look for the Charge bar
			WinActivate, %Window%
			image_argument := "*" . HarvestSens . " charge.bmp"
			lX1 := WinWidth/2 - WinWidth/8
			lY1 := WinHeight/2
			lX2 := WinWidth/2 + WinWidth/8
			lY2 := WinHeight/2 + WinHeight/4

			ImageSearch, FoundX, FoundY, lX1, lY1, lX2, lY2, %image_argument%
			if ErrorLevel = 1
			{
				;Not harvesting anymore
				breakvar2++
				Sleep 1000
			}
			else
				breakvar2 := 0

			;Could not see the harvest bar for more than 5 seconds.
			if (breakvar2 > 5)
				break
		}
		Sleep %LagDelay%
		i++
	}
	return
}

;Routine to set coords
SetGuiCoords(SettingX,SettingY,Window)
{
	Gui, Submit, NoHide
	MsgBox, Your client window will become active after you click OK.`nMove the mouse to where you want and left click
	WinActivate, %Window%

	KeyWait, LButton, D
	MouseGetPos, UserX, UserY

	guicontrol,,%SettingX%,%UserX%
	guicontrol,,%SettingY%,%UserY%

	MsgBox, Saved %UserX% - %UserY%
	return
}

;Restores GUI to its standby state
CleanUpGui(name)
{
	GuiControl, Hide, Routine
	GuiControl, Hide, LoopCounter
	GuiControl, Hide, LoopCounterLabel
	GuiControl, Hide, RelogCounter
	GuiControl, Hide, RelogCounterLabel
	GuiControl, Hide, MainStop
	GuiControl, Show, SaveButton
	GuiControl, Show, MainGo
	GuiState("Enable")
	WinActivate, %name%
	return
}
;Change the states of the gui control to disable them when the script is running
GuiState(state)
{
	Global GuiSettingsList
	Global GuiDPSettingsList
	Global GuiHotkeysList
	Global GuiLabelsList

	Loop, parse, GuiSettingsList, `,
		GuiControl, %State%, %A_LoopField%

	Loop, parse, GuiDPSettingsList, `,
		GuiControl, %State%, %A_LoopField%

	Loop, parse, GuiHotkeysList, `,
		GuiControl, %State%, %A_LoopField%

	Loop, parse, GuiLabelsList, `,
		GuiControl, %State%, %A_LoopField%

	Loop, parse, GuiSetButtonsList, `,
		GuiControl, %State%, %A_LoopField%

	return
}

;Use the specified Hotkey in a specific client window.
SendHotkey(Window,Hotkey)
{
	ControlFocus, , %Window%
	ControlSend, , {%Hotkey% down}{%Hotkey% up}, %Window%
	return
}

;Holds a key for a set time in ms
HoldHotkey(Window,Hotkey,Delay)
{
	ControlFocus, ,  %Window%
	ControlSend, , {%Hotkey% down}, %Window%
	Sleep %Delay%
	ControlFocus, , %Window%
	ControlSend, , {%Hotkey% up}, %Window%
	return
}

;Search for an image on the whole screen. Width/Height are max windows values
;Will click where the image is found, you can use offsets to have it clicked away from the top left corner of the image
ImageClick(Window,Width,Height,image_argument,offsetX:=0,offsetY:=0)
{
	ImageSearch, FoundX, FoundY, 0, 0, %Width%, %Height%, %image_argument%
	if ErrorLevel = 2
	{
		MsgBox %image_argument% is missing
		return false
	}
	else if ErrorLevel = 1
	{
		;Image not found
		return false
	}
	else
	{
		;Click found coords
		FoundX := FoundX + offsetX
		FoundY := FoundY + offsetY
		MouseMove, FoundX, FoundY, 0
		Send, {LButton Down}
		Sleep 100
		Send, {LButton Up}
		return true
	}
}

CheckDelog(Window,Char)
{
	Global Sens
	Global breakvar
	WinActivate, %Window%
	WinGetPos, X, Y, Width, Height, %Window%
	OffsetY := 43 * (Char - 1)

	;Look for the title screen play button
	i := 0
	Loop
	{
		WinActivate, %Window%
		image_argument1 := "*" . Sens . " steam_play.bmp"
		image_argument2 := "*" . Sens . " leg_play.bmp"
		if ImageClick(Window,Width,Height,image_argument1)
			break
		if ImageClick(Window,Width,Height,image_argument2)
			break
		Sleep 1000

		i++
		if (i > 60)
		{
			WinActivate, %Window%
			;Look for the Ok button in an error window
			image_argument := "*" . Sens . " okerror.bmp"
			ImageClick(Window,Width,Height,image_argument)
			Sleep 1000
			WinActivate, %Window%
			;Try the blue OK for server failed
			image_argument := "*" . Sens . " failed.bmp"
			ImageClick(Window,Width,Height,image_argument)
			Sleep 1000
			WinActivate, %Window%
			;Timed out in a weird way, click back button twice and start over
			image_argument := "*" . Sens . " back.bmp"
			ImageClick(Window,Width,Height,image_argument)
			Sleep 3000
			WinActivate, %Window%
			image_argument := "*" . Sens . " back.bmp"
			ImageClick(Window,Width,Height,image_argument)
			Sleep 100
			return CheckDelog(Window,Char)
		}
		if breakvar = 1
			return
	}



	;Play button was present and clicked
	;Move mouse out of the way
	Sleep 100
	MouseMove,Width/2,Height/2

	;Look for community tab
	i := 0
	Loop
	{
		WinActivate, %Window%
		image_argument := "*" . Sens . " community.bmp"
		if ImageClick(Window,Width,Height,image_argument)
		{
			break
		}
		;Look for the Connect Failed window
		WinActivate, %Window%
		image_argument := "*" . Sens . " okerror.bmp"
		if ImageClick(Window,Width,Height,image_argument)
			return CheckDelog(Window,Char)

		Sleep 1000

		i++
		if (i > 60)
		{
			WinActivate, %Window%
			;Timed out in a weird way, click back button and start over
			image_argument := "*" . Sens . " back.bmp"
			ImageClick(Window,Width,Height,image_argument)
			Sleep 1000
			return CheckDelog(Window,Char)
		}
		if breakvar = 1
			return
	}



	;Look for server name
	i := 0
	Loop
	{
		WinActivate, %Window%
		image_argument := "*" . Sens . " loultima.bmp"
		if ImageClick(Window,Width,Height,image_argument)
			break

		WinActivate, %Window%
		;Look for the Connect Failed window
		image_argument := "*" . Sens . " okerror.bmp"
		if ImageClick(Window,Width,Height,image_argument)
			return CheckDelog(Window,Char)

		Sleep 1000

		i++
		if (i > 60)
		{
			WinActivate, %Window%
			;Timed out in a weird way, click back button and start over
			image_argument := "*" . Sens . " back.bmp"
			ImageClick(Window,Width,Height,image_argument)
			Sleep 1000
			return CheckDelog(Window,Char)
		}
		if breakvar = 1
			return
	}

	;Look for Enter World button
	i := 0
	Loop
	{
		WinActivate, %Window%
		image_argument := "*" . Sens . " enter.bmp"
		if ImageClick(Window,Width,Height,image_argument)
			break

		WinActivate, %Window%
		;Look for the Connect Failed window
		image_argument := "*" . Sens . " okerror.bmp"
		if ImageClick(Window,Width,Height,image_argument)
			return CheckDelog(Window,Char)

		Sleep 1000

		i++
		if (i > 60)
		{
			WinActivate, %Window%
			;Timed out in a weird way, click back button and start over
			image_argument := "*" . Sens . " back.bmp"
			ImageClick(Window,Width,Height,image_argument)
			Sleep 1000
			return CheckDelog(Window,Char)
		}
		if breakvar = 1
			return
	}

	;Look for Character Box corner
	Sleep 3000
	Loop
	{
		WinActivate, %Window%
		image_argument := "*60 character.bmp"
		if ImageClick(Window,Width,Height,image_argument,50,OffsetY)
		{
			Sleep 5000
			break
		}
		Sleep 1000

		i++
		if (i > 60)
		{
			WinActivate, %Window%
			;Look for the Ok button in an error window
			image_argument := "*" . Sens . " okerror.bmp"
			ImageClick(Window,Width,Height,image_argument)
			Sleep 1000
			WinActivate, %Window%
			;Try the blue OK for server failed
			image_argument := "*" . Sens . " failed.bmp"
			ImageClick(Window,Width,Height,image_argument)
			Sleep 1000
			WinActivate, %Window%
			;Timed out in a weird way, click back button twice and start over
			image_argument := "*" . Sens . " back.bmp"
			ImageClick(Window,Width,Height,image_argument)
			Sleep 3000
			WinActivate, %Window%
			ImageClick(Window,Width,Height,image_argument)
			Sleep 1000
			return CheckDelog(Window,Char)
		}
		if breakvar = 1
			return
	}

	;Look for Play button
	Loop
	{
		WinActivate, %Window%
		image_argument := "*" . Sens . " charplay.bmp"
		if ImageClick(Window,Width,Height,image_argument)
			break
		Sleep 1000

		i++
		if (i > 60)
		{
			WinActivate, %Window%
			;Look for the Ok button in an error window
			image_argument := "*" . Sens . " okerror.bmp"
			ImageClick(Window,Width,Height,image_argument)
			Sleep 1000
			WinActivate, %Window%
			;Try the blue OK for server failed
			image_argument := "*" . Sens . " failed.bmp"
			ImageClick(Window,Width,Height,image_argument)
			Sleep 1000
			WinActivate, %Window%
			;Timed out in a weird way, click back button twice and start over
			image_argument := "*" . Sens . " back.bmp"
			ImageClick(Window,Width,Height,image_argument)
			Sleep 3000
			WinActivate, %Window%
			ImageClick(Window,Width,Height,image_argument)
			Sleep 1000
			return CheckDelog(Window,Char)
		}
		if breakvar = 1
			return
	}

	;Give client time to load
	Sleep 3000

	;Check ingame, look for red bar in hp
	Loop
	{
		WinActivate, %Window%
		image_argument := "*" . Sens . " ingame.bmp"
		if ImageClick(Window,Width,Height,image_argument)
			break

		WinActivate, %Window%
		;Look for the Connect Failed window
		image_argument := "*" . Sens . " failed.bmp"
		if ImageClick(Window,Width,Height,image_argument)
			return CheckDelog(Window,Char)
		Sleep 1000

		i++
		if (i > 60)
		{
			WinActivate, %Window%
			;Look for the Ok button in an error window
			image_argument := "*" . Sens . " okerror.bmp"
			ImageClick(Window,Width,Height,image_argument)
			Sleep 1000
			WinActivate, %Window%
			;Try the blue OK for server failed
			image_argument := "*" . Sens . " failed.bmp"
			ImageClick(Window,Width,Height,image_argument)
			Sleep 1000
			WinActivate, %Window%
			;Timed out in a weird way, click back button twice and start over
			image_argument := "*" . Sens . " back.bmp"
			ImageClick(Window,Width,Height,image_argument)
			Sleep 3000
			WinActivate, %Window%
			ImageClick(Window,Width,Height,image_argument)
			Sleep 1000
			return CheckDelog(Window,Char)
		}
		if breakvar = 1
			return
	}
	return true
}
