@echo off
title EcoSmart City - Frontend and Backend Launcher
color 0A

echo ============================================================
echo     EcoSmart City - Start Frontend and Node Backend
echo ============================================================
echo Starting frontend and backend in separate command windows...

n
echo.
start "Smart Backend" cmd /k "cd /d "%~dp0backend" && npm install && npm run dev"
echo Backend window opened.
start "Smart Frontend" cmd /k "cd /d "%~dp0frontend" && if not exist node_modules (npm install) && npm run dev"
echo Frontend window opened.
echo.
echo Open browser at http://localhost:3000
echo.
exit
