---
description: Complete 7-phase technical guide to bypass Microsoft Autopilot, MDM, and Azure enrollment on Windows 11. Remove corporate device locks with step-by-step instructions and automated PowerShell scripts.
keywords: autopilot, MDM, Azure, Windows 11, device unlock, corporate lock removal, Microsoft enrollment bypass, Windows Home edition
---

# Complete Guide to Blocking Autopilot, MDM, and Azure Enrollment on Windows

Learn how to **completely remove Microsoft Autopilot, MDM (Mobile Device Management), and Azure/Entra ID locks** from Windows 11 devices. This comprehensive 7-phase technical guide provides step-by-step instructions to **regain full control** of corporate-locked computers, with both manual procedures and downloadable automation scripts.

## Why You Need This Guide

Microsoft's Autopilot and Device Management systems create powerful restrictions on Windows devices:

- **Autopilot Lock:** Prevents you from bypassing initial device setup and account configuration
- **MDM Enrollment:** Continuously monitors device activity, enforces policies, and can remotely wipe data
- **Azure/Entra ID Tenant Lock:** Permanently binds the device to a corporate organization, blocking account changes
- **Preinstalled Retail Keys (PRKs):** Automatically upgrade Windows editions and re-enable Autopilot enrollment

If you've purchased a used corporate laptop or inherited a company device, these locks prevent you from:
- Creating local administrator accounts
- Installing software without approval
- Connecting to any Wi-Fi network
- Using the device for personal purposes
- Selling or repurposing the hardware

**This guide solves all of these problems** by providing proven technical procedures to completely remove all layers of corporate control.

!!! warning "Important Prerequisites"
    - You will need administrator access or the ability to enter BIOS
    - A bootable Windows 11 USB drive
    - A backup of any important data (this process will wipe the drive)
    - Patience – work through each phase in order without skipping steps
    - Internet connectivity will be restored only after phase completion

## How This Guide Works

The process is divided into **seven phases**, each building on the previous one. Start with Phase 1 and proceed in order. Do not skip phases.

### Quick Overview

| Phase | What Happens | Time |
|-------|--------------|------|
| **1** | [Deep Hardware Cleanup](phase1.md) – Clear BIOS tracking | 5–10 min |
| **2** | [USB Preparation](phase2.md) – Force Windows 11 Home edition | 5 min |
| **3** | [Clean Installation](phase3.md) – Fresh Windows install offline | 20–30 min |
| **4** | [Key Purging](phase4.md) – Lock in Home edition | 5 min |
| **5** | [Telemetry & MDM Kill](phase5.md) – Disable tracking services | 5 min |
| **6** | [Hosts File Block](phase6.md) – Block Microsoft domains | 5 min |
| **7** | [Final Setup](phase7.md) – Secure your personal account | 5 min |

**Total time: ~1–2 hours**

## Navigate to Each Phase

1. [Phase 1 - Deep Hardware Cleanup](phase1.md)
2. [Phase 2 - USB Preparation (force Windows 11 Home)](phase2.md)
3. [Phase 3 - Clean Installation and Network Bypass](phase3.md)
4. [Phase 4 - Key Purging and Version Lock](phase4.md)
5. [Phase 5 - Telemetry and MDM Module Deactivation](phase5.md)
6. [Phase 6 - Server Blocking in the Hosts File](phase6.md)
7. [Phase 7 - Final Connection and Safe Use](phase7.md)

!!! tip "Pro Tip"
    Take screenshots of each major step. If something goes wrong, these help you troubleshoot or remember where you left off.
