@echo off

echo --------------------------------------------------------------------------------------------------------------
echo �Ɛӎ���
echo �{�o�b�`�t�@�C���̎g�p�ɂ���Ĕ��������A�����Ȃ鑹�Q�ɑ΂��Ă���҂͈�؂̐ӔC�𕉂��܂���
echo.

echo ��� 
echo Luke514 Twitter:@rx_luke
echo --------------------------------------------------------------------------------------------------------------
echo.

setlocal enabledelayedexpansion

SET /P CHK="���{�ꉻ�����s���܂����H (yes/no)"

if /i %CHK%==yes (
  break
) else if /i %CHK%==y (
  break
) else if /i %CHK%==no (
  echo [Exit]�����𒆎~���܂�
  echo.
  pause
  EXIT
) else if /i %CHK%==n (
  echo [Exit]�����𒆎~���܂�
  echo.
  pause
  EXIT
) else (
  echo.
  echo [Error]�\�����Ȃ����������͂���܂����B�����𒆎~���܂��B
  echo.
  pause
  EXIT
)

SET /P CHK="LIVE��PTU�A�ǂ������{�ꉻ���܂����H (live/ptu)"

if /i %CHK%==live (
  SET PLYVER=LIVE
) else if /i %CHK%==l (
  SET PLYVER=LIVE
) else if /i %CHK%==ptu (
  SET PLYVER=PTU
) else if /i %CHK%==p (
  SET PLYVER=PTU
) else (
  echo [Error]�\�����Ȃ����������͂���܂����B�����𒆎~���܂��B
  echo.
  pause
  EXIT
)

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
    echo [Error]���{�ꉻ�t�@�C��������܂���B�����𒆎~���܂��B
    echo.
    pause
    EXIT
  ) else (
    mkdir %SCDIR%\data\Localization\japanese_"(japan)"
    move /Y global.ini %GLOBALINIPATH% > nul
  )
) else (
  if not exist global.ini (
    echo [Error]���{�ꉻ�t�@�C��������܂���B�����𒆎~���܂��B
    echo.
    pause
    EXIT
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
      echo [Error]�ݒ��user.cfg�ɒǋL�ł��܂���ł����B�����𒆎~���܂��B
      echo.
      pause
      EXIT
    )
  )

) else (
  echo g_language = japanese_^(japan^)> %USERCFGPATH%
  echo g_languageAudio = english>> %USERCFGPATH%

  if not exist %USERCFGPATH% (
    echo [Error]user.cfg���쐬�ł��܂���ł����B�����𒆎~���܂��B
    echo.
    pause
    EXIT
  )
)

echo [Success]�������������܂����B
echo.

pause
EXIT