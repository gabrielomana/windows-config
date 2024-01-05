function Install-Terminal{
    ####WINDOWS TERMINAL + OH MY POSH####

## Windows Terminal Configuration:
    # Install Windows Terminal
    winget install --id=Microsoft.WindowsTerminal --accept-source-agreements --accept-package-agreements --silent -e
    winget install --id=Microsoft.PowerShell --accept-source-agreements --accept-package-agreements --silent -e

    # Import additional PowerShell modules
    Import-Module -Name Terminal-Icons
    Import-Module PSReadLine

    # PSReadLine configurations
    Set-PSReadLineOption -PredictionViewStyle ListView
    Set-PSReadLineOption -EditMode Windows

## Oh My Posh and Nerd Font 
    # Install Oh My Posh
        winget install JanDeDobbeleer.OhMyPosh -s winget --accept-source-agreements --accept-package-agreements --silent -e

    # Install Nerd Font
        $fontUrl = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Hack.zip"
        oh-my-posh font install $fontUrl

##Terminal Configuration and Oh My Posh Theme
    # Configure Windows Terminal
        # Download Windows Terminal configuration
        $configUrl = "https://github.com/gabrielomana/windows-config/raw/main/data/settings.json"
        $tempConfigPath = "$env:TEMP\settings.json"
        Invoke-WebRequest -Uri $configUrl -OutFile $tempConfigPath
        # Get the dynamic destination folder of Windows Terminal
        $terminalConfigFolder = (Get-Item "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_*").FullName
        # Combine the destination folder with the configuration file name
        $terminalConfigPath = Join-Path -Path $terminalConfigFolder -ChildPath 'LocalState\settings.json'
        # Copy the configuration to the destination folder in Windows Terminal
        Copy-Item -Path $tempConfigPath -Destination $terminalConfigPath -Force
        # Clean up the temporary file after installation
        Remove-Item $tempConfigPath -Force

    # Define the URL and destination path for the Oh My Posh theme
        # Download the Oh My Posh theme
        $themeUrl = "https://github.com/gabrielomana/windows-config/raw/main/data/night-owl_2.omp.json"
        $themePath = "$env:LOCALAPPDATA\Programs\oh-my-posh\themes\night-owl_2.omp.json"
        Invoke-WebRequest -Uri $themeUrl -OutFile $themePath -ErrorAction Stop
        # Run oh-my-posh to initialize with the new theme
        oh-my-posh init pwsh --config $themePath | Invoke-Expression

Write-Host "Night Owl 2 theme downloaded, saved, and set as the default theme in Oh My Posh."

##PowerShell Profile Configuration
    # Check if the PowerShell profile file exists
        if (!(Test-Path $PROFILE -PathType Leaf)) {
            # If the file doesn't exist, create a new one
            New-Item -Path $PROFILE -Type File -Force
            Write-Host "PowerShell profile file created successfully."
        }
    # Download and save a PowerShell profile file to a generic destination
        # Download the PowerShell profile file
        $fileUrl = "https://raw.githubusercontent.com/gabrielomana/windows-config/main/data/Microsoft.PowerShell_profile.ps1"
        $tempFilePath = "$env:TEMP\Microsoft.PowerShell_profile.ps1"
        $genericDestinationFolder = "$env:USERPROFILE\Documents\PowerShell"
        $destinationPath = Join-Path -Path $genericDestinationFolder -ChildPath "Microsoft.PowerShell_profile.ps1"
        Invoke-WebRequest -Uri $fileUrl -OutFile $tempFilePath

        # Create the generic destination folder if it doesn't exist
        if (-not (Test-Path -Path $genericDestinationFolder -PathType Container)) {
            New-Item -ItemType Directory -Path $genericDestinationFolder -Force
        }

        # Copy the file to the destination folder, overwriting if it already exists
        Copy-Item -Path $tempFilePath -Destination $destinationPath -Force

        # Clean up the temporary file after the download
        Remove-Item $tempFilePath -Force

Write-Host "The file Microsoft.PowerShell_profile.ps1 has been downloaded and saved to $destinationPath."
}
  
function Install-VSCode {
    if (-not (Test-Path "$env:LOCALAPPDATA\Microsoft\WindowsApps\node.exe")) {
        # Descargar e instalar Node.js
        Write-Host "Instalando Node.js"
        Invoke-WebRequest -Uri "https://nodejs.org/dist/latest/win-x64/node.exe" -OutFile "$env:LOCALAPPDATA\Programs\nodejs\node.exe"
    }

    # Comprobar si JetBrains Mono Nerd Font está instalada
    $fontFolder = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts"
    $fontPath = Join-Path $fontFolder "JetBrainsMono NF.ttf"

    # Buscar cualquier archivo con nombre que comience por "JetBrains" en la carpeta de fuentes (insensible a mayúsculas/minúsculas)
    $jetbrainsFonts = Get-ChildItem -Path $fontFolder -Filter 'JetBrains*' -File | Where-Object { $_.Name -like 'JetBrains*' }

    if ($jetbrainsFonts.Count -eq 0) {
        # Descargar e instalar JetBrains Mono Nerd Font
        Write-Host "Instalando JetBrains Mono Nerd Font"
        $fontZipUrl = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip"
        Invoke-WebRequest -Uri $fontZipUrl -OutFile "$env:TEMP\JetBrainsMono.zip" -ErrorAction Stop
        Expand-Archive -Path "$env:TEMP\JetBrainsMono.zip" -DestinationPath "$env:TEMP" -ErrorAction Stop
        Move-Item -Path "$env:TEMP\JetBrainsMono NF.ttf" -Destination $fontPath -ErrorAction Stop
        Remove-Item -Path "$env:TEMP\JetBrainsMono.zip" -Force -ErrorAction Stop

        Write-Host "Fuente JetBrains Mono Nerd Font instalada correctamente."
    }

    # Configurar las preferencias de Visual Studio Code (incluyendo la fuente JetBrains Mono Nerd Font)
    $configContent = @{
        "prettier.printWidth" = 80
        "editor.lineHeight" = 24
        "editor.formatOnSave" = $true
        "prettier.jsxSingleQuote" = $true
        "editor.fontSize" = 14
        "editor.defaultFormatter" = "esbenp.prettier-vscode"
        "editor.fontFamily" = '"JetBrainsMono Nerd Font", Consolas, monospace,"Segoe UI Emoji", "Segoe UI Symbol","Noto Color Emoji"'
        "prettier.trailingComma" = "all"
        "editor.fontWeight" = "400"
        "prettier.singleQuote" = $true
        "workbench.colorTheme" = "One Monokai"
        "editor.fontLigatures" = $true
        "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font"
    }

    $configContent | ConvertTo-Json | Set-Content "$env:APPDATA\Code\User\settings.json" -Force

    # Comprobar si las extensiones ya están instaladas antes de intentar instalarlas nuevamente
    $installedExtensions = code --list-extensions
    $extensions = @(
        "azemoh.one-monokai",
        "NarasimaPandiyan.jetbrainsmono",
        "vscode-icons-team.vscode-icons",
        "ZainChen.json",
        "shakram02.bash-beautify",
        "KevinRose.vsc-python-indent",
        #"hb432.prettier-eslint-typescript",
        "bodil.prettier-toml",
        "be5invis.toml",
        "ms-vscode.powershell",
        "formulahendry.auto-close-tag",
        "streetsidesoftware.code-spell-checker",
        "esbenp.prettier-vscode"
    )

    foreach ($extension in $extensions) {
        if ($installedExtensions -notcontains $extension) {
            code --install-extension $extension
        } 
    }

    Write-Host "Visual Studio Code instalado correctamente."
}

function Install-Vokoscreen {
    # Definir la URL del repositorio en GitHub
    $repoUrl = 'https://api.github.com/repos/vkohaupt/vokoscreenNG/releases/latest'

    try {
        # Realizar la solicitud a la API de GitHub
        $response = Invoke-RestMethod -Uri $repoUrl -ErrorAction Stop

        # Extraer la versión más reciente
        $latestVersion = $response.tag_name

        # Construir la URL de descarga
        $downloadUrl = "https://github.com/vkohaupt/vokoscreenNG/releases/download/$latestVersion/vokoscreenNG-$latestVersion-win64.exe"

        # Definir la ubicación de destino (por ejemplo, la carpeta temporal)
        $destination = Join-Path $env:TEMP 'VokoscreenNG.exe'

        # Descargar el archivo .exe
        Invoke-WebRequest -Uri $downloadUrl -OutFile $destination -ErrorAction Stop

        # Instalar la aplicación
        Start-Process -FilePath $destination -ArgumentList '/S' -Wait

        # Eliminar el archivo descargado después de la instalación
        Remove-Item -Path $destination -Force
    }
    catch {
        Write-Warning "Error al obtener la última versión de VokoscreenNG desde GitHub."
        Write-Warning $_.Exception.Message
    }
}

function Install-TaskUpgrade {
  # Crear carpeta en C:\ llamada UpgradeApps
New-Item -ItemType Directory -Path "C:\UpgradeApps" -Force

# Descargar archivos desde GitHub y guardarlos en la carpeta
Invoke-WebRequest -Uri "https://github.com/gabrielomana/windows-config/raw/main/data/upgrade_apps_win.bat" -OutFile "C:\UpgradeApps\upgrade_apps_win.bat"
Invoke-WebRequest -Uri "https://github.com/gabrielomana/windows-config/raw/main/data/post_upgrade.ps1" -OutFile "C:\UpgradeApps\post_upgrade.ps1"

# Dar permisos de ejecución a la carpeta y a los archivos
Get-ChildItem "C:\UpgradeApps\" | ForEach-Object { $_.IsReadOnly = $false }
Get-ChildItem "C:\UpgradeApps\upgrade_apps_win.bat" | ForEach-Object { $_.IsReadOnly = $false }
Get-ChildItem "C:\UpgradeApps\post_upgrade.ps1" | ForEach-Object { $_.IsReadOnly = $false }

# Obtener el nombre del usuario actual
$userName = $env:USERNAME

# Obtener el SID (Security Identifier) del usuario actual
$userSID = (New-Object System.Security.Principal.NTAccount($env:USERNAME)).Translate([System.Security.Principal.SecurityIdentifier]).Value

# Contenido del XML
$xmlContent = @"
<?xml version="1.0" encoding="UTF-16"?>
<Task version="1.4" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
  <RegistrationInfo>
    <Date>2024-01-05T15:51:51.4667619</Date>
    <Author>$userName</Author>
    <URI>\UpgradeAppsTask</URI>
  </RegistrationInfo>
  <Triggers>
    <CalendarTrigger>
      <StartBoundary>2024-01-05T14:30:00</StartBoundary>
      <Enabled>true</Enabled>
      <ScheduleByWeek>
        <DaysOfWeek>
          <Monday />
        </DaysOfWeek>
        <WeeksInterval>1</WeeksInterval>
      </ScheduleByWeek>
    </CalendarTrigger>
  </Triggers>
  <Principals>
    <Principal id="Author">
      <UserId>$userSID</UserId>
      <LogonType>InteractiveToken</LogonType>
      <RunLevel>HighestAvailable</RunLevel>
    </Principal>
  </Principals>
  <Settings>
    <MultipleInstancesPolicy>IgnoreNew</MultipleInstancesPolicy>
    <DisallowStartIfOnBatteries>true</DisallowStartIfOnBatteries>
    <StopIfGoingOnBatteries>true</StopIfGoingOnBatteries>
    <AllowHardTerminate>true</AllowHardTerminate>
    <StartWhenAvailable>false</StartWhenAvailable>
    <RunOnlyIfNetworkAvailable>false</RunOnlyIfNetworkAvailable>
    <IdleSettings>
      <Duration>PT10M</Duration>
      <WaitTimeout>PT30M</WaitTimeout>
      <StopOnIdleEnd>false</StopOnIdleEnd>
      <RestartOnIdle>false</RestartOnIdle>
    </IdleSettings>
    <AllowStartOnDemand>true</AllowStartOnDemand>
    <Enabled>true</Enabled>
    <Hidden>false</Hidden>
    <RunOnlyIfIdle>true</RunOnlyIfIdle>
    <DisallowStartOnRemoteAppSession>false</DisallowStartOnRemoteAppSession>
    <UseUnifiedSchedulingEngine>true</UseUnifiedSchedulingEngine>
    <WakeToRun>false</WakeToRun>
    <ExecutionTimeLimit>PT0S</ExecutionTimeLimit>
    <Priority>7</Priority>
  </Settings>
  <Actions Context="Author">
    <Exec>
      <Command>C:\UpgradeApps\upgrade_apps_win.bat</Command>
    </Exec>
    <Exec>
      <Command>powershell.exe</Command>
      <Arguments>-NoProfile -ExecutionPolicy Bypass -File "C:\UpgradeApps\post_upgrade.ps1" -WindowStyle Minimized</Arguments>
      <WorkingDirectory>C:\UpgradeApps\</WorkingDirectory>
    </Exec>
  </Actions>
</Task>
"@


# Ruta para el archivo XML
$taskPath = "C:\UpgradeApps\UpgradeTask.xml"

# Borrar la tarea programada si ya existe
schtasks /delete /tn "UpgradeAppsTask" /f

# Crear tarea programada desde el contenido del XML
$xmlContent | Out-File -FilePath $taskPath -Encoding UTF8
schtasks /create /XML $taskPath /TN "UpgradeAppsTask"

# Borrar el archivo XML si existe
Remove-Item -Path $taskPath -ErrorAction SilentlyContinue
}

function clean_pc{
# Clean
RefreshEnv
Set-Location 'C:\Program Files (x86)\Glary Utilities'
.\DiskCleaner.exe
.\OneClickMaintenance.exe
}