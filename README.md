# crowdstrike-outage-fix
Remediation for the BSOD on Windows systems caused by Crowdstrike's channel file update

# Warning
In many corporate networks, end users are neither expected nor permitted to manage their own systems. This may introduce complications, such as compliance requirements and BitLocker encryption.
Please assess the appropriate steps for your specific environment. Determine if resolving the issue can be done through self-service, if it requires you to take action, or if it is necessary at all.

# Purpose
On July 19, 2024 at 04:09 UTC, as part of ongoing operations, CrowdStrike released a sensor configuration update to Windows systems. Sensor configuration updates are an ongoing part of the protection mechanisms of the Falcon platform. This configuration update triggered a logic error resulting in a system crash and blue screen (BSOD) on impacted systems.

# Affected hardware
Customers running Falcon sensor for Windows version 7.11 and above, that were online between Friday, July 19, 2024 04:09 UTC and Friday, July 19, 2024 05:27 UTC, may have been impacted.

# Background
On Windows systems, Channel Files reside in the following directory: "C:\Windows\System32\drivers\CrowdStrike\" and have a file name that starts with “C-”. Each channel file is assigned a number as a unique identifier. The impacted Channel File in this event is 291 and will have a filename that starts with “C-00000291-” and ends with a .sys extension. Although Channel Files end with the SYS extension, they are not kernel drivers.

# Instructions

Boot intto Safe Mode or WinRE's Command Prompt from the WinRE blue screen.

Safe Mode:
See advanced repair options → Troubleshoot → Advanced options → Startup Settings → Restart → Options menu: Safe Mode F4 / 4

WinRE: Command Prompt
See advanced repair options → Troubleshoot → Advanced options → Command Prompt
BitLocker Only:
Get the Recovery Key ID from the screen
Go to the Microsoft account's Device List
Log in with work/school credentials
Select: Windows PC → View BitLocker Keys
Find matching: Recovery ID → Get: Recovery Key
Enter Recovery Key within WinRE → Enter

If a machine is stuck on a BSOD and not auto-booted to WinRE:
Reboot machine: Press and hold power button to power off → Release → Power on
Once Windows' bootloader begins loading Windows, repeat Step 1 twice in a row
Windows will auto-boot to WinRE upon two failed attempts by the Windows bootloader to load Windows

Delete file matching C-00000291*.sys within:
%WinDir%\System32\drivers\CrowdStrike
Safe Mode:
Open an Admin terminal:
WinKey+R → Open: powershell → Ctrl+Shift+OK
Delete file:
Remove-Item -Path "$env:WinDir\System32\drivers\CrowdStrike\C-00000291*.sys" -Force
Reboot:
Shutdown /f /r /t 0

WinRE Command Prompt:
(C: is usually not the OS partition mount point in WinRE)
Obtain mount point of the OS partition:
::# Launch DiskPart:
    DiskPart

  ::# List all volumes [partitions]:
      Lis Vol

  ::# Close DiskPart:
      Exit
Delete file:
Del /f /q "<OSdriveLetter>:\Windows\System32\drivers\CrowdStrike\C-00000291*.sys"
Reboot: Close Command Prompt → Continue to Windows <#>

Normally boot to Windows
