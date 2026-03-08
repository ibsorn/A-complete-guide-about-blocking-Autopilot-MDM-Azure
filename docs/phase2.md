# Phase 2: USB Preparation (Force Windows 11 Home)

Note: Installing the Windows 11 Home version is optional but highly recommended. The Home version lacks the internal components necessary to join an Azure domain or run Autopilot. By forcing this version, we add a structural barrier against the old company.

Since corporate laptops have the Pro license engraved on the motherboard, the installer will read it automatically. To prevent this:

1. Create a USB with the official Windows 11 image using Microsoft's tool.

2. Connect the USB to your current device and open the folder called `sources`.

3. Right-click in an empty space and choose **New > Text Document**.

4. Paste exactly the following lines:

   ```
   [EditionID]
   Core
   [Channel]
   Retail
   [VL]
   0
   ```

5. Select **File > Save As**. In the "Type" option, choose **All files (.)**. Name the file exactly `ei.cfg` and save it.