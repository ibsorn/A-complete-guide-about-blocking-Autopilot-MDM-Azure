# Complete Guide to Blocking Autopilot, MDM, and Azure

## Preliminary Warning: On the Persistence of Autopilot

Before starting, it is crucial to understand that these software steps bypass the lock in a very robust way, but they are not permanent or infallible. Microsoft's Autopilot system associates the device with the company through a physical identifier (Hardware Hash). If the device is formatted or reset to factory settings in the future without reapplying this guide, it will lock again.

The only definitive and infallible ways to permanently unlink the device are:

- **Modify the Serial Number / UUID in the BIOS**: Alter the hardware's "DNA" so that the Hardware Hash changes. This requires very specific manufacturer's engineering tools (DMI Tools) and can be complicated and risky. It is always recommended to research technical forums if there is a leaked method or software for your exact model.

- **Change the entire motherboard**: This generates new hardware, but it is usually economically unfeasible.

Assuming we proceed via software, this is the definitive guide.

## Phase 1: Deep Hardware Cleanup (BIOS/UEFI)

Before installing Windows, we must destroy any cryptographic traces or tracking software anchored in the old company's motherboard.

1. Turn on the device and enter the BIOS/UEFI (usually by pressing F2, F10, F12, Del, or Esc repeatedly when starting up).

2. **Clean the TPM module**: Look for the Security tab. Locate the option related to the TPM chip (it may be called TPM Security, Security Chip, or Intel PTT/AMD fTPM). Select the Clear TPM (Clear TPM) or Reset to Factory option. This will delete any corporate certificates or keys physically stored in the chip.

3. **Disable the Absolute Persistence Module (Computrace)**: In the same Security tab, check if the device has options called Absolute Persistence, Computrace, or Lojack. If it does, change its status to Permanently Disable. Save the changes and exit the BIOS.

## Phase 2: USB Preparation (Force Windows 11 Home)

Note: Installing the Windows 11 Home version is optional but highly recommended. The Home version lacks the internal components necessary to join an Azure domain or run Autopilot. By forcing this version, we add a structural barrier against the old company.

Since corporate laptops have the Pro license engraved on the motherboard, the installer will read it automatically. To prevent this:

1. Create a USB with the official Windows 11 image using Microsoft's tool.

2. Connect the USB to your current device and open the folder called sources.

3. Right-click in an empty space > New > Text Document.

4. Paste exactly the following lines:

   ```
   [EditionID]
   Core
   [Channel]
   Retail
   [VL]
   0
   ```

5. Select File > Save As. In the "Type" option, choose All files (.). Name the file exactly as ei.cfg and save it.

## Phase 3: Clean Installation and Network Bypass (BypassNRO)

1. Physically disconnect the laptop from the internet (no Ethernet cable, and if necessary, temporarily turn off your Wi-Fi router).

2. Boot the device from the USB and start the installation.

3. When you reach the screen "Where do you want to install Windows?", select each existing partition one by one and press Delete until the entire disk is "Unallocated Space". Select that space and press Next.

4. When the installation finishes and the first configuration screen appears ("Is this the correct country or region?"), press the Shift + F10 keys (or Shift + Fn + F10) to open the command console (CMD).

5. Type exactly `oobe\bypassnro` and press Enter.

6. The device will restart. Reselect the country and keyboard. When you reach the network screen, a new option will appear at the bottom: "I have no internet". Click it.

7. Select "Continue with limited setup", create a Local user account (e.g., "Admin"), and finish until you reach the desktop.

## Phase 4: Key Purging and Version Lock

Apply these steps on the desktop, keeping the device offline, to prevent Windows from recovering its original Pro version.

1. Open the Start menu, type cmd, right-click on "Command Prompt" and select Run as administrator.

2. Delete the motherboard key from the registry by running: `slmgr.vbs /cpky`

3. Uninstall any preloaded key by running: `slmgr.vbs /upk`

4. Lock the Home version with the official generic key by running: `slmgr.vbs /ipk YTMG3-N6DKC-DKB77-7M9GH-8HVX7`

5. Block forced version updates: Press Windows + R, type regedit and navigate to `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft`. If it doesn't exist, create a key called WindowsStore inside it. Inside it, create a "DWORD (32-bit) Value" called DisableOSUpgrade and set its value to 1.

## Phase 5: Telemetry and MDM Module Deactivation

We will cut off at the root the Windows services responsible for remote administration.

In the same Administrator CMD, run these two commands to disable the MDM routing engine:

```
sc stop dmwappushservice
sc config dmwappushservice start= disabled
```

Run these two to turn off corporate telemetry:

```
sc stop DiagTrack
sc config DiagTrack start= disabled
```

Run this command on a single line to prohibit mobile device enrollment:

```
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\MDM" /v DisableRegistration /t REG_DWORD /d 1 /f
```

Run this command to block automatic joining to Azure (Entra ID) in the background:

```
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WorkplaceJoin" /v BlockAADWorkplaceJoin /t REG_DWORD /d 1 /f
```

## Phase 6: Server Blocking in the Hosts File

We will prevent the device from contacting Microsoft's deployment domains, shielding the file so that antivirus doesn't revert it.

1. Open the Start menu, search for Notepad and open it as Administrator.

2. Go to File > Open. Navigate to `C:\Windows\System32\drivers\etc`. Change the bottom view to "All files (.)" and open the hosts file.

3. Add these two lines at the end of the text, save (Ctrl+S) and close Notepad:

   ```
   0.0.0.0 ztd.desktop.microsoft.com
   0.0.0.0 cs.dds.microsoft.com
   ```

4. Open Windows Security > Virus & threat protection > Manage settings. Scroll down to "Exclusions", click Add or remove exclusions > Add exclusion > File. Select the hosts file you just modified.

5. Open File Explorer, go to `C:\Windows\System32\drivers\etc`, right-click on the hosts file > Properties, check the Read-only box and click OK.

## Phase 7: Final Connection and Safe Use

Your device is now fortified.

1. Connect the device to the Internet.

2. Go to Settings > Accounts > Your info and click "Sign in with a Microsoft account instead". You can freely add your personal account. Configure Windows Hello (PIN or Biometrics) in "Sign-in options".

**Critical Usage Rule**: If at any point you need to sign in with a work account (Office 365, Teams, Outlook), a window will appear saying "Allow my organization to manage my device". You must always uncheck that box and explicitly click "No, sign in only to this app".

By following this complete guide, the device will act in all respects as a consumer personal computer, keeping the backdoors of corporate control blocked.
