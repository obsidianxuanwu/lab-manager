@echo off
title Create Desktop Shortcut
cd /d "%~dp0"

if not exist "%~dp0create_desktop_shortcut.ps1" (
  echo.
  echo  [ERROR] create_desktop_shortcut.ps1 not found.
  echo          Keep this file in the same folder as the .ps1 file.
  echo.
  pause
  exit /b 1
)

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0create_desktop_shortcut.ps1"
if errorlevel 1 (
  echo.
  echo  [ERROR] Failed. Right-click this .bat and choose "Run as administrator",
  echo          or see the manual for the manual method.
  echo.
)
pause
