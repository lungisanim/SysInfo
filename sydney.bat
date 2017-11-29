echo off
cls

rem * This calls VBSEmailer.vbs to do the work (which also logs to Emailer.log)

set emailRecipient="lungisanin@redpandasoftware.co.za"
set /p "emailRecipient=Email Recipient [%emailRecipient%]--> "

set emailFrom="lungisanin@redpandasoftware.co.za"
set /p "emailFrom=Email FROM [%emailFrom%]--> "

set subj="System Details"
set /p "subj=Subject: [%subj%]--> "
echo %subj%


set SendFile="C:\Users\lungisanin\myscripts\sydney\information.txt"
set /p "SendFile=Attachment [%SendFile%]--> "

set body=Contained are the system details of your computer.
set /p "body=Body Text: [%body%]--> "

cscript.exe //NoLogo C:\Users\lungisanin\myscripts\sydney\VBSEmailer.vbs /SendFrom:%emailFrom% /SendFromAddress:%emailFrom% /SendAddRecipient:%emailRecipient% /SendSubject:"%subj%" /SendBody:"%body%" /SendFile:%SendFile%