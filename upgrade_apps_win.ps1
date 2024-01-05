#WinInstall
winget source update
# winget upgrade --all --include-unknown --accept-source-agreements --accept-package-agreements --silent --force -e

winget upgrade --id=Mozilla.Firefox --accept-source-agreements --accept-package-agreements --silent -e
winget upgrade --id=Brave.Brave --accept-source-agreements --accept-package-agreements --silent -e
winget upgrade --id=Google.Chrome --accept-source-agreements --accept-package-agreements --silent -e
winget upgrade --id=Adobe.Acrobat.Reader.64-bit --accept-source-agreements --accept-package-agreements --silent -e
winget upgrade --id=AcroSoftware.CutePDFWriter --accept-source-agreements --accept-package-agreements --silent -e
winget upgrade --id=TheDocumentFoundation.LibreOffice --accept-source-agreements --accept-package-agreements --silent -e
winget upgrade --id=Notepad++.Notepad++ --accept-source-agreements --accept-package-agreements --silent -e

winget upgrade --id=PuTTY.PuTTY --accept-source-agreements --accept-package-agreements --silent -e
winget upgrade --id=WinMerge.WinMerge --accept-source-agreements --accept-package-agreements --silent -e
winget upgrade --id=CodecGuide.K-LiteCodecPack.Full --accept-source-agreements --accept-package-agreements --silent -e
winget upgrade --id=VideoLAN.VLC --accept-source-agreements --accept-package-agreements --silent -e
winget upgrade --id=Audacity.Audacity --accept-source-agreements --accept-package-agreements --silent -e
winget upgrade --id=th-ch.YouTubeMusic --accept-source-agreements --accept-package-agreements --silent -e
winget upgrade --id=Microsoft.DotNet.Framework.DeveloperPack_4 --accept-source-agreements --accept-package-agreements --silent -e
winget upgrade --id=Microsoft.DotNet.Runtime.7 --accept-source-agreements --accept-package-agreements --silent -e
winget upgrade --id=Microsoft.DotNet.Runtime.6 --accept-source-agreements --accept-package-agreements --silent -e
winget upgrade --id=Microsoft.DotNet.Runtime.5 --accept-source-agreements --accept-package-agreements --silent -e
winget upgrade --id=Microsoft.DotNet.Runtime.3_1 --accept-source-agreements --accept-package-agreements --silent -e
winget upgrade --id=7zip.7zip --accept-source-agreements --accept-package-agreements --silent -e
winget upgrade --id=RARLab.WinRAR --accept-package-agreements --silent -e
winget upgrade --id=Greenshot.Greenshot --accept-source-agreements --accept-package-agreements --silent -e
winget upgrade --id=ShareX.ShareX --accept-source-agreements --accept-package-agreements --silent -e
winget upgrade --id=CodeSector.TeraCopy --accept-source-agreements --accept-package-agreements --silent -e
winget upgrade --id=JohnsBackgroundSwitcher --accept-source-agreements --accept-package-agreements --silent -e
winget upgrade --id=Google.Drive --accept-source-agreements --accept-package-agreements --silent -e
winget upgrade --id=WhatsApp.WhatsApp --accept-source-agreements --accept-package-agreements --silent -e
winget upgrade --id=qBittorrent.qBittorrent --accept-source-agreements --accept-package-agreements --silent -e
winget upgrade --id=RevoUninstaller.RevoUninstaller --accept-source-agreements --accept-package-agreements --silent -e
winget upgrade --id=XBMCFoundation.Kodi --accept-source-agreements --accept-package-agreements --silent -e
winget upgrade --id=Mega.MEGASync --accept-source-agreements --accept-package-agreements --silent -e
winget upgrade --id=Oracle.VirtualBox --accept-source-agreements --accept-package-agreements --silent -e
winget upgrade --id=Microsoft.WindowsTerminal --accept-source-agreements --accept-package-agreements --silent -e

#Choco
choco upgrade all --ignore-checksums  --accept-license -y

#Extensiones de VSCODE
# Obtener la lista de extensiones instaladas
$extensionesInstaladas = code --list-extensions
# Actualizar cada extensión
foreach ($extension in $extensionesInstaladas) {
    Write-Host "Actualizando la extensión: $extension"
    code --install-extension $extension --force
}

# Módulos de PowerShell
# Obtener la lista de módulos instalados
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

#PIP
# Actualizar Python y paquetes instalados con Pip
Write-Host "Actualizando Python y paquetes instalados con Pip..."

# Actualizar Pip y setuptools
python -m pip install --upgrade pip setuptools

# Obtener la lista de paquetes instalados
$paquetesInstalados = pip list --format=freeze | ForEach-Object { $_ -split '==' | Select-Object -First 1 }

# Actualizar cada paquete
foreach ($paquete in $paquetesInstalados) {
    Write-Host "Actualizando paquete: $paquete"
    python -m pip install --upgrade $paquete
}

#SCOOP
# Actualizar aplicaciones instaladas con Scoop
Write-Host "Actualizando aplicaciones instaladas con Scoop..."
# Actualizar Scoop
scoop update
# Obtener la lista de aplicaciones instaladas con Scoop
$aplicacionesInstaladas = scoop list
# Actualizar cada aplicación
foreach ($aplicacion in $aplicacionesInstaladas) {
    Write-Host "Actualizando aplicación: $aplicacion"
    scoop update $aplicacion
}


