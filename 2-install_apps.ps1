# Importar funciones desde functions.ps1 en GitHub
$functionsUrl = "https://github.com/gabrielomana/windows-config/raw/main/data/functions.ps1"
Invoke-Expression (Invoke-RestMethod -Uri $functionsUrl)

############################################################
########### S E L E C T  A P P L I C A T I O N S ###########
############################################################

#### WEB BROWSERS ####
    ## Firefox: Fast and secure web browser.
        winget install --id=Mozilla.Firefox --accept-source-agreements --accept-package-agreements --silent -e

    ## Brave: Fast and privacy-focused browser.
        winget install --id=Brave.Brave --accept-source-agreements --accept-package-agreements --silent -e 

    ## Chrome: Fast and secure web browser by Google.
        winget install --id Google.Chrome --accept-source-agreements --accept-package-agreements --silent -e


#### DOCUMENTS ####
    ## PDFsam: PDF tool to split, merge, extract pages, and more.
        choco install pdfsam --accept-license -y

    ## Adobe Acrobat Reader: View, print, and annotate PDFs.
        winget install --id=Adobe.Acrobat.Reader.64-bit --accept-source-agreements --accept-package-agreements --silent -e

    ## CutePDF Writer: Create professional-quality PDF documents.
        winget install --id=AcroSoftware.CutePDFWriter --accept-source-agreements --accept-package-agreements --silent -e

    ## LibreOffice: Powerful and free office suite.
        winget install --id=TheDocumentFoundation.LibreOffice --accept-source-agreements --accept-package-agreements --silent -e


#### DEVELOPER TOOLS ####
    ## Notepad++: Free source code editor and Notepad replacement.
        winget install --id Notepad++.Notepad++ --accept-source-agreements --accept-package-agreements --silent -e

    ## FileZilla: Fast and reliable FTP, FTPS, and SFTP client.
        choco install filezilla --accept-license -y

    ## PuTTY: SSH and telnet client.
        winget install --id=PuTTY.PuTTY --accept-source-agreements --accept-package-agreements --silent -e

    ## WinMerge: Visual text file differencing and merging tool.
        winget install --id=WinMerge.WinMerge --accept-source-agreements --accept-package-agreements --silent -e

    ## Visual Studio Code: Lightweight and powerful code editor.
        Install-VSCode

    ## Kate: Advanced text editor.
        winget install --id=KDE.Kate --accept-source-agreements --accept-package-agreements --silent -e

    ## GitHub Desktop: Visualize and manage your repositories through a graphical interface.
        winget install --id=GitHub.GitHubDesktop --accept-source-agreements --accept-package-agreements --silent -e


### MEDIA ###
    ## K-Lite Codec Pack: Comprehensive selection of codecs.
        winget install --id=CodecGuide.K-LiteCodecPack.Full --accept-source-agreements --accept-package-agreements --silent -e

    ## VLC Media Player: Open-source multimedia player.
        winget install --id=VideoLAN.VLC --accept-source-agreements --accept-package-agreements --silent -e

    ## Audacity: Free, open-source, cross-platform audio software.
        # winget install --id=Audacity.Audacity --accept-source-agreements --accept-package-agreements --silent -e

    ## YouTube Music: Enjoy music with YouTube-powered suggestions.
        # choco install th-ch-youtube-music --version 1.11.0 --accept-license -y


### RUNTIMES ###
    ## Java Runtime: Support for Java applications.
        choco install javaruntime --accept-license -y

    ## .NET Framework Developer Pack 4: Development pack for .NET Framework 4.
        winget install --id=Microsoft.DotNet.Framework.DeveloperPack_4 --accept-source-agreements --accept-package-agreements --silent -e

    ## .NET Runtime 7: .NET Runtime version 7.
        winget install --id=Microsoft.DotNet.Runtime.7 --accept-source-agreements --accept-package-agreements --silent -e

    ## .NET Runtime 6: .NET Runtime version 6.
        winget install --id=Microsoft.DotNet.Runtime.6 --accept-source-agreements --accept-package-agreements --silent -e

    ## .NET Runtime 5: .NET Runtime version 5.
        winget install --id=Microsoft.DotNet.Runtime.5 --accept-source-agreements --accept-package-agreements --silent -e

    ## .NET Runtime 3.1: .NET Runtime version 3.1.
        winget install --id=Microsoft.DotNet.Runtime.3_1 --accept-source-agreements --accept-package-agreements --silent -e


#### COMPRESSION ####
    ## 7-Zip: File archiver with a high compression ratio.
        winget install --id=7zip.7zip --accept-source-agreements --accept-package-agreements --silent -e

    ## WinRAR: File archiver utility for Windows.
    #	winget install --id RARLab.WinRAR --accept-package-agreements --silent -e


#### IMAGING ####
    # Greenshot: Lightweight screenshot tool.
    #	winget install --id=Greenshot.Greenshot --accept-source-agreements --accept-package-agreements --silent -e

    ## ShareX: Screen capture and file sharing tool.
        winget install --id=ShareX.ShareX --accept-source-agreements --accept-package-agreements --silent -e

    ## nomacs: Free, open-source image viewer.
        choco install nomacs --accept-license -y


#### UTILITIES ####
    ## choco-upgrade-all-at: Chocolatey extension for upgrading all installed packages.
        choco install choco-upgrade-all-at --accept-license -y

    # TeraCopy: Efficiently copy files with pause and resume capabilities.
        winget install --id=CodeSector.TeraCopy --accept-source-agreements --accept-package-agreements --silent -e

    # JohnsBackgroundSwitcher: Automatically changes the desktop wallpaper.
        winget install --id=johnsadventures.JohnsBackgroundSwitcher --accept-source-agreements --accept-package-agreements --silent -e

    ## Any Video Converter: Convert videos between various formats.
        choco install anyvideoconverter --accept-license -y

    # Glary Utilities Free: All-in-one system maintenance and optimization tool.
        choco install glaryutilities-free --accept-license -y

    # BleachBit: All-in-one system maintenance and optimization tool.
            winget install --id=BleachBit.BleachBit --accept-source-agreements --accept-package-agreements --silent -e
    
    # RustDesk: Effortless remote access for smooth collaboration and productivity.
        winget install --id=RustDesk.RustDesk  --accept-source-agreements --accept-package-agreements --silent -e

    # AnyDesk: Effortless remote access for smooth collaboration and productivity.
        winget install --id=AnyDeskSoftwareGmbH.AnyDesk  --accept-source-agreements --accept-package-agreements --silent -e

    ## Google Drive: Cloud storage and file synchronization service by Google.
        winget install --id=Google.Drive --accept-source-agreements --accept-package-agreements --silent -e

    ## WhatsApp: Messaging and Voice over IP service.
        winget install --id=WhatsApp.WhatsApp --accept-source-agreements --accept-package-agreements --silent -e

    ## qBittorrent: Free and open-source torrent client.
        winget install --id=qBittorrent.qBittorrent --accept-source-agreements --accept-package-agreements --silent -e

    # Revo Uninstaller: Uninstall stubborn programs and remove leftover files.
        winget install --id=RevoUninstaller.RevoUninstaller --accept-source-agreements --accept-package-agreements --silent -e

    ## Kodi: Open-source media center and home theater software.
        winget install --id=XBMCFoundation.Kodi --accept-source-agreements --accept-package-agreements --silent -e

    # MEGASync: Cloud storage and file synchronization service.
        winget install --id=Mega.MEGASync --accept-source-agreements --accept-package-agreements --silent -e

    # Oracle VirtualBox: Powerful x86 and AMD64/Intel64 virtualization product.
        winget install --id=Oracle.VirtualBox --accept-source-agreements --accept-package-agreements --silent -e

    # VokoscreenNG: Easy-to-use screencasting application.
        Install-Vokoscreen

#### TERMINAL ####
    #Create a scheduled task in Windows to update applications
        Install-Terminal

#### UPGRADE ####
    #Create a scheduled task in Windows to update applications
        Install-TaskUpgrade

#### CLEAN ####
    #Create a scheduled task in Windows to update applications
        clean_pc







