@echo off

echo --------------------------------------------------------------------------------------------------------------
echo 免責事項
echo 本バッチファイルの使用によって発生した、いかなる損害に対しても作者は一切の責任を負いません
echo.

echo 作者 
echo Luke514 Twitter:@rx_luke
echo --------------------------------------------------------------------------------------------------------------
echo.

setlocal enabledelayedexpansion

SET /P CHK="日本語化を解除しますか？ (yes/no)"

if /i %CHK%==yes (
  break
) else if /i %CHK%==y (
  break
) else if /i %CHK%==no (
  echo 処理を中止します
  echo.
  pause
  EXIT
) else if /i %CHK%==n (
  echo 処理を中止します
  echo.
  pause
  EXIT
) else (
  echo.
  echo 予期しない文字が入力されました
  echo 処理を中止します
  echo.
  pause
  EXIT
)

SET /P CHK="LIVEかPTU、どちらの日本語化を解除しますか？ (live/ptu)"

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
  echo 予期しない文字が入力されました
  echo 処理を中止します
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
    echo 日本語化の解除ができませんでした。処理を中止します。
    pause
    EXIT
  )
) else (
  echo 日本語化されていません。処理を中止します。
  pause
  EXIT
)

echo 処理が完了しました。

pause
EXIT