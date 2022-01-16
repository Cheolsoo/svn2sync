@echo off

path=c:\pvcs\tools;c:\pvcs\batch;%path%;

SETLOCAL ENABLEDELAYEDEXPANSION

set tempDir=c:\temp

for /f %%a in ('powershell -Command "Get-Date -format yyyyMMdd_HHmmss"') do set datetime=%%a
echo datetime=%datetime%

cd /d c:\pvcs\svnWork\neobrain-br\chess

set aa=c:\temp\a.out 
set bb=c:\temp\b.out 
set cc=c:\temp\c.bat

if exist %aa% del /f %aa%
if exist %bb% del /f %bb%
if exist %cc% del /f %cc%
 
svn update > %aa%
awk -f c:\pvcs\tools\svn2pvcs1.awk %aa% > %bb%

echo notepad %bb% 

awk -f c:\pvcs\tools\svn2pvcs2.awk %bb% > %cc%
call %cc% 