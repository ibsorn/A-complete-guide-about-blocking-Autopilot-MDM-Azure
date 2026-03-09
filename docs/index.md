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

The process is divided into **nine phases**, each building on the previous one. The first 8 phases are comprehensive and sufficient. Phase 9 is optional but recommended, adding automatic watchdog protection. Start with Phase 1 and proceed in order.

### Quick Overview

| Phase | What Happens | Time | Required |
|-------|--------------|------|----------|
| **1** | [Deep Hardware Cleanup](phase1.md) – Clear BIOS tracking | 5–10 min | ✅ Yes |
| **2** | [USB Preparation](phase2.md) – Force Windows 11 Home edition | 5 min | ✅ Yes |
| **3** | [Clean Installation](phase3.md) – Fresh Windows install offline | 20–30 min | ✅ Yes |
| **4** | [Key Purging](phase4.md) – Lock in Home edition | 5 min | ✅ Yes |
| **5** | [Telemetry & MDM Kill](phase5.md) – Disable tracking services | 5 min | ✅ Yes |
| **6** | [Hosts File Block](phase6.md) – Block Microsoft domains | 5 min | ✅ Yes |
| **7** | [Final Setup](phase7.md) – Secure your personal account | 5 min | ✅ Yes |
| **8** | [Firewall Blocking](phase8.md) – Block MDM processes | 5 min | ✅ Yes |
| **9** | [Hosts Watchdog](phase9.md) – Auto-restore hosts file | 5 min | ⭕ Optional |

**Total time: ~1–2 hours** (including 30 min for Windows installation)

!!! note "Phase 9 is Optional"
    Phases 1-8 provide complete protection. Phase 9 adds automatic hosts file restoration if Windows updates attempt to modify it. Highly recommended for long-term device ownership, but not strictly required.

## Navigate to Each Phase

1. [Phase 1 - Deep Hardware Cleanup](phase1.md)
2. [Phase 2 - USB Preparation (force Windows 11 Home)](phase2.md)
3. [Phase 3 - Clean Installation and Network Bypass](phase3.md)
4. [Phase 4 - Key Purging and Version Lock](phase4.md)
5. [Phase 5 - Telemetry and MDM Module Deactivation](phase5.md)
6. [Phase 6 - Server Blocking in the Hosts File](phase6.md)
7. [Phase 7 - Final Connection and Safe Use](phase7.md)
8. [Phase 8 - Application-Level Firewall Blocking](phase8.md)
9. [Phase 9 - Hosts File Watchdog (Optional)](phase9.md)

!!! tip "Pro Tip"
    Take screenshots of each major step. If something goes wrong, these help you troubleshoot or remember where you left off.
