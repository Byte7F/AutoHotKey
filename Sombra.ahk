#Requires AutoHotkey v2.0
;@Ahk2Exe-UpdateManifest 1, , , 0

;-; Require Admin
if not A_IsAdmin {
	Run( "*RunAs " A_ScriptFullPath )
	ExitApp
}

;-; Common
Com := ComObject( "SAPI.SpVoice" )
Com.Voice := Com.GetVoices().Item( 0 )
Speak( text ) {
	Com.Speak( text )
}
Toast( str ) {
	TrayTip
	TrayTip( str )
	SetTimer( TrayTip, -3000 )
}

;-; Windows
WinToForeground( x := false ) {
	WinActivate( "ahk_exe explorer.exe ahk_class Progman" ) ; fix for full-screen apps
	Sleep 100
	WinExist( x ) ? WinActivate( x ) : 0
}
WinToBackground( x := false ) {
	WinExist( x ) ? WinMinimize( x ) : 0
}
WinIsActive( x := false ) {
	return( WinActive( x ? x : "ahk_exe explorer.exe ahk_class Progman" ) )
}
WinToggle( x := false ) {
	WinIsActive( x ) ? WinToBackground( x ) : WinToForeground( x )
}

;-; Auxiliary
global device_input := "Mic in at rear panel" ; "Mic in at rear panel (Pink) (2- Realtek(R) Audio)" ; "Microphone (2- Realtek(R) Audio)"
auxGetState( device, returns := "asBool" ) {
	muted := SoundGetMute( , device )
	return( returns = "asText" ? ( muted ? "Muted" : "Unmuted" ) : muted )
}
auxSetMute( type, device, muted ) {
	SoundSetMute( muted, , device )
	Toast( "[Global]`n" type " " auxGetState( device, "asText" ) "`n(" device ")" )
}
auxToggle( type, device ) {
	auxSetMute( type, device, !auxGetState( device ) )
}

;-; Toggle HotKeys = [ Ctrl + Esc ]
global disabled := false
Notify() {
	Toast( "HotKeys " ( disabled ? "Disabled" : "Enabled" ) )
}
$^Esc:: {
	global disabled
	disabled := !disabled
	Notify()
}
Notify()

#HotIf !disabled

;-; Quick Window Min/Restore = [ Win + Shift ] / [ Shift + Win ]
global win_ptr := 0
global win_hidden := false
$#LShift::
$#RShift::
$+LWin::
$+RWin:: {
	global win_hidden, win_ptr
	if( win_hidden := !win_hidden ) {
		WinMinimize( "ahk_id " win_ptr := WinExist( "A" ) )
	}
	else {
		WinRestore( "ahk_id " win_ptr )
	}
}

;-; Quick Window Switch = [ Win + Alt ] / [ Alt + Win ]
$#LAlt::
$#RAlt::
$!LWin::
$!RWin:: Send( "!{Tab}" )

; Open Volume Control Panel = [ Win + S ]
$#s:: {
	if( hWnd := WinExist( "ahk_exe SndVol.exe" ) ) {
		WinActive( "A" ) == hWnd ? WinClose( "ahk_exe SndVol.exe" ) : WinToForeground( "ahk_exe SndVol.exe" )
	}
	else {
		Run( "SndVol.exe" ), WinToForeground( "ahk_exe SndVol.exe" )
	}
}

; Set Window Hotswap = [ Win + Numpad 0-9 ]
; Hotswap to Window = [ Numpad 0-9 ]
global app := Map()
Loop 10 {
	app[ A_Index - 1 ] := 0
}
$^#Numpad0:: {
	global app
	app[ 0 ] := WinExist( "A" )
	app[ 0 ] ? SoundPlay( "*48" ) : SoundPlay( "*16" )
}
$Numpad0:: {
	global app
	app[ 0 ] ? WinToForeground( "ahk_id " app[ 0 ] ) : SoundPlay( "*16" )
}
$^#Numpad1:: {
	global app
	app[ 1 ] := WinExist( "A" )
	app[ 1 ] ? SoundPlay( "*48" ) : SoundPlay( "*16" )
}
$Numpad1:: {
	global app
	app[ 1 ] ? WinToForeground( "ahk_id " app[ 1 ] ) : SoundPlay( "*16" )
}
$^#Numpad2:: {
	global app
	app[ 2 ] := WinExist( "A" )
	app[ 2 ] ? SoundPlay( "*48" ) : SoundPlay( "*16" )
}
$Numpad2:: {
	global app
	app[ 2 ] ? WinToForeground( "ahk_id " app[ 2 ] ) : SoundPlay( "*16" )
}
$^#Numpad3:: {
	global app
	app[ 3 ] := WinExist( "A" )
	app[ 3 ] ? SoundPlay( "*48" ) : SoundPlay( "*16" )
}
$Numpad3:: {
	global app
	app[ 3 ] ? WinToForeground( "ahk_id " app[ 3 ] ) : SoundPlay( "*16" )
}
$^#Numpad4:: {
	global app
	app[ 4 ] := WinExist( "A" )
	app[ 4 ] ? SoundPlay( "*48" ) : SoundPlay( "*16" )
}
$Numpad4:: {
	global app
	app[ 4 ] ? WinToForeground( "ahk_id " app[ 4 ] ) : SoundPlay( "*16" )
}
$^#Numpad5:: {
	global app
	app[ 5 ] := WinExist( "A" )
	app[ 5 ] ? SoundPlay( "*48" ) : SoundPlay( "*16" )
}
$Numpad5:: {
	global app
	app[ 5 ] ? WinToForeground( "ahk_id " app[ 5 ] ) : SoundPlay( "*16" )
}
$^#Numpad6:: {
	global app
	app[ 6 ] := WinExist( "A" )
	app[ 6 ] ? SoundPlay( "*48" ) : SoundPlay( "*16" )
}
$Numpad6:: {
	global app
	app[ 6 ] ? WinToForeground( "ahk_id " app[ 6 ] ) : SoundPlay( "*16" )
}
$^#Numpad7:: {
	global app
	app[ 7 ] := WinExist( "A" )
	app[ 7 ] ? SoundPlay( "*48" ) : SoundPlay( "*16" )
}
$Numpad7:: {
	global app
	app[ 7 ] ? WinToForeground( "ahk_id " app[ 7 ] ) : SoundPlay( "*16" )
}
$^#Numpad8:: {
	global app
	app[ 8 ] := WinExist( "A" )
	app[ 8 ] ? SoundPlay( "*48" ) : SoundPlay( "*16" )
}
$Numpad8:: {
	global app
	app[ 8 ] ? WinToForeground( "ahk_id " app[ 8 ] ) : SoundPlay( "*16" )
}
$^#Numpad9:: {
	global app
	app[ 9 ] := WinExist( "A" )
	app[ 9 ] ? SoundPlay( "*48" ) : SoundPlay( "*16" )
}
$Numpad9:: {
	global app
	app[ 9 ] ? WinToForeground( "ahk_id " app[ 9 ] ) : SoundPlay( "*16" )
}

; | ============= | ============ | ============= | ;
; | Default:                                     | ;
; | ============= | ============ | ============= | ;
; | [PrtSc|SysRq] | [ScrollLock] | [Pause|Break] | ;
; | [Insert]      | [Home]       | [PageUp]      | ;
; | [Delete]      | [End]        | [PageDn]      | ;
; | ============= | ============ | ============= | ;
; | Modified to:                                 | ;
; | ============= | ============ | ============= | ;
; | [PrtSc-Fixed] | [UnfocusApp] | [Media Tgl]   | ;
; | [Unmute Mic]  | [Game Bar]   | [Media Prev]  | ;
; | [Mute Mic]    | [Discord]    | [Media Next]  | ;
; | ============= | ============ | ============= | ;

$PrintScreen:: {
	WinToForeground()
	Send( "{PrintScreen}" )
}
$Insert::     auxSetMute( "Mic", device_input, False )
$Delete::     auxSetMute( "Mic", device_input, True )
$ScrollLock:: WinToForeground()
$Home::       Send( "#g" )
$End::        WinToggle( "ahk_exe Discord.exe" )
$Pause::      Send( "{Media_Play_Pause}" )
$PgUp::       Send( "{Media_Prev}" )
$PgDn::       Send( "{Media_Next}" )

#HotIf

