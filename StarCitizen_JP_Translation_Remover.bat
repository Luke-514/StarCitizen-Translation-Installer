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

SET /P CHK="���{�ꉻ���������܂����H (yes/no)"

if /i %CHK%==yes (
  break
) else if /i %CHK%==y (
  break
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

SET /P CHK="LIVE��PTU�A�ǂ���̓��{�ꉻ���������܂����H (live/ptu)"

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

for /f "tokens=*" %%i in ('findstr "libraryFolder" %APPDATA%\rsilauncher\logs\log.log') do SET LIBPATH=%%~i
SET LIBPATH=%LIBPATH:libraryFolder": "=%
SET LIBPATH=%LIBPATH:",=%
SET LIBPATH=%LIBPATH:\\=\%
SET SCDIR="%LIBPATH%\StarCitizen\%PLYVER%"

SET LOCALEDIR=%SCDIR%\data\Localization\japanese_"(japan)"
SET GLOBALINIPATH=%LOCALEDIR%
SET USERCFGPATH=%SCDIR%\user.cfg

if exist %USERCFGPATH% (

  findstr /v "g_language" %USERCFGPATH%> user_cfg.tmp
  move user_cfg.tmp %USERCFGPATH% > nul

  if !errorlevel! == 1 (
    echo ���{�ꉻ�̉������ł��܂���ł����B�����𒆎~���܂��B
    pause
    EXIT
  )
) else (
  echo ���{�ꉻ����Ă��܂���B�����𒆎~���܂��B
  pause
  EXIT
)

echo �������������܂����B

pause
EXIT