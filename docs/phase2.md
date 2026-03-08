# Phase 2: USB Preparation (Recommended: Force Windows 11 Home)

## Overview

The **easiest and most reliable path** to breaking free from Autopilot is installing **Windows 11 Home** instead of Pro. Here's why:

- **Home Edition** has no Autopilot enrollment capabilities, no Azure AD join integration, and no built-in MDM support
- **Pro Edition** (which is usually pre-installed) comes with all enterprise management features enabled
- Corporate devices have the Pro license engraved in the motherboard's firmware, so the standard Windows installer will automatically upgrade to Pro if you don't intervene

### Why Home Edition Makes Sense

| Aspect | Home | Pro |
|--------|------|-----|
| **Autopilot Support** | No | Yes (enabled by default) |
| **Azure AD Join** | No | Yes (enabled by default) |
| **MDM Enrollment** | Limited | Full |
| **Enterprise Control** | Minimal | Maximum |

!!! info "Alternative: Modified Windows 11 Versions"

    If you prefer **not** to use Home edition, you have alternatives:

    - **Windows 11 Enterprise LTSC** (if you can obtain it) has Autopilot components that can be disabled post-install
    - **Windows 11 with Autopilot components removed** – Some community-modified versions exist, though these are less official and require finding reliable sources

    However, **forcing Home edition remains the simplest, most straightforward approach** and is recommended for most users.

In this phase, you'll **intercept the Windows 11 installer and force it to install Home edition** by creating a special configuration file on the installation media. If you choose a different approach, skip to Phase 3 and adapt the instructions accordingly.

**Time required:** 5 minutes  
**What you need:** 
- Windows 11 installation media (USB drive with Windows 11 image)
- A computer to prepare it on
- Administrator rights on that computer

!!! tip "Why Bother with This?"
    Installing Home edition creates a **structural barrier** against Autopilot. Even if Phase 1–6 have issues, Home edition alone prevents enterprise enrollment. It's defense-in-depth.

---

## Step-by-Step Instructions

### Step 1: Create or Obtain Windows 11 USB Media

If you don't already have a Windows 11 USB:

1. Go to [Microsoft's Windows 11 download page](https://www.microsoft.com/software-download/windows11)
2. Use the **"Create installation media"** tool
3. Follow the wizard to download Windows 11 onto a USB drive (minimum 8 GB)
4. Plug the USB into the locked corporate device

If you already have a Windows 11 USB, proceed to Step 2.

!!! tip "USB Preparation"
    Make sure the USB is truly blank or you're okay erasing it – the next steps will modify files on it. If you're reusing an old installation USB, that's fine.

### Step 2: Open the USB and Navigate to the `sources` Folder

1. **Safely eject any USB drives** from your computer
2. **Plug in the Windows 11 USB** you just created
3. **Open File Explorer** and find the USB drive (usually `D:` or `E:`, labeled as something like "WININSTALL")
4. Look for the folder called `sources` – go inside it

!!! note "Cannot Find sources Folder?"
    If you don't see a `sources` folder at the root of the USB, your USB media might not be set up correctly. Try creating the media again using Microsoft's Media Creation Tool.

### Step 3: Create the `ei.cfg` File

This special file tells the Windows installer: "Install Home edition, not Pro."

**Option A: Manual Creation**

1. **Right-click in an empty area** of the `sources` folder
2. Choose **New > Text Document**
3. A file called `New Text Document.txt` will appear – open it
4. **Delete everything** and copy-paste **exactly** these lines:

```
[EditionID]
Core
[Channel]
Retail
[VL]
0
```

!!! warning "Exact Formatting Required"
    - Do NOT add extra spaces or blank lines
    - The section names must be `[EditionID]`, `[Channel]`, and `[VL]` in square brackets
    - Each value must be on its own line
    - Save as UTF-8 or ANSI (not UTF-8 with BOM)

**Option B: Download Pre-Made File**

If you prefer not to create the file manually, you can download a ready-made `ei.cfg` file:

[📥 Download ei.cfg](assets/downloads/ei.cfg){: .md-button }

Simply:
1. Download the file above
2. Copy it to the `sources` folder on your USB
3. Skip to Step 4 below

### Step 4: Save or Move the File as `ei.cfg`

If you created it manually (Option A):

1. Press **Ctrl + S** or go to **File > Save As**
2. At the bottom, change the file type from **"Text Documents (*.txt)"** to **"All Files (.)"**
3. Change the filename from `New Text Document.txt` to **`ei.cfg`** (no `.txt` extension)
4. Click **Save**

If you downloaded it (Option B):

1. Move the downloaded `ei.cfg` file into the `sources` folder on your USB
2. That's it – it's already in the correct format

!!! success "File in Place"
    You should now see a file called `ei.cfg` in the `sources` folder. If you see `ei.cfg.txt`, you saved it wrong – delete it and try again, making sure the file type is set to "All Files (.)".

### Step 5: Verify the File

1. Right-click on `ei.cfg` and select **Properties**
2. Confirm:
   - Filename is exactly: `ei.cfg`
   - Type is: "Configuration Settings" or just "File"
   - NOT a text file with a `.txt` extension

3. Close Properties
4. **Safely eject the USB** (right-click in File Explorer > Eject)

!!! tip "Keep This USB Safe"
    This USB is now customized for your device. Keep it somewhere safe – you'll use it in Phase 3 to install Windows.

---

## What Happens Next

When you boot from this USB in Phase 3, the Windows installer will:
1. Detect the `ei.cfg` file
2. Automatically select Home edition (instead of asking which version to install)
3. Install Windows 11 Home, blocking any automatic upgrade to Pro

This is the key that prevents Autopilot from re-enrolling your device automatically.

!!! note "Why ei.cfg Works"
    The `ei.cfg` file is a legitimate part of Windows deployment. Microsoft's own enterprise deployment teams use it. By using it, we're telling Windows: "This is a retail (consumer) install, with Home edition only."
