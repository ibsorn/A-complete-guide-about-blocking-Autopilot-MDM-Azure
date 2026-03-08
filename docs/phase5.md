# Phase 5: Telemetry and MDM Module Deactivation

We will cut off at the root the Windows services responsible for remote administration.

In the same Administrator CMD, run these two commands to disable the MDM routing engine:

```powershell
sc stop dmwappushservice
sc config dmwappushservice start= disabled
```

Run these two to turn off corporate telemetry:

```powershell
sc stop DiagTrack
sc config DiagTrack start= disabled
```

Run this command on a single line to prohibit mobile device enrollment:

```powershell
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\MDM" /v DisableRegistration /t REG_DWORD /d 1 /f
```

Run this command to block automatic joining to Azure (Entra ID) in the background:

```powershell
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WorkplaceJoin" /v BlockAADWorkplaceJoin /t REG_DWORD /d 1 /f
```