---
description: Phase 3 - Clean Windows 11 installation offline. Skip Microsoft account setup using BypassNRO command and disconnect from network to prevent Autopilot/Entra ID enrollment.
keywords: Windows installation, offline installation, BypassNRO, clean install, skip device setup
---

# Phase 3: Clean Installation and Network Bypass (BypassNRO)

## Overview

Now it's time to perform a **completely clean Windows 11 installation**. This erases all existing Windows, all corporate tracking, and all enrollment data. You'll install Home edition (thanks to the `ei.cfg` file from Phase 2) while completely bypassing Microsoft account creation and online enrollment checks.

The key technique is the **BypassNRO** command, which removes network requirements from Windows setup.

**Time required:** 20–30 minutes  
**What you need:**
- The customized Windows 11 USB from Phase 2
- No internet connection (critical!)
- The device you're unlocking

!!! danger "Keep the Device Offline During This Phase"
    If your device connects to the internet during setup, it will attempt to re-enroll in Autopilot. Keep WiFi and Ethernet both disconnected until Phase 7. This is critical.

---

## Step-by-Step Instructions

### Step 1: Disconnect from the Internet

Before you do anything else:

1. **Unplug any Ethernet cable** from the device
2. **Disable WiFi:**
   - If you have a WiFi kill switch on the keyboard, toggle it off
   - Or go to **Settings > Network > WiFi** and toggle it off
3. **Optional but recommended:** Temporarily turn off your WiFi router so even accidental connection is harder

!!! warning "No Internet Means No Internet"
    The Windows installer is extremely persistent about checking Microsoft servers. If you're on WiFi, it WILL try to connect. Just turning off the WiFi toggle isn't always enough – physically disable it or disconnect from the network.

### Step 2: Boot from the USB

1. **Insert the Windows 11 USB** you prepared in Phase 2
2. **Turn on the device** and immediately enter the **boot menu** (usually F12, F2, Del, or Esc during startup – varies by manufacturer)
3. **Select the USB drive** as the boot device (look for something like "UEFI: USB" or the drive name)
4. **Press Enter** and let the Windows installer load

!!! tip "Can't Find Boot Menu?"
    If you miss the boot menu timing, let Windows start normally, then restart and try again. Timing can be tricky – be patient and try multiple times if needed.

### Step 3: Start the Installation

1. Windows Setup will load (this takes 1–2 minutes)
2. Select your **Language**, **Time and Currency Format**, and **Keyboard/Input Method**
3. Click **Next**
4. Click **Install now**

!!! note "Offline Indicator"
    You'll see a message like "Your internet isn't secure" or no internet connectivity indicators. This is normal and expected.

### Step 4: Erase the Disk

1. You'll see a screen: **"Where do you want to install Windows?"**
2. **Select each partition one by one** and click **Delete**
3. Repeat until you see only **"Unallocated Space"**
4. **Click on the Unallocated Space** and click **Next**

Windows will now begin installing. This takes 10–20 minutes.

!!! success "Installation in Progress"
    Windows is being installed on a completely clean disk. No corporate data, no Autopilot records, no tracking software. Just vanilla Windows 11 Home.

### Step 5: Bypass Network Requirements with BypassNRO

When installation finishes, you'll see a setup screen:
**"Is this the correct country or region?"** or similar.

1. **Press Shift + F10** (or **Shift + Fn + F10** on some laptops) to open **Command Prompt**
2. Type **exactly:** `oobe\bypassnro`
3. **Press Enter**

!!! warning "Exact Syntax Required"
    The command must be exactly `oobe\bypassnro` (backslash, not forward slash). If it doesn't work, you're not in the right place – BypassNRO only works during OOBE (Out of Box Experience).

The device will restart automatically.

### Step 6: Complete Setup with No Account

After restart, Windows will show setup screens again:

1. **Select country and keyboard layout** again
2. **When you reach the "Let's connect you to a network" screen,** look for **"I have no internet"** at the bottom
3. **Click it**

!!! tip "If BypassNRO Worked"
    The "I have no internet" option will appear. If it doesn't, BypassNRO might not have run successfully – restart and try command prompt again in the OOBE phase.

4. Click **Continue with limited setup**
5. Create a **local user account** (give it any name you like, e.g., `Admin` or `LocalUser`)
6. **Press Next** and proceed through any remaining setup screens
7. **Skip Microsoft account sign-in** – you'll add your personal account later in Phase 7
8. Configure privacy settings (you can turn everything off if you want)
9. Click **Finish** when you reach the desktop

!!! success "Phase 3 Complete"
    You now have a completely clean Windows 11 Home installation on a fresh, completely offline system. No accounts are signed in, no enrollment data exists, and corporate fingerprints are gone. Your device thinks it's a brand-new consumer laptop.

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| "Command Prompt not found" when pressing Shift+F10 | You're not in OOBE (setup phase). Only Shift+F10 works during setup, not in the main Windows environment. |
| BypassNRO command doesn't work | Make sure you typed it exactly: `oobe\bypassnro` (with backslash). Case doesn't matter, but the spelling must be exact. |
| Device keeps trying to connect to WiFi | Go back to Step 1 and physically disable WiFi or unplug Ethernet. |
| "I have no internet" option doesn't appear | BypassNRO didn't run successfully. Restart and try the Shift+F10 command again. |
