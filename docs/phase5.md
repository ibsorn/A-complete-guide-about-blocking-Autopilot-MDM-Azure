---
description: Phase 5 - Disable MDM modules and telemetry on Windows. Stop dmwappushservice, disable DiagTrack, and block Azure AD workplace join to prevent device management enrollment.
keywords: MDM, telemetry, Windows services, dmwappushservice, DiagTrack, Azure AD, device management
---

# Phase 5: Telemetry and MDM Module Deactivation

## Overview

By now, you have:
- ✅ Cleared BIOS tracking
- ✅ Installed your chosen Windows edition
- ✅ Locked down the OS against corporate updates

But Windows still has services and control mechanisms designed to enable remote management. In this phase, we'll **disable the services and registry keys that allow MDM (Mobile Device Management) and corporate tracking** to function.

**Time required:** 5 minutes  
**Status:** Still offline – no internet yet

!!! note "What Are MDM and Telemetry?"
    - **MDM:** Mobile Device Management services that let corporations control devices remotely
    - **Telemetry:** Services that send usage data and diagnostic info to Microsoft
    - **DiagTrack:** Windows diagnostic tracking (snooping on your activity)
    - **dmwappushservice:** Device management enrollment service

---

## Automated Alternative: Use a PowerShell Script

If you prefer to **automate all of Phase 5**, you can use a PowerShell script that will execute all commands for you:

[📥 Download phase5-disable-mdm.ps1](assets/downloads/phase5-disable-mdm.ps1){: .md-button }

**To use the script:**

1. Download the file above
2. Right-click on it and select **Properties**
3. Check the **"Unblock"** checkbox at the bottom and click **OK**
4. Right-click on the script file and select **Run with PowerShell**
5. Click **"Yes"** when Windows asks for Administrator permission (UAC dialog)
6. The script will automatically execute all Phase 5 commands with colorized output

!!! tip "Script Benefits"
    - No typing required – no risk of typos
    - Colorized output makes it clear what's happening
    - Automatic error handling and reporting
    - Faster than manual commands

If you prefer to do it manually, follow the instructions below.

---

### Important: Open Command Prompt as Administrator

All of these commands require admin privileges. Follow this first:

1. Click **Start menu**
2. Type `cmd`
3. **Right-click** on **Command Prompt**
4. Select **Run as administrator**
5. Click **Yes** when prompted
6. You should now see a black window with `C:\Windows\System32>` at the end

All the commands below go into this Command Prompt window.

---

## Step 1: Disable the MDM Enrollment Service

The `dmwappushservice` is responsible for Mobile Device Management enrollment. Let's kill it:

Type these two commands, one at a time, pressing Enter after each:

```powershell
sc stop dmwappushservice
sc config dmwappushservice start= disabled
```

**What each command does:**
- `sc stop dmwappushservice` – Stops the service immediately
- `sc config dmwappushservice start= disabled` – Ensures it never starts again, even after a restart

!!! tip "Look for Confirmation"
    Each command will return something like `[SC] SetServiceConfig SUCCESS` or `The service has been stopped.` This means it worked.

---

## Step 2: Disable Windows Diagnostic Tracking (DiagTrack)

This service sends diagnostic data and telemetry to Microsoft. Let's shut it down:

Type these two commands:

```powershell
sc stop DiagTrack
sc config DiagTrack start= disabled
```

!!! note "What This Does"
    DiagTrack is Windows' telemetry service. Shutting it off stops Windows from reporting your activity back to Microsoft's servers. This is one of the most important services to disable.

---

## Step 3: Block Mobile Device Enrollment via Registry

Even with services disabled, Windows can still enroll in MDM through the registry. Let's block that with **two protection layers**:

### Block 1: Disable Direct/Manual MDM Registration

Type this command exactly (it's all one line):

```powershell
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\MDM" /v DisableRegistration /t REG_DWORD /d 1 /f
```

!!! success "Registry Updated"
    You'll see a message like `The operation completed successfully.` This registry key tells Windows: "Block any attempt to enroll in MDM."

### Block 2: Disable Automatic Silent MDM Auto-Enrollment

Now type this second command (also one line):

```powershell
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\MDM" /v AutoEnrollMDM /t REG_DWORD /d 0 /f
```

!!! warning "Two Blocks Are Necessary"
    - **DisableRegistration** blocks manual/direct enrollment attempts
    - **AutoEnrollMDM = 0** blocks silent automatic enrollment that happens in the background using cached corporate credentials
    
    Even if a user accidentally signs in with corporate credentials (like from a cached session), Windows won't be able to auto-enroll the device in MDM.

!!! tip "Check the Result"
    Both commands should return: `The operation completed successfully.`

---

## Step 4: Block Azure AD / Entra ID Workplace Join

This is how Windows automatically enrolls your device in Azure AD for corporate control. Let's prevent it:

Type this command exactly (also one line):

```powershell
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WorkplaceJoin" /v BlockAADWorkplaceJoin /t REG_DWORD /d 1 /f
```

!!! warning "Azure AD (Now Called Entra ID)"
    Azure AD is Microsoft's identity and corporate device management system. Even if you disable other services, Windows can still try to enroll your device in Azure AD. This command blocks that.

---

## Verification: Check That Services Are Disabled

To verify everything worked, you can check the services:

1. Press **Windows + R**
2. Type `services.msc` and press Enter
3. Look for these services in the list:
   - **DiagTrack** – should show **Disabled** in the Status column
   - **dmwappushservice** – should show **Disabled** in the Status column

If they say "Running," you didn't disable them correctly. Try again.

!!! tip "Services Window is Optional"
    If you see "Disabled" for both, you're good. You don't need to change anything from this window.

---

## What These Commands Actually Do

| Service/Registry | Purpose | Your Action |
|------------------|---------|-------------|
| **dmwappushservice** | Mobile Device Management enrollment service | Stopped and disabled |
| **DiagTrack** | Windows diagnostic tracking and telemetry | Stopped and disabled |
| **DisableRegistration** | Blocks direct/manual MDM enrollment attempts | Set to 1 (disabled) |
| **AutoEnrollMDM** | Blocks silent automatic MDM enrollment with cached credentials | Set to 0 (disabled) |
| **WorkplaceJoin Registry Key** | Blocks Azure AD automatic enrollment | Disabled |

---

## After Phase 5

Your device now has:
- ✅ TPM cleared (BIOS level)
- ✅ Edition locked down and corporate keys removed (OS level)
- ✅ OS upgrades blocked (registry level)
- ✅ MDM services killed (services level)
- ✅ Azure AD enrollment blocked (registry level)

The device is now **extremely hardened** against corporate re-enrollment. Even if you connect to the internet, these defenses will prevent automatic enrollment.

!!! success "Phase 5 Complete"
    The kill switch for corporate control has been activated. Your device can no longer be remotely managed, enrolled in Autopilot, or forced into Azure AD. We're almost done – just need to block the domain servers and set up your personal account.
