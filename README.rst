windows-config
===============

Program Installation, Optimization, Fixes, and Updates
------------------------------------------------------

The script aims to streamline installations, optimize by debloating with tweaks, troubleshoot configurations, and rectify Windows updates. Additionally, it simplifies the automation of the fundamental application installation process, all with the purpose of creating an efficient and uncomplicated 'Post-Installation' for Windows. This approach strives to significantly improve the post-installation experience, guaranteeing optimal performance without any impediments.

Upon executing these scripts, you will achieve:

Al ejecutar estos scripts, lograrás:

- Optimization aimed at enhancing the overall system performance.
- Adjustments related to telemetry.
- Improvements in Wi-Fi connection configuration and performance.
- Settings associated with location and location services.
- Customization and optimization of the primary system interface.
- Adjustments geared towards improving storage management and performance.
- Specific optimizations designed for hibernation mode.
- Settings within system services to boost efficiency.
- Assorted optimized changes for the system's optimal operation.
- Installation and software management through Chocolatey.
- Installation and application management using Windows Package Manager (Winget) and Choco (Chocolatey).



Step 1: Run PowerShell Scripts
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Open a PowerShell console with administrator permissions.
2. Navigate to the directory where you have downloaded the scripts.
3. Execute the following command to allow script execution in PowerShell:

   .. code-block:: powershell

      Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

4. Execute the following command to start the Windows settings script:

   .. code-block:: powershell

      .\1-tweak_windows.ps1

Step 2: Application Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Open the `2-install_apps.ps1` file in a text editor.
2. Inside the file, locate the section related to the applications you want to install.
3. To install an application, remove the `#` symbol at the beginning of the corresponding line. To disable installation, add the `#` symbol. For example, the following shows that in the web browsers section, Firefox and Brave will be installed, but Chrome will not:

   Example:

    ::

        #### WEB BROWSERS ####
        ## Firefox: Fast and secure web browser.

        winget install --id=Mozilla.Firefox --accept-source-agreements --accept-package-agreements --silent -e

        ## Brave: Fast and privacy-focused browser.

        winget install --id=Brave.Brave --accept-source-agreements --accept-package-agreements --silent -e

        ## Chrome: Fast and secure web browser by Google.

        #winget install --id Google.Chrome --accept-source-agreements --accept-package-agreements --silent -e

4. Save the changes to the file.
5. After editing and saving the changes, open a new PowerShell terminal with administrator permissions.
6. Navigate to the directory where you have downloaded the scripts.
7. Execute the following command to allow script execution in PowerShell:

   .. code-block:: powershell

      Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

8. Execute the following command to start the Windows settings script:

   .. code-block:: powershell

      .\1-tweak_windows.ps1
