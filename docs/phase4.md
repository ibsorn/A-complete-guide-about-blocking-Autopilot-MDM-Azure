# Phase 4: Key Purging and Version Lock

Apply these steps on the desktop, keeping the device offline, to prevent Windows from recovering its original Pro version.

1. Open the Start menu, type `cmd`, right-click on **Command Prompt** and select **Run as administrator**.

2. Delete the motherboard key from the registry by running:
   ```powershell
   slmgr.vbs /cpky
   ```

3. Uninstall any preloaded key by running:
   ```powershell
   slmgr.vbs /upk
   ```

4. Lock the Home version with the official generic key by running:
   ```powershell
   slmgr.vbs /ipk YTMG3-N6DKC-DKB77-7M9GH-8HVX7
   ```

5. Block forced version updates: press **Windows + R**, type `regedit` and navigate to `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft`. If it doesn't exist, create a key called `WindowsStore` inside it. Inside `WindowsStore`, create a **DWORD (32-bit) Value** called `DisableOSUpgrade` and set its value to `1`.