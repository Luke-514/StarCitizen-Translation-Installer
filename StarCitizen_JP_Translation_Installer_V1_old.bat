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

SET /P CHK="日本語化を実行しますか？ (yes/no)"

if /i %CHK%==yes (
  SET MODE=バックアップ
) else if /i %CHK%==y (
  SET MODE=バックアップ
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

SET /P CHK="LIVEかPTU、どちらを日本語化しますか？ (live/ptu)"

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

for /f "tokens=*" %%i in ('findstr /v "{ ( ) js: Error libraryFolder ." %APPDATA%\rsilauncher\logs\log.log ^| findstr "\\"') do SET LIBPATH=%%~i
SET LIBPATH=%LIBPATH:\\=\%
SET SCDIR="%LIBPATH%\StarCitizen\%PLYVER%"

SET LOCALEDIR=%SCDIR%\data\Localization\japanese_"(japan)"
SET GLOBALINIPATH=%LOCALEDIR%
SET USERCFGPATH=%SCDIR%\user.cfg

if not exist %GLOBALINIPATH% (
  if not exist global.ini (
    echo 日本語化ファイルが見つかりません。本バッチファイルと同じフォルダにglobal.iniを配置して、再度実行してください。
    pause
    EXIT
  ) else (
    mkdir %SCDIR%\data\Localization\japanese_"(japan)"
    copy /Y global.ini %GLOBALINIPATH% > nul
  )
) else (
  if not exist global.ini (
    echo 日本語化ファイルが見つかりません。本バッチファイルと同じフォルダにglobal.iniを配置して、再度実行してください。
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
      echo g_languageの設定をuser.cfgに追記できませんでした。処理を中止します。
      pause
      EXIT
    )
  )

) else (
  echo g_language = japanese_^(japan^) > %USERCFGPATH%
  echo g_languageAudio = english >> %USERCFGPATH%

  if not exist %USERCFGPATH% (
    echo user.cfgを作成できませんでした。処理を中止します。
    pause
    EXIT
  )
)

echo 処理が完了しました。

pause
EXIT