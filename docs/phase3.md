# Phase 3: Clean Installation and Network Bypass (BypassNRO)

1. Physically disconnect the laptop from the internet (no Ethernet cable, and if necessary, temporarily turn off your Wi-Fi router).

2. Boot the device from the USB and start the installation.

3. When you reach the screen "Where do you want to install Windows?", select each existing partition one by one and press **Delete** until the entire disk is "Unallocated Space". Select that space and press **Next**.

4. When the installation finishes and the first configuration screen appears ("Is this the correct country or region?"), press **Shift + F10** (or **Shift + Fn + F10**) to open the command console (CMD).

5. Type exactly `oobe\bypassnro` and press Enter.

6. The device will restart. Reselect the country and keyboard. When you reach the network screen, a new option will appear at the bottom: **"I have no internet"**. Click it.

7. Select **Continue with limited setup**, create a local user account (e.g., `Admin`), and finish until you reach the desktop.