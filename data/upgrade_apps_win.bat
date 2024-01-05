@echo off
REM Actualizar orígenes de winget
winget source update

REM Actualizar todos los paquetes conocidos
winget upgrade --all --include-unknown --accept-source-agreements --accept-package-agreements --silent --force -e

:: Actualizar paquetes con Chocolatey
choco upgrade all --ignore-checksums --accept-license -y

:: Abrir PowerShell con privilegios de administrador y ejecutar el script post_upgrade.ps1
