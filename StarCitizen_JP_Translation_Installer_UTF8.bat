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
  break
) else if /i %CHK%==y (
  break
) else if /i %CHK%==no (
  echo.
  echo [Exit]処理を中止します
  pause
  EXIT
) else if /i %CHK%==n (
  echo.
  echo [Exit]処理を中止します
  pause
  EXIT
) else (
  echo.
  echo [Error]予期しない文字が入力されました。処理を中止します。
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
  echo [Error]予期しない文字が入力されました。処理を中止します。
  pause
  EXIT
)

if not exist global.ini (
  curl -s https://api.github.com/repos/stdblue/StarCitizenJapaneseResources/releases/latest --ssl-no-revoke | findstr "browser_download_url" | findstr "global.ini" > scjtdownload.lst
  for /f "tokens=2" %%A in (scjtdownload.lst) do (
    SET "url=%%~A"
    curl -s -L !url! -O --ssl-no-revoke
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
    echo.
    echo [Error]日本語化ファイルがありません。処理を中止します。
    pause
    EXIT
  ) else (
    mkdir %SCDIR%\data\Localization\japanese_"(japan)"
    move /Y global.ini %GLOBALINIPATH% > nul
  )
) else (
  if not exist global.ini (
    echo.
    echo [Error]日本語化ファイルがありません。処理を中止します。
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
      echo.
      echo [Error]設定をuser.cfgに追記できませんでした。処理を中止します。
      pause
      EXIT
    )
  )

) else (
  echo g_language = japanese_^(japan^)> %USERCFGPATH%
  echo g_languageAudio = english>> %USERCFGPATH%

  if not exist %USERCFGPATH% (
    echo.
    echo [Error]user.cfgを作成できませんでした。処理を中止します。
    pause
    EXIT
  )
)

echo.
echo [Success]処理が完了しました。
pause
EXIT