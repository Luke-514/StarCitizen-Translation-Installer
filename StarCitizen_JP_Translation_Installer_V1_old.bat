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
  SET MODE=�o�b�N�A�b�v
) else if /i %CHK%==y (
  SET MODE=�o�b�N�A�b�v
) else if /i %CHK%==no (
  echo �����𒆎~���܂�
  echo.
  pause
  EXIT
) else if /i %CHK%==n (
  echo �����𒆎~���܂�
  echo.
  pause
  EXIT
) else (
  echo.
  echo �\�����Ȃ����������͂���܂���
  echo �����𒆎~���܂�
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
  echo.
  echo �\�����Ȃ����������͂���܂���
  echo �����𒆎~���܂�
  echo.
  pause
  EXIT
)

for /f "tokens=*" %%i in ('findstr /v "{ ( ) js: Error libraryFolder ." %APPDATA%\rsilauncher\logs\log.log ^| findstr "\\"') do SET LIBPATH=%%~i
SET LIBPATH=%LIBPATH:\\=\%
SET SCDIR="%LIBPATH%\StarCitizen\%PLYVER%"

SET LOCALEDIR=%SCDIR%\data\Localization\japanese_"(japan)"
SET GLOBALINIPATH=%LOCALEDIR%
SET USERCFGPATH=%SCDIR%\user.cfg

if not exist %GLOBALINIPATH% (
  if not exist global.ini (
    echo ���{�ꉻ�t�@�C����������܂���B�{�o�b�`�t�@�C���Ɠ����t�H���_��global.ini��z�u���āA�ēx���s���Ă��������B
    pause
    EXIT
  ) else (
    mkdir %SCDIR%\data\Localization\japanese_"(japan)"
    copy /Y global.ini %GLOBALINIPATH% > nul
  )
) else (
  if not exist global.ini (
    echo ���{�ꉻ�t�@�C����������܂���B�{�o�b�`�t�@�C���Ɠ����t�H���_��global.ini��z�u���āA�ēx���s���Ă��������B
    pause
    EXIT
  ) else (
    copy /Y global.ini %GLOBALINIPATH% > nul
  )
)

if exist %USERCFGPATH% (

  findstr g_language %USERCFGPATH% > nul

  if !errorlevel! == 1 (
    echo. >> %USERCFGPATH%
    echo g_language = japanese_^(japan^) >> %USERCFGPATH%
    echo g_languageAudio = english >> %USERCFGPATH%

    if %errorlevel% == 1 (
      echo g_language�̐ݒ��user.cfg�ɒǋL�ł��܂���ł����B�����𒆎~���܂��B
      pause
      EXIT
    )
  )

) else (
  echo g_language = japanese_^(japan^) > %USERCFGPATH%
  echo g_languageAudio = english >> %USERCFGPATH%

  if not exist %USERCFGPATH% (
    echo user.cfg���쐬�ł��܂���ł����B�����𒆎~���܂��B
    pause
    EXIT
  )
)

echo �������������܂����B

pause
EXIT