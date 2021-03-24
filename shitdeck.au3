#include <MsgBoxConstants.au3>
TrayTip("AutoIt Web Server", "Starting to create server..",10)

Dim $sRootDir = @ScriptDir & "\www\" ; The absolute path to the root directory of the server.

Dim $IP = @IPAddress2
Dim $Port = 80 ; the listening port

Dim $Max_Users = 15

Dim $Socket[$Max_Users]
Dim $Buffer[$Max_Users]
$Socket[0] = -1

TCPStartup()

$MainSocket = TCPListen($IP,$Port) ;create main listening socket
If @error Then
    MsgBox(0x20, "AutoIt Webserver", "Unable to create a socket on port " & $Port & ".")
    Exit
EndIf

TrayTip("AutoIt Web Server", "Server created on http://" & $IP & "/",10)

While 1
    Sleep(10)

    $NewSocket = TCPAccept($MainSocket)
    If $NewSocket >= 0 Then
        For $x = 0 to UBound($Socket)-1
            If $Socket[$x] = -1 Then
                $Socket[$x] = $NewSocket ;store the new socket
                ExitLoop
            EndIf
        Next
    EndIf


    For $x = 0 to UBound($Socket)-1 ; loop to receive data from all sockets
        If $Socket[$x] = -1 Then ContinueLoop
        $NewData = TCPRecv($Socket[$x],1024)
        If @error Then
            $Socket[$x] = -1
            ContinueLoop
        ElseIf $NewData Then ; data received
            $Buffer[$x] &= $NewData ;store it in the buffer
            If StringInStr(StringStripCR($Buffer[$x]),@LF&@LF) Then
                $FirstLine = StringLeft($Buffer[$x],StringInStr($Buffer[$x],@LF))
                $RequestType = StringLeft($FirstLine,StringInStr($FirstLine," ")-1)
                If $RequestType = "GET" Then
                    $Request = StringTrimRight(StringTrimLeft($FirstLine,4),11)
                    If $Request = "/" Then
                        $Request = "/index.html"
					 EndIf

                    If $Request = "/0" Then
                        $Request = "/command.html"
						Run("./autoit/autoit3.exe"  & ' ./macros/0.au3')
					 EndIf
                    If $Request = "/1" Then
                        $Request = "/command.html"
						Run("./autoit/autoit3.exe"  & ' ./macros/1.au3')
					 EndIf
                    If $Request = "/2" Then
                        $Request = "/command.html"
						Run("./autoit/autoit3.exe"  & ' ./macros/2.au3')
					 EndIf
                    If $Request = "/3" Then
                        $Request = "/command.html"
						Run("./autoit/autoit3.exe"  & ' ./macros/3.au3')
					 EndIf
                    If $Request = "/4" Then
                        $Request = "/command.html"
						Run("./autoit/autoit3.exe"  & ' ./macros/4.au3')
					 EndIf
                    If $Request = "/5" Then
                        $Request = "/command.html"
						Run("./autoit/autoit3.exe"  & ' ./macros/5.au3')
					 EndIf
                    If $Request = "/6" Then
                        $Request = "/command.html"
						Run("./autoit/autoit3.exe"  & ' ./macros/6.au3')
					 EndIf
                    If $Request = "/7" Then
                        $Request = "/command.html"
						Run("./autoit/autoit3.exe"  & ' ./macros/7.au3')
					 EndIf
                    If $Request = "/8" Then
                        $Request = "/command.html"
						Run("./autoit/autoit3.exe"  & ' ./macros/8.au3')
					 EndIf
                    If $Request = "/9" Then
                        $Request = "/command.html"
						Run("./autoit/autoit3.exe"  & ' ./macros/9.au3')
					 EndIf
                    If $Request = "/10" Then
                        $Request = "/command.html"
						Run("./autoit/autoit3.exe"  & ' ./macros/10.au3')
					 EndIf
                    If $Request = "/11" Then
                        $Request = "/command.html"
						Run("./autoit/autoit3.exe"  & ' ./macros/11.au3')
					 EndIf
                    If $Request = "/12" Then
                        $Request = "/command.html"
						Run("./autoit/autoit3.exe"  & ' ./macros/12.au3')
					 EndIf
                    If $Request = "/13" Then
                        $Request = "/command.html"
						Run("./autoit/autoit3.exe"  & ' ./macros/13.au3')
					 EndIf
                    If $Request = "/14" Then
                        $Request = "/command.html"
						Run("./autoit/autoit3.exe"  & ' ./macros/14.au3')
					 EndIf
                    If $Request = "/15" Then
                        $Request = "/command.html"
						Run("./autoit/autoit3.exe"  & ' ./macros/15.au3')
					 EndIf
                    If $Request = "/16" Then
                        $Request = "/command.html"
						Run("./autoit/autoit3.exe"  & ' ./macros/16.au3')
					 EndIf
                    If $Request = "/17" Then
                        $Request = "/command.html"
						Run("./autoit/autoit3.exe"  & ' ./macros/17.au3')
					 EndIf
                    If $Request = "/18" Then
                        $Request = "/command.html"
						Run("./autoit/autoit3.exe"  & ' ./macros/18.au3')
					 EndIf
                    If $Request = "/19" Then
                        $Request = "/command.html"
						Run("./autoit/autoit3.exe"  & ' ./macros/19.au3')
					 EndIf
                    If $Request = "/20" Then
                        $Request = "/command.html"
						Run("./autoit/autoit3.exe"  & ' ./macros/20.au3')
					 EndIf
                    If $Request = "/21" Then
                        $Request = "/command.html"
						Run("./autoit/autoit3.exe"  & ' ./macros/20.au3')
					 EndIf










                    $Request = StringReplace($Request,"/","\")
                    If FileExists($sRootDir & "\" & $Request) Then
                        $sFileType = StringRight($Request,4)
                        Switch $sFileType
                            Case "html"
                                _SendFile($sRootDir & "\" & $Request, "text/html", $Socket[$x])
                            Case ".htm"
                                _SendFile($sRootDir & "\" & $Request, "text/html", $Socket[$x])
                            Case ".jpg"
                                _SendFile($sRootDir & "\" & $Request, "image/jpeg", $Socket[$x])
                            Case "jpeg"
                                _SendFile($sRootDir & "\" & $Request, "image/jpeg", $Socket[$x])
                            Case ".png"
                                _SendFile($sRootDir & "\" & $Request, "image/png", $Socket[$x])
                            Case Else
                                _SendError($Socket[$x])
                        EndSwitch
                    Else
                        _SendError($Socket[$x])
                    EndIf
                ElseIf $RequestType = "POST" Then

                    ;Get the lenght of the data in the $_POST
                    $_POST = _Get_Post($Buffer[$x])

                    ;This is my little test function ;)
                    ;Add special chars from the name
                    $Name = StringReplace(DllStructGetData($_POST,'Name'), '%', '')
                    For $t = 0 To @extended
                        $Find_Char = StringLeft(StringTrimLeft($Name, StringInStr($Name, '%')) ,2)
                        $Name = StringReplace($Name, '%' & $Find_Char, Chr(Dec($Find_Char)))
                    Next



                    ;"Refresh" the users webpage
                    _SendFile($sRootDir & "\index.html", "text/html", $Socket[$x])
                EndIf
                $Buffer[$x] = ""
                TCPCloseSocket($Socket[$x])
                $Socket[$x] = -1
            EndIf
        EndIf
    Next
WEnd

Func _SendHTML($sHTML,$sSocket)
    $iLen = StringLen($sHTML)
    $sPacket = Binary("HTTP/1.1 200 OK" & @CRLF & _
    "Server: ManadarX/1.0 (" & @OSVersion & ") AutoIt " & @AutoItVersion & @CRLF & _
    "Connection: close" & @CRLF & _
    "Content-Lenght: " & $iLen & @CRLF & _
    "Content-Type: text/html" & @CRLF & _
    @CRLF & _
    $sHTML)
    $sSplit = StringSplit($sPacket,"")
    $sPacket = ""
    For $i = 1 to $sSplit[0]
        If Asc($sSplit[$i]) <> 0 Then ; Just make sure we don't send any null bytes, because they show up as ???? in your browser.
            $sPacket = $sPacket & $sSplit[$i]
        EndIf
    Next
    TCPSend($sSocket,$sPacket)
EndFunc

Func _SendFile($sAddress, $sType, $sSocket)
    $File = FileOpen($sAddress,16)
    $sImgBuffer = FileRead($File)
    FileClose($File)

    $Packet = Binary("HTTP/1.1 200 OK" & @CRLF & _
    "Server: ManadarX/1.3.26 (" & @OSVersion & ") AutoIt " & @AutoItVersion & @CRLF & _
    "Connection: close" & @CRLF & _
    "Content-Type: " & $sType & @CRLF & _
    @CRLF)
    TCPSend($sSocket,$Packet)

    While BinaryLen($sImgbuffer) ;LarryDaLooza's idea to send in chunks to reduce stress on the application
        $a = TCPSend($sSocket,$sImgbuffer)
        $sImgbuffer = BinaryMid($sImgbuffer,$a+1,BinaryLen($sImgbuffer)-$a)
    WEnd

    $Packet = Binary(@CRLF & _
    @CRLF)
    TCPSend($sSocket,$Packet)
    TCPCloseSocket($sSocket)
EndFunc

Func _SendError($sSocket)
    _SendHTML("404 Error: " & @CRLF & @CRLF & "The file you requested could not be found.", $sSocket)
EndFunc

Func _Get_Post($s_Buffer)
    Local $s_Temp_Post,$s_Post_Data
    Local $Temp, $s_Struct, $s_Len

    ;Get the lenght of the data in the POST
    $s_Temp_Post = StringTrimLeft($s_Buffer,StringInStr($s_Buffer,'Content-Length:'))
    $s_Len = StringTrimLeft($s_Temp_Post,StringInStr($s_Temp_Post,': '))

    ;Create the base struck
    $s_Post_Data = StringSplit(StringRight($s_Buffer,$s_Len),'&')
    For $t = 1 To $s_Post_Data[0]
        $Temp = StringSplit($s_Post_Data[$t],'=')
        $s_Struct &= 'char ' & $Temp[1] & '[' & StringLen($Temp[2])+1 & '];'
    Next
    $s_Temp_Post = DllStructCreate($s_Struct)

    ;add the data to the struck
    For $t = 1 To $s_Post_Data[0]
        $Temp = StringSplit($s_Post_Data[$t],'=')
        DllStructSetData($s_Temp_Post,$Temp[1],$Temp[2])
    Next

    Return $s_Temp_Post
EndFunc