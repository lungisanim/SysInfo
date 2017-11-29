@echo off

title state of mind 

rem this program will be used to log useful info about the system; then email to persons of interest
@echo off

chkdsk

net statistics Server 

net statistics Workstation

net config Workstation

tasklist

@echo off