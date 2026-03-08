# Breaking Free from Autopilot

> **Complete Technical Guide to Bypass Microsoft Autopilot, MDM, and Azure Enrollment on Windows 11**

A **comprehensive, step-by-step guide** to completely remove Microsoft Autopilot locks, Mobile Device Management (MDM) enrollment, and Azure/Entra ID enrollment from Windows devices—regaining full control of your computer.

**Keywords:** Autopilot bypass, MDM removal, Azure enrollment removal, Windows 11 unlock, corporate device unlock, Device Management bypass, Windows enterprise removal

## 📖 Read the Complete Guide Online

The full interactive documentation with code examples and automated scripts is published at:

👉 **[https://ibsorn.github.io/Breaking-Free-from-Autopilot/](https://ibsorn.github.io/Breaking-Free-from-Autopilot/)**

## What This Guide Does

Microsoft's Autopilot and Device Management systems lock corporate devices to prevent unauthorized access and modifications. If you've inherited or obtained a device locked to your former employer's Azure/Entra ID tenant, this guide provides the **exact technical steps** to completely remove all locks without reinstalling Windows from scratch.

- Clear BIOS-level tracking and enrollment records
- Force Windows 11 Home edition (preventing Autopilot re-enrollment)
- Disable MDM services and telemetry
- Block enrollment servers at the OS level
- Reclaim full control with a personal Microsoft account

**All seven phases are thoroughly documented with:**
- Step-by-step instructions for both manual and automated approaches
- Downloadable PowerShell scripts to automate complex phases
- Troubleshooting guides for common issues
- Security tips for preventing re-enrollment

## 🚀 Quick Start

1. **Visit the website:** https://ibsorn.github.io/Breaking-Free-from-Autopilot/
2. **Start with Phase 1:** Deep Hardware Cleanup (BIOS/UEFI)
3. **Follow through Phase 7:** Final security setup
4. **Total time:** 1–2 hours for the complete process

## 📁 Repository Structure

```
docs/
  ├── index.md              # Introduction & phase overview
  ├── phase1.md–phase7.md   # Seven detailed phases
  └── assets/downloads/     # Downloadable scripts & files
    ├── ei.cfg
    ├── phase4-lock-home-edition.ps1
    ├── phase5-disable-mdm.ps1
    ├── phase6-block-servers.ps1
    └── phase7-verify-protection.ps1
mkdocs.yml                  # MkDocs configuration
requirements.txt            # Python dependencies
```

## 🛠️ For Developers / Contributing

This documentation is built with **MkDocs** + **Material for MkDocs** theme and automatically published to GitHub Pages on every push.

### Build Locally

Install Python 3.7+ and the required dependencies:

```powershell
pip install -r requirements.txt
mkdocs serve
```

Then visit `http://localhost:8000` in your browser.

### Make Changes

1. Edit `.md` files in the `docs/` folder
2. Commit and push to the `main` branch
3. GitHub Actions automatically rebuilds and publishes to `gh-pages`

### Add/Update Scripts

Scripts are stored in `docs/assets/downloads/` and automatically available for download on the website.

## ⚠️ Disclaimer

This guide is provided for educational purposes. Users are responsible for understanding the legal implications of modifying device ownership and enrollment status in their jurisdiction. Always ensure you have legal rights to the device before making these modifications.

## 📄 License

See `LICENSE` file for licensing details.

---

**Website:** https://ibsorn.github.io/Breaking-Free-from-Autopilot/  
**Repository:** https://github.com/ibsorn/breaking-free-from-autopilot
