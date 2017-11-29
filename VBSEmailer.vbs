rem *  This script is a result of testing to create a method alternative to using Blat.exe
rem *
rem *  It needed to be able to calling to send an email whilst being unreliant/outside of hmailserver API.
rem *  In particular it was necessary to be able to attach a Text file (eg, Log file) that would
rem *  be attached to the sending emial and appear 'Inline' (as was possible with Blat).
rem *
rem * The conclusion is that this WORKS!  But it doesnt give anything more/better than what Blat does.  :-)
rem *  (It was just a proof of concept).
rem *
rem * It is CALLED by VBSEmailer.bat (which passes all the parameters)


SendFrom = WScript.Arguments.Named("SendFrom")
SendFromAddress = WScript.Arguments.Named("SendFromAddress")
SendSubject = WScript.Arguments.Named("SendSubject")
SendAddRecipient = WScript.Arguments.Named("SendAddRecipient")
SendBody = WScript.Arguments.Named("SendBody")
SendFile = WScript.Arguments.Named("SendFile")
Dim strLogFileName
strLogFileName = "C:\Users\Administrator\Documents\BatchFiles\emailer.log"
Set objFSO = CreateObject("Scripting.FileSystemObject")
if SendFile <> "" then
   SendFileTrim = objFSO.GetFileName(SendFile)
End If
if objFSO.FileExists(strLogFileName) Then
 Set myLog = objFSO.OpenTextFile(strLogFileName, 8 , True)
 Else
 Set myLog = objFSO.CreateTextFile(strLogFileName)
 End if
 
myLog.WriteLine now & " ------------Start of Session-----------------"
myLog.WriteLine "Sending " & SendFile & " to " & SendAddRecipient
myLog.WriteLine "Subject: " & SendSubject
myLog.WriteLine "From: " & SendFromAddress
myLog.WriteLine "Attached text file: " & SendFile

Const cdoSendUsingPickup = 1 'Send message using the local SMTP service pickup directory.
Const cdoSendUsingPort = 2 'Send the message using the network (SMTP over the network).

Const cdoAnonymous = 0 'Do not authenticate
Const cdoBasic = 1 'basic (clear-text) authentication
Const cdoNTLM = 2 'NTLM

Set objMessage = CreateObject("CDO.Message")
objMessage.Subject = SendSubject
objMessage.From = SendFrom
objMessage.To = SendAddRecipient
objMessage.TextBody = SendBody

objMessage.Configuration.Fields.Item _
("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
'Name or IP of Remote SMTP Server
objMessage.Configuration.Fields.Item _
("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "192.168.0.200"  ' <-- your server hostname or IP address
objMessage.Configuration.Fields.Item _
("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = cdoBasic
'Your UserID on the SMTP server
objMessage.Configuration.Fields.Item _
("http://schemas.microsoft.com/cdo/configuration/sendusername") = "sendinguser@yourdomain.com"
'Your password on the SMTP server
objMessage.Configuration.Fields.Item _
("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "secretpassword"
'Server port (typically 25)
objMessage.Configuration.Fields.Item _
("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
'Use SSL for the connection (False or True)
objMessage.Configuration.Fields.Item _
("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = False
objMessage.Configuration.Fields.Update

'==End remote SMTP server configuration section==

Dim iBp1
Dim iBp2

Set iBp1 = objMessage.BodyPart
Set Flds = iBp1.Fields
Flds("urn:schemas:mailheader:content-type") = "text/html"
Flds.Update

Set iBp2 = iBp1.AddBodyPart
With iBp2
   .ContentMediaType        = "text/plain"
   .ContentTransferEncoding = "quoted-printable"
   
   Set Flds = iBp2.Fields
   Flds("urn:schemas:mailheader:content-disposition") = "attachment; filename="""&SendFileTrim&""""
   Flds.Update
   Set Stm = .GetDecodedContentStream
   Stm.LoadFromFile SendFile
   Stm.Flush
End With

Stm.Close
Set Stm = Nothing
objMessage.Send
myLog.WriteLine now & " -------------End of Session------------------"
myLog.WriteLine "**********************************" 
myLog.Close

