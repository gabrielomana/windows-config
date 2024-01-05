function WPFEssTweaksOO {
    try {
        # Descargar la configuración de O&O ShutUp10
        $ooConfigURL = "https://github.com/gabrielomana/windows-config/raw/main/data/ooshutup10_settings.cfg"
        $ooConfigPath = "$ENV:temp\ooshutup10.cfg"
        Invoke-WebRequest -Uri $ooConfigURL -OutFile $ooConfigPath -UseBasicParsing

        # Descargar O&O ShutUp10
        $ooDownloadURL = "https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe"
        $ooDownloadPath = "$ENV:temp\OOSU10.exe"
        Invoke-WebRequest -Uri $ooDownloadURL -OutFile $ooDownloadPath -UseBasicParsing

        # Ejecutar O&O ShutUp10 con la configuración descargada
        Start-Process $ooDownloadPath -ArgumentList "`"$ooConfigPath`" /quiet" -Wait

        Write-Host "Ajustes de optimización aplicados exitosamente con O&O ShutUp10."
    } catch {
        Write-Host "Error durante la ejecución de WPFEssTweaksOO: $_"
    }
}

function WPFEssTweaksTele {
    try {
        # Deshabilitar tareas programadas
        $scheduledTasks = @(
            "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser",
            "Microsoft\Windows\Application Experience\ProgramDataUpdater",
            "Microsoft\Windows\Autochk\Proxy",
            "Microsoft\Windows\Customer Experience Improvement Program\Consolidator",
            "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip",
            "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector",
            "Microsoft\Windows\Feedback\Siuf\DmClient",
            "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload",
            "Microsoft\Windows\Windows Error Reporting\QueueReporting",
            "Microsoft\Windows\Application Experience\MareBackup",
            "Microsoft\Windows\Application Experience\StartupAppTask",
            "Microsoft\Windows\Application Experience\PcaPatchDbTask",
            "Microsoft\Windows\Maps\MapsUpdateTask"
        )

        foreach ($task in $scheduledTasks) {
            Unregister-ScheduledTask -TaskPath "\" -TaskName $task -Confirm:$false -ErrorAction SilentlyContinue
        }

        # Modificar valores en el registro
        $registrySettings = @(
            "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection\AllowTelemetry",
            "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection\AllowTelemetry",
            "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\ContentDeliveryAllowed",
            "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\OemPreInstalledAppsEnabled",
            "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\PreInstalledAppsEnabled",
            "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\PreInstalledAppsEverEnabled",
            "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SilentInstalledAppsEnabled",
            "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SubscribedContent-338387Enabled",
            "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SubscribedContent-338388Enabled",
            "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SubscribedContent-338389Enabled",
            "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SubscribedContent-353698Enabled",
            "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SystemPaneSuggestionsEnabled",
            "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent\DisableWindowsConsumerFeatures",
            "HKCU:\SOFTWARE\Microsoft\Siuf\Rules\NumberOfSIUFInPeriod",
            "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection\DoNotShowFeedbackNotifications",
            "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent\DisableTailoredExperiencesWithDiagnosticData",
            "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo\DisabledByGroupPolicy",
            "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting\Disabled",
            "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config\DODownloadMode",
            "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance\fAllowToGetHelp",
            "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager\EnthusiastMode",
            "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ShowTaskViewButton",
            "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People\PeopleBand",
            "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\LaunchTo",
            "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem\LongPathsEnabled",
            "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching\SearchOrderConfig",
            "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\SystemResponsiveness",
            "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\NetworkThrottlingIndex",
            "HKCU:\Control Panel\Desktop\MenuShowDelay",
            "HKCU:\Control Panel\Desktop\AutoEndTasks",
            "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\ClearPageFileAtShutdown",
            "HKLM:\SYSTEM\ControlSet001\Services\Ndu\Start",
            "HKCU:\Control Panel\Mouse\MouseHoverTime",
            "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters\IRPStackSize",
            "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds\EnableFeeds",
            "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds\ShellFeedsTaskbarViewMode",
            "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\HideSCAMeetNow",
            "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games\GPU Priority",
            "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games\Priority",
            "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games\Scheduling Category"
        )

        foreach ($setting in $registrySettings) {
            if (Test-Path $setting) {
                Set-ItemProperty -Path $setting -Name $setting.Name -Value $setting.Value -Type $setting.Type -Force
            }
        }

        # Ejecutar scripts mediante InvokeScript
        Invoke-Expression @"
            bcdedit /set `{current`} bootmenupolicy Legacy | Out-Null
            If ((Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name CurrentBuild).CurrentBuild -lt 22557) {
                $taskmgr = Start-Process -WindowStyle Hidden -FilePath taskmgr.exe -PassThru
                Do {
                    Start-Sleep -Milliseconds 100
                    $preferences = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager" -Name "Preferences" -ErrorAction SilentlyContinue
                } Until ($preferences -ne $null)
                Stop-Process $taskmgr
                $preferences.Preferences[28] = 0
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager" -Name "Preferences" -Type Binary -Value $preferences.Preferences
            }
            Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Recurse -ErrorAction SilentlyContinue

            # Fix Managed by your organization in Edge if regustry path exists then remove it

            If (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge") {
                Remove-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Recurse -ErrorAction SilentlyContinue
            }

            # Group svchost.exe processes
            $ram = (Get-CimInstance -ClassName Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1kb
            Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "SvcHostSplitThresholdInKB" -Type DWord -Value $ram -Force

            $autoLoggerDir = "$env:PROGRAMDATA\Microsoft\Diagnosis\ETLLogs\AutoLogger"
            If (Test-Path "$autoLoggerDir\AutoLogger-Diagtrack-Listener.etl") {
                Remove-Item "$autoLoggerDir\AutoLogger-Diagtrack-Listener.etl"
            }
            icacls $autoLoggerDir /deny SYSTEM:(OI)(CI)F | Out-Null

            # Disable Defender Auto Sample Submission
            Set-MpPreference -SubmitSamplesConsent 2 -ErrorAction SilentlyContinue
"@
        
        Write-Host "Ajustes de optimización aplicados exitosamente con WPFEssTweaksTele."
    } catch {
        Write-Host "Error durante la ejecución de WPFEssTweaksTele: $_"
    }
}

function WPFEssTweaksWifi {
    try {
        # Modificar valores en el registro para ajustes de WiFi
        $wifiRegistrySettings = @(
            @{
                Path          = "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting"
                Name          = "Value"
                Type          = "DWord"
                Value         = 0
                OriginalValue = 1
            },
            @{
                Path          = "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots"
                Name          = "Value"
                Type          = "DWord"
                Value         = 0
                OriginalValue = 1
            }
        )

        foreach ($setting in $wifiRegistrySettings) {
            if (Test-Path $setting.Path) {
                Set-ItemProperty -Path $setting.Path -Name $setting.Name -Value $setting.Value -Type $setting.Type -Force
            }
        }

        Write-Host "Ajustes de optimización de WiFi aplicados exitosamente con WPFEssTweaksWifi."
    } catch {
        Write-Host "Error durante la ejecución de WPFEssTweaksWifi: $_"
    }
}


function WPFEssTweaksLoc {
    try {
        # Modificar valores en el registro para ajustes de ubicación
        $locRegistrySettings = @(
            @{
                Path          = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location"
                Name          = "Value"
                Type          = "String"
                Value         = "Deny"
                OriginalValue = "Allow"
            },
            @{
                Path          = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}"
                Name          = "SensorPermissionState"
                Type          = "DWord"
                Value         = 0
                OriginalValue = 1
            },
            @{
                Path          = "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration"
                Name          = "Status"
                Type          = "DWord"
                Value         = 0
                OriginalValue = 1
            },
            @{
                Path          = "HKLM:\SYSTEM\Maps"
                Name          = "AutoUpdateEnabled"
                Type          = "DWord"
                Value         = 0
                OriginalValue = 1
            }
        )

        foreach ($setting in $locRegistrySettings) {
            if (Test-Path $setting.Path) {
                Set-ItemProperty -Path $setting.Path -Name $setting.Name -Value $setting.Value -Type $setting.Type -Force
            }
        }

        Write-Host "Ajustes de optimización de ubicación aplicados exitosamente con WPFEssTweaksLoc."
    } catch {
        Write-Host "Error durante la ejecución de WPFEssTweaksLoc: $_"
    }
}


function WPFEssTweaksHome {
    try {
        # Ajustar la configuración de servicios relacionados con HomeGroup
        $homeServices = @(
            @{
                Name          = "HomeGroupListener"
                StartupType   = "Manual"
                OriginalType  = "Automatic"
            },
            @{
                Name          = "HomeGroupProvider"
                StartupType   = "Manual"
                OriginalType  = "Automatic"
            }
        )

        foreach ($service in $homeServices) {
            $serviceName = $service.Name
            $startupType = $service.StartupType

            # Verificar si el servicio está presente
            $serviceExists = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
            if ($serviceExists) {
                # Modificar el tipo de inicio del servicio
                Set-Service -Name $serviceName -StartupType $startupType -ErrorAction SilentlyContinue
            }
        }

        Write-Host "Ajustes de optimización de servicios HomeGroup aplicados exitosamente con WPFEssTweaksHome."
    } catch {
        Write-Host "Error durante la ejecución de WPFEssTweaksHome: $_"
    }
}

function WPFEssTweaksStorage {
    try {
        # Script para ajustar la configuración de StorageSense
        $invokeScript = {
            Remove-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Recurse -ErrorAction SilentlyContinue
        }

        # Script para deshacer los cambios en la configuración de StorageSense
        $undoScript = {
            New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Force | Out-Null
        }

        # Ejecutar el script para ajustar la configuración de StorageSense
        Invoke-Command -ScriptBlock $invokeScript

        # Puedes usar el script de deshacer si es necesario revertir los cambios
        # Invoke-Command -ScriptBlock $undoScript

        Write-Host "Ajustes de optimización de StorageSense aplicados exitosamente con WPFEssTweaksStorage."
    } catch {
        Write-Host "Error durante la ejecución de WPFEssTweaksStorage: $_"
    }
}


function WPFEssTweaksHiber {
    try {
        # Cambios en el registro para deshabilitar la hibernación
        $registryChanges = @(
            @{
                Path          = "HKLM:\System\CurrentControlSet\Control\Session Manager\Power"
                Name          = "HibernateEnabled"
                Type          = "DWord"
                Value         = 0
                OriginalValue = 1
            },
            @{
                Path          = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings"
                Name          = "ShowHibernateOption"
                Type          = "DWord"
                Value         = 0
                OriginalValue = 1
            }
        )

        # Script para desactivar la hibernación mediante powercfg.exe
        $invokeScript = {
            powercfg.exe /hibernate off
        }

        # Realizar cambios en el registro
        foreach ($change in $registryChanges) {
            if (Test-Path $change.Path) {
                Set-ItemProperty -Path $change.Path -Name $change.Name -Type $change.Type -Value $change.Value
            } else {
                Write-Host "La ruta del registro $($change.Path) no existe. No se realizaron cambios."
            }
        }

        # Ejecutar el script para desactivar la hibernación
        Invoke-Command -ScriptBlock $invokeScript

        Write-Host "Ajustes de optimización de hibernación aplicados exitosamente con WPFEssTweaksHiber."
    } catch {
        Write-Host "Error durante la ejecución de WPFEssTweaksHiber: $_"
    }
}


function WPFEssTweaksDVR {
    try {
        # Cambios en el registro para ajustar la funcionalidad GameDVR
        $registryChanges = @(
            @{
                Path          = "HKCU:\System\GameConfigStore"
                Name          = "GameDVR_FSEBehavior"
                Type          = "DWord"
                Value         = 2
                OriginalValue = 1
            },
            @{
                Path          = "HKCU:\System\GameConfigStore"
                Name          = "GameDVR_Enabled"
                Type          = "DWord"
                Value         = 0
                OriginalValue = 1
            },
            @{
                Path          = "HKCU:\System\GameConfigStore"
                Name          = "GameDVR_DXGIHonorFSEWindowsCompatible"
                Type          = "DWord"
                Value         = 1
                OriginalValue = 0
            },
            @{
                Path          = "HKCU:\System\GameConfigStore"
                Name          = "GameDVR_HonorUserFSEBehaviorMode"
                Type          = "DWord"
                Value         = 1
                OriginalValue = 0
            },
            @{
                Path          = "HKCU:\System\GameConfigStore"
                Name          = "GameDVR_EFSEFeatureFlags"
                Type          = "DWord"
                Value         = 0
                OriginalValue = 1
            },
            @{
                Path          = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR"
                Name          = "AllowGameDVR"
                Type          = "DWord"
                Value         = 0
                OriginalValue = 1
            }
        )

        # Realizar cambios en el registro
        foreach ($change in $registryChanges) {
            if (Test-Path $change.Path) {
                Set-ItemProperty -Path $change.Path -Name $change.Name -Type $change.Type -Value $change.Value
            } else {
                Write-Host "La ruta del registro $($change.Path) no existe. No se realizaron cambios."
            }
        }

        Write-Host "Ajustes de optimización de GameDVR aplicados exitosamente con WPFEssTweaksDVR."
    } catch {
        Write-Host "Error durante la ejecución de WPFEssTweaksDVR: $_"
    }
}


function WPFEssTweaksService {
    # Obtener el JSON desde la URL
    $url = "https://raw.githubusercontent.com/gabrielomana/windows-config/main/data/WPFEssTweaksService.json"
    $basicServicesJSON = Invoke-RestMethod -Uri $url -ErrorAction Stop

    # Convertir el JSON a un objeto
    $basicServices = $basicServicesJSON | ConvertFrom-Json

    foreach ($service in $basicServices.service) {
        $serviceName = $service.Name
        $startupType = $service.StartupType

        try {
            Write-Host "Setting Service $serviceName to $startupType"

            # Verificar si el servicio existe
            $service = Get-Service -Name $serviceName -ErrorAction Stop

            # El servicio existe, proceder con el cambio de propiedades
            $service | Set-Service -StartupType $startupType -ErrorAction Stop
        }
        catch [System.Exception] {
            Write-Warning "Service $serviceName was not found"
        }
        catch {
            Write-Warning "Unable to set $serviceName due to unhandled exception"
            Write-Warning $_.Exception.Message
        }
    }
}


function OptimizedOptimizedMiscellaneousChange {
    try {
        # Aplicar tema oscuro
        Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name 'AppsUseLightTheme','SystemUsesLightTheme' -Value 0

        # Desactivar Bing
        Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search' -Name 'BingSearchEnabled' -Value 0

        # Habilitar NumPad
        Set-ItemProperty -Path 'HKCU:\Control Panel\Keyboard' -Name 'InitialKeyboardIndicators' -Value 2

        # Desactivar Cortana
        $CortanaKeys = @("HKCU:\SOFTWARE\Microsoft\Personalization\Settings\AcceptedPrivacyPolicy",
                         "HKCU:\SOFTWARE\Microsoft\InputPersonalization\RestrictImplicitTextCollection",
                         "HKCU:\SOFTWARE\Microsoft\InputPersonalization\RestrictImplicitInkCollection",
                         "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore\HarvestContacts")

        foreach ($key in $CortanaKeys) {
            if (!(Test-Path $key)) {
                New-Item -Path $key -Force
            }
        }

        Set-ItemProperty -Path $CortanaKeys[0] -Name AcceptedPrivacyPolicy -Value 0 
        Set-ItemProperty -Path $CortanaKeys[1] -Name RestrictImplicitTextCollection -Value 1 
        Set-ItemProperty -Path $CortanaKeys[2] -Name RestrictImplicitInkCollection -Value 1 
        Set-ItemProperty -Path $CortanaKeys[3] -Name HarvestContacts -Value 0

        # Detener el proceso 'SearchUI'
        Stop-Process -Name 'SearchUI' -Force -ErrorAction Stop

        Write-Host "Cambios aplicados correctamente."
    }
    catch {
        Write-Host "Error al aplicar los cambios: $_"
    }
}




function Install-Choco {
    try {
        # Verificar si Chocolatey está instalado
        if ((Get-Command choco -ErrorAction SilentlyContinue) -eq $null) {
            Write-Host "Chocolatey no está instalado. Iniciando la instalación..."

            # Instalar Chocolatey
            Set-ExecutionPolicy Bypass -Scope Process -Force; 
            [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; 
            Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        } else {
            Write-Host "Chocolatey ya está instalado. Iniciando la actualización..."
            
            # Actualizar Chocolatey
            choco upgrade chocolatey -y
        }

        Write-Host "Operación completada."
    } catch {
        Write-Host "Error durante la ejecución de Install-Choco: $_"
    }
}


function Install-Winget {
    try {
        Write-Host "Comprobando si Winget está instalado..."
        # Verifica si el ejecutable de Winget existe y si la versión de Windows es 1809 o superior
        $wingetInstalled = Get-Command winget.exe -ErrorAction SilentlyContinue

        if ($wingetInstalled) {
            Write-Host "Winget ya está instalado"
            return
        }

        # Obtiene la información de la computadora
        $ComputerInfo = Get-ComputerInfo -ErrorAction Stop

        if ($ComputerInfo.WindowsVersion -lt "1809") {
            Write-Host "Winget no es compatible con esta versión de Windows (Pre-1809)"
            return
        }

        Write-Host "Descargando e instalando la última versión de Winget..."
        # Descargar e instalar Winget
        Invoke-WebRequest -Uri "https://aka.ms/install-wget" -OutFile "install-wget.ps1"
        Start-Process -Wait -FilePath "powershell.exe" -ArgumentList "-File install-wget.ps1"

        # Descargar e instalar las bibliotecas VCLibs
        Write-Host "Descargando e instalando la última versión de VCLibs..."
        Invoke-WebRequest -Uri "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx" -OutFile "Microsoft.VCLibs.x64.14.00.Desktop.appx"
        Add-AppxPackage -Path ".\Microsoft.VCLibs.x64.14.00.Desktop.appx"

        Write-Host "Winget instalado"
    }
    catch {
        throw "Error al instalar Winget"
    }
}

function Install-Scoop {
    try {
        # Verificar si Scoop está instalado
        if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
            Write-Host "Instalando Scoop..."
            
            # Establecer la política de ejecución
            Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
            
            # Instalar Scoop
            Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
            
            # Instalar Git y agregar el bucket principal
            scoop install git
            scoop bucket add main

            Write-Host "Scoop instalado y configurado correctamente."
        } else {
            Write-Host "Scoop ya está instalado. No es necesario realizar la instalación."
        }
    } catch {
        Write-Host "Error durante la ejecución de Install-ConfigureScoop: $_"
    }
}


# Bucle para manejar opciones inválidas
do {
    # Limpia la pantalla
    Clear-Host

    # Imprime el menú
    Write-Host "Selecciona una opción:"
    Write-Host "1. Desktop"
    Write-Host "2. Laptop"
    Write-Host "3. Minimal"
    Write-Host "4. Windows Default"

    # Obtiene la entrada del usuario
    $opcion = Read-Host "Ingresa el número de tu elección"

    # Utiliza un switch para manejar las opciones
    switch ($opcion) {
        1 { 
            Write-Host "Has seleccionado Desktop"
            # Invoca las funciones correspondientes para la opción "Desktop"
            WPFEssTweaksOO
            WPFEssTweaksTele
            WPFEssTweaksWifi
            WPFEssTweaksLoc
            WPFEssTweaksHome
            WPFEssTweaksStorage
            WPFEssTweaksDVR
            WPFEssTweaksService
            OptimizedMiscellaneousChange
            Install-Choco
            Install-Winget
            #Install-Scoop
        }
        2 { 
            Write-Host "Has seleccionado Laptop"
            # Invoca las funciones correspondientes para la opción "Laptop"
            WPFEssTweaksOO
            WPFEssTweaksTele
            WPFEssTweaksWifi
            WPFEssTweaksLoc
            WPFEssTweaksHome
            WPFEssTweaksStorage
            WPFEssTweaksHiber
            WPFEssTweaksDVR
            WPFEssTweaksService
            OptimizedMiscellaneousChange
            Install-Choco
            Install-Winget
            #Install-Scoop
        }
        3 { 
            Write-Host "Has seleccionado Minimal"
            # Invoca las funciones correspondientes para la opción "Minimal"
            WPFEssTweaksOO
            WPFEssTweaksTele
            WPFEssTweaksHome
            WPFEssTweaksService
            OptimizedMiscellaneousChange
            Install-Choco
            Install-Winget
            #Install-Scoop
        }
       3 { 
            Write-Host "Has seleccionado Windows Default"
            # Invoca las funciones correspondientes para la opción "Windows Default"
            OptimizedMiscellaneousChange
            Install-Choco
            Install-Winget
        }
        default { 
            Write-Host "Opción no válida. Por favor, ingresa un número del 1 al 4."
            Start-Sleep -Seconds 2  # Espera 2 segundos antes de limpiar la pantalla
        }
    }
} while ($opcion -lt 1 -or $opcion -gt 4)

#Restart
# Agrega esta línea al final del script para crear el indicador de finalización
New-Item -ItemType File -Path ".\pre-install-complete.txt" -Force
try {
    # Verificar si hay procesos de PowerShell en ejecución
    $powershellProcesses = Get-Process -Name 'powershell' -ErrorAction Stop

    if ($powershellProcesses.Count -gt 0) {
        # Detener todos los procesos de PowerShell en ejecución
        Stop-Process -Name 'powershell' -Force -ErrorAction Stop
    } else {
        Write-Host "No se encontraron procesos de PowerShell en ejecución."
    }
} catch {
    Write-Host "Error al detener los procesos de PowerShell: $_"
}
