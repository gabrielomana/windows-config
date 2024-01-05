#WinInstall
# Resto del script
trap {
    Write-Host "Error: $_"
}

#Extensiones de VSCODE
# Obtener la lista de extensiones instaladas
$extensionesInstaladas = & code --list-extensions
# Actualizar cada extensión
foreach ($extension in $extensionesInstaladas) {
    Write-Host "Actualizando la extensión: $extension"
    & code --install-extension $extension --force
}

# Módulos de PowerShell
# Obtener la lista de módulos instalados
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
$modulosInstalados = Get-Module -ListAvailable | Select-Object -ExpandProperty Name
# Actualizar cada módulo si está instalado y no es un módulo de sistema
foreach ($modulo in $modulosInstalados) {   
    # Verificar si el módulo está instalado y no es un módulo de sistema
    if (Get-Module -ListAvailable -Name $modulo -ErrorAction SilentlyContinue | Where-Object { $_.Path -notlike '*\System32\WindowsPowerShell\' }) {
        try {
            Update-Module -Name $modulo -Force -ErrorAction Stop
            Write-Host "Módulo actualizado con éxito: $modulo"
        }
        catch {
            # No mostramos mensaje para módulos que no se pueden actualizar
        }
    }
    else {
        # No mostramos mensaje para módulos de sistema
    }
}

# #PIP
# # Actualizar Python y paquetes instalados con Pip
# Write-Host "Actualizando Python y paquetes instalados con Pip..."
# & python -m pip install --upgrade pip setuptools

# # Obtener la lista de paquetes instalados
# $paquetesInstalados = & pip freeze | ForEach-Object { $_ -split '==' | Select-Object -First 1 }

# # Actualizar cada paquete
# foreach ($paquete in $paquetesInstalados) {
#     Write-Host "Actualizando paquete: $paquete"
#     & python -m pip install --upgrade $paquete
# }

# #SCOOP
# # Actualizar aplicaciones instaladas con Scoop
# Write-Host "Actualizando aplicaciones instaladas con Scoop..."
# & scoop update

###CLEAN###
# Obtener la ruta al directorio AppData
$appDataPath = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::ApplicationData)
# Obtener la ruta al directorio superior (un nivel arriba)
$parentDirectory = Split-Path $appDataPath -Parent
# Combinar la ruta al directorio superior con la ruta relativa al directorio BleachBit
$bleachBitDirectory = Join-Path $parentDirectory 'Local\BleachBit'
# Cambiar al directorio BleachBit
Set-Location $bleachBitDirectory
# Ejecutar el comando BleachBit
Start-Process -FilePath ".\bleachbit_console.exe" -ArgumentList "--clean", "--preset", "--no-uac" -Wait

###END###
# Esperar 5 segundos
Start-Sleep -Seconds 5

# Cerrar la ventana de la consola
Stop-Process -Id $PID


