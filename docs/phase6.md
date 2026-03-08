# Phase 6: Server Blocking in the Hosts File

We will prevent the device from contacting Microsoft's deployment domains, shielding the file so that antivirus doesn't revert it.

1. Open the Start menu, search for **Notepad** and open it as Administrator.

2. Go to **File > Open**. Navigate to `C:\Windows\System32\drivers\etc`. Change the bottom view to **All files (.)** and open the `hosts` file.

3. Add these two lines at the end of the text, save (Ctrl+S) and close Notepad:

   ```
   0.0.0.0 ztd.desktop.microsoft.com
   0.0.0.0 cs.dds.microsoft.com
   ```

4. Open **Windows Security > Virus & threat protection > Manage settings**. Scroll down to "Exclusions", click **Add or remove exclusions > Add exclusion > File**. Select the hosts file you just modified.

5. Open File Explorer, go to `C:\Windows\System32\drivers\etc`, right-click on the hosts file > **Properties**, check the **Read-only** box and click **OK**.