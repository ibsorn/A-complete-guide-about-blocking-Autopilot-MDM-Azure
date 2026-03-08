# Complete Guide to Blocking Autopilot, MDM, and Azure

This comprehensive guide walks you through the process of removing Microsoft Autopilot, Mobile Device Management (MDM), and Azure AD (Entra ID) management from Windows devices. Whether you've inherited a corporate-locked computer or need to reclaim control over your device, this documentation provides the exact steps needed.

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
