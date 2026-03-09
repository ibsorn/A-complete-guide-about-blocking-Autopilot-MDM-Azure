---
description: Complete 9-phase technical guide to bypass Microsoft Autopilot, MDM, and Azure enrollment on Windows 11. Remove corporate device locks with step-by-step instructions and automated PowerShell scripts, including optional hosts file watchdog protection.
keywords: autopilot, MDM, Azure, Windows 11, device unlock, corporate lock removal, Microsoft enrollment bypass, Windows Home edition, firewall blocking, hosts watchdog
---

# Complete Guide to Blocking Autopilot, MDM, and Azure Enrollment on Windows

Learn how to **completely remove Microsoft Autopilot, MDM (Mobile Device Management), and Azure/Entra ID locks** from Windows 11 devices. This comprehensive 9-phase technical guide provides step-by-step instructions to **regain full control** of corporate-locked computers, with both manual procedures and downloadable automation scripts.

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

The process is divided into **nine phases**, each building on the previous one. Phases 1-7 are mandatory and comprehensive. Phase 8 adds optional automated protection. Phase 9 is the final connection and account setup step. Start with Phase 1 and proceed in order. **Internet connection is restored only in Phase 9**, after all defensive layers are active.

### Quick Overview

| Phase | What Happens | Time | Required |
|-------|--------------|------|----------|
| **1** | [Deep Hardware Cleanup](phase1.md) – Clear BIOS tracking | 5–10 min | ✅ Yes |
| **2** | [Edition Selection](phase2.md) – Choose Windows 11 edition (Home recommended) | 5 min | ✅ Yes |
| **3** | [Clean Installation](phase3.md) – Fresh Windows install offline | 20–30 min | ✅ Yes |
| **4** | [Key Purging](phase4.md) – Remove corporate licenses, lock edition | 5 min | ✅ Yes |
| **5** | [Telemetry & MDM Kill](phase5.md) – Disable tracking services | 5 min | ✅ Yes |
| **6** | [Hosts File Block](phase6.md) – Block Microsoft domains | 5 min | ✅ Yes |
| **7** | [Firewall Blocking](phase7.md) – Block MDM processes at firewall | 5 min | ✅ Yes |
| **8** | [Hosts Watchdog](phase8.md) – Auto-restore hosts file | 5 min | ⭕ Optional |
| **9** | [Final Connection to Internet](phase9.md) – Safe account setup after all defenses active | 5–10 min | ✅ Yes |

**Total time: ~1–2 hours** (including 30 min for Windows installation)

!!! warning "Critical: Internet Until Phase 9"
    All phases 1-8 must be completed **while disconnected from the internet**. Only after all 8 protective layers are active is it safe to connect the network cable and proceed to Phase 9. This principle applies regardless of which Windows edition you chose in Phase 2.

## Navigate to Each Phase

1. [Phase 1 - BIOS/Hardware Cleanup](phase1.md)
2. [Phase 2 - Edition Selection (Home Recommended)](phase2.md)
3. [Phase 3 - Clean Offline Installation](phase3.md)
4. [Phase 4 - License Purge & Protection](phase4.md)
5. [Phase 5 - Disable MDM Services](phase5.md)
6. [Phase 6 - Block Enrollment Servers](phase6.md)
7. [Phase 7 - Firewall Process Blocking](phase7.md)
8. [Phase 8 - Hosts Watchdog Auto-Restore (Optional)](phase8.md)
9. [Phase 9 - Internet Connection & Account Setup](phase9.md)

!!! tip "Pro Tip"
    Take screenshots of each major step. If something goes wrong, these help you troubleshoot or remember where you left off.
