---
description: Phase 1 of bypassing Autopilot - BIOS/UEFI hardware cleanup. Clear TPM module, disable Computrace/Lojack, and remove corporate hardware fingerprints.
keywords: BIOS, UEFI, TPM, Computrace, hardware hash, Lojack, hardware cleanup
---

# Phase 1: Deep Hardware Cleanup (BIOS/UEFI)

## Overview

Before you even install Windows, you need to erase the corporate "fingerprints" stored in your hardware. Microsoft's Autopilot system relies on a hardware identifier called the **Hardware Hash** – a unique number burned into your device. The TPM (Trusted Platform Module) chip and BIOS store corporate certificates and enrollment records that prevent device unbinding.

In this phase, we'll:
- Clear the TPM module (which holds corporate certificates)
- Disable tracking modules like Computrace/Lojack (if present)

**Time required:** 5–10 minutes  
**Risk level:** Low (you haven't touched Windows yet)

!!! warning "Critical Step"
    Do NOT skip the TPM reset. Without it, Windows will try to re-enroll the device in the corporate domain even if you install Home edition. This is the most important step in Phase 1.

---

## Step-by-Step Instructions

### Step 1: Enter BIOS/UEFI

1. **Power on the device** and immediately start pressing the BIOS entry key repeatedly.
2. The key varies by manufacturer:
   - **Dell:** F2 or F12
   - **HP:** F10 or Esc, then F10
   - **Lenovo:** F2 or Fn + F2
   - **ASUS:** Del or F2
   - **Generic/Other:** F2, F10, F12, Del, or Esc

!!! tip "Timing Matters"
    You must press the key *immediately* after power-on, during the manufacturer logo. If you miss it, restart and try again. Don't wait for Windows to load.

### Step 2: Clear the TPM Module

This is where the corporate control data lives. Here's what to do:

1. **Navigate to the Security tab** (look for tabs like Security, System Security, or Integrated Peripherals)
2. **Find the TPM option.** It might be called:
   - "TPM Security Chip"
   - "TPM Device"
   - "Trusted Platform Module"
   - "Intel PTT" (Intel devices)
   - "AMD fTPM" (AMD devices)

3. **Select "Clear TPM"** or **"Reset TPM"** or **"Clear Security Chip"**
4. **Confirm the action** – this will delete all stored certificates and keys

!!! note "What This Does"
    The TPM chip can store corporate certificates that persist even after a Windows format. Clearing it ensures those certificates are permanently gone and cannot be recovered.

### Step 3: Disable Computrace (if present)

Some corporate devices have an agent called **Computrace** (also branded as "LoJack for Laptops" or "Absolute Persistent Agent"). This is remote access software that locks devices even without Autopilot.

1. **Look for options related to:**
   - "Computrace"
   - "Absolute Persistence"
   - "Lojack"
   - "Embedded Security"

2. **If found, change the setting to:**
   - "Permanently Disable"
   - "Permanently Deactivated"
   - Or set to "Disabled" (not just "Disabled – can be enabled by software")

!!! warning "Computrace is Rare but Dangerous"
    If your device has Computrace and you don't disable it here, you won't be able to disable it later in Windows. It runs at a level below the OS. That's why we do it now.

### Step 4: Save and Exit

1. Press **F10** (or the save/exit key for your BIOS) to save changes
2. Confirm "Yes" when asked to save
3. The device will restart

!!! success "Phase 1 Complete"
    You've successfully erased the hardware-level locks. The device is now "blank" at the BIOS level, though Windows still thinks it's enrolled in Autopilot. We'll fix that in Phase 3.

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Can't find TPM option | Some laptops let you enter BIOS but have limited settings. Try "Security Chip," "Integrated Peripherals," or contact your device manufacturer for the exact path. |
| BIOS is password protected | You'll need the BIOS password. If you don't have it, this device may require manufacturer intervention. |
| Settings appear grayed out | Some corporate devices lock certain BIOS options. Try resetting to factory defaults (often under "System Defaults" or "Reset to Setup Defaults"). |