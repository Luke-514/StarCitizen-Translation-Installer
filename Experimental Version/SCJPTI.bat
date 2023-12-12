@echo off
setlocal enabledelayedexpansion

if "%1" == "" (
  echo EXIT
  pause
  exit
)

SET PLYVER=%1

if not exist global.ini (
  SET "counter=0"
  curl -s https://api.github.com/repos/stdblue/StarCitizenJapaneseResources/releases --ssl-no-revoke | findstr "browser_download_url" | findstr "global.ini" > scjtdownload.lst

  for /f "tokens=2" %%A in (scjtdownload.lst) do (
      SET /a "counter+=1"
      if !counter! equ 1 (
          SET "url=%%~A"
          curl -s -L !url! -O --ssl-no-revoke
      )
  )

  del /Q scjtdownload.lst
)

for /f "tokens=*" %%i in ('findstr "libraryFolder" %APPDATA%\rsilauncher\logs\log.log') do SET LIBPATH=%%~i
SET LIBPATH=%LIBPATH:libraryFolder": "=%
SET LIBPATH=%LIBPATH:",=%
SET LIBPATH=%LIBPATH:\\=\%
SET SCDIR="%LIBPATH%\StarCitizen\%PLYVER%"

SET LOCALEDIR=%SCDIR%\data\Localization\japanese_"(japan)"
SET GLOBALINIPATH=%LOCALEDIR%
SET USERCFGPATH=%SCDIR%\user.cfg

if not exist %GLOBALINIPATH% (
  if not exist global.ini (
    exit 1
  ) else (
    mkdir %SCDIR%\data\Localization\japanese_"(japan)"
    move /Y global.ini %GLOBALINIPATH% > nul
  )
) else (
  if not exist global.ini (
    exit 1
  ) else (
    move /Y global.ini %GLOBALINIPATH% > nul
  )
)

if exist %USERCFGPATH% (

  findstr g_language %USERCFGPATH% > nul

  if !errorlevel! == 1 (
    echo.>> %USERCFGPATH%
    echo g_language = japanese_^(japan^)>> %USERCFGPATH%
    echo g_languageAudio = english>> %USERCFGPATH%

    if %errorlevel% == 1 (
      exit 2
    )
  )

) else (
  echo g_language = japanese_^(japan^)> %USERCFGPATH%
  echo g_languageAudio = english>> %USERCFGPATH%

  if not exist %USERCFGPATH% (
    exit 3
  )
)

exit 0