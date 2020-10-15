@echo off

SET gamepath="%cd%"  
CD "%gamepath%"

ECHO Old UI Mod will be installed/updated in this folder: %gamepath%
SET /P opt=Would you like to proceed? (Y/N) 
IF /I %opt% EQU y ( SET buff=true )
IF /I %opt% EQU yes ( SET buff=true )
IF /I %buff% NEQ true ( EXIT /b )

IF EXIST ui ( 
    ECHO Detected other version installed, removing...
    DEL ui /Q
    ECHO Success!
)

:: Preparing installation info.
ECHO Downloading...
curl.exe https://api.github.com/repos/scolondev/Spiral-Knights-Old-UI-Mod/releases/latest | findstr browser_download_url > temp 
SET /P url=<temp
DEL temp
SET url=%url:"=%
SET url=%url:      browser_download_url: =%
SET filename=%url:https://github.com/scolondev/Spiral-Knights-Old-UI-Mod/releases/download/=%
ECHO %filename% > temp
(FOR /F "tokens=1,* delims=/" %%a IN (temp) DO ECHO %%b) > temp2
SET /P filename=<temp2
DEL temp
DEL temp2

:: Downloading and installing new version. NOTE: If "tar" fails - update to Windows 10, or update your Windows 10. Build 17063 at least.
curl.exe %url% -o %filename% -L
tar -xf %filename% 
DEL %filename%
ECHO Success!

set /p DUMMY=Hit ENTER to continue...