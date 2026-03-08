# Phase 6: Automated Hosts File Modification Script
# This script will automatically block Microsoft Autopilot and enrollment servers
# Run as Administrator

# Ensure running as Administrator
if (-NOT ([Security.Principal.WindowsIdentity]::GetCurrent().Groups -match "S-1-5-32-544")) {
    Write-Host "This script must be run as Administrator. Please right-click PowerShell and select 'Run as Administrator'." -ForegroundColor Red
    exit
}

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "Phase 6: Blocking Autopilot Enrollment Servers" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

$hostsPath = "C:\Windows\System32\drivers\etc\hosts"

# Step 1: Remove read-only flag FIRST (before attempting to modify)
Write-Host "[1/4] Preparing hosts file..." -ForegroundColor Yellow
try {
    $hostsFile = Get-Item $hostsPath -ErrorAction SilentlyContinue
    if ($hostsFile.Attributes -match "ReadOnly") {
        Set-ItemProperty -Path $hostsPath -Name Attributes -Value ($hostsFile.Attributes -bxor [System.IO.FileAttributes]::ReadOnly)
        Write-Host "✓ Read-only attribute removed" -ForegroundColor Green
    }
} catch {
    Write-Host "⚠ Could not remove read-only flag: $_" -ForegroundColor Orange
}

Write-Host ""

# Step 2: Check if entries already exist
Write-Host "[2/4] Checking hosts file..." -ForegroundColor Yellow
$hostsContent = Get-Content $hostsPath -Raw

if ($hostsContent -match "ztd.desktop.microsoft.com") {
    Write-Host "✓ Autopilot servers already blocked" -ForegroundColor Green
} else {
    # Step 3: Add blocking entries
    Write-Host "[3/4] Adding blocking entries to hosts file..." -ForegroundColor Yellow
    try {
        $newEntries = @"
`n# Autopilot and Enrollment Servers (Phase 6)
0.0.0.0 ztd.desktop.microsoft.com
0.0.0.0 cs.dds.microsoft.com
"@
        Add-Content -Path $hostsPath -Value $newEntries -Encoding ASCII
        Write-Host "✓ Blocking entries added" -ForegroundColor Green
    } catch {
        Write-Host "✗ Failed to add entries: $_" -ForegroundColor Red
        exit
    }
}

Write-Host ""

# Step 4: Protect hosts file (set back to read-only)
Write-Host "[4/4] Protecting hosts file..." -ForegroundColor Yellow
try {
    # Set read-only flag
    Set-ItemProperty -Path $hostsPath -Name Attributes -Value (Get-Item $hostsPath).Attributes -bor [System.IO.FileAttributes]::ReadOnly
    Write-Host "✓ Hosts file set to read-only" -ForegroundColor Green
} catch {
    Write-Host "⚠ Could not set read-only flag: $_" -ForegroundColor Orange
}

Write-Host ""

# Step 5: Add to Windows Defender exclusions
Write-Host "[5/5] Adding hosts file to Windows Defender exclusions..." -ForegroundColor Yellow
try {
    # Check if Windows Defender is available
    $defenderStatus = Get-Service WinDefend -ErrorAction SilentlyContinue
    if ($defenderStatus) {
        Add-MpPreference -ExclusionPath $hostsPath -Force -ErrorAction SilentlyContinue
        Write-Host "✓ Hosts file added to Defender exclusions" -ForegroundColor Green
    } else {
        Write-Host "⚠ Windows Defender not available, skipping exclusion" -ForegroundColor Orange
    }
} catch {
    Write-Host "⚠ Could not add to Defender exclusions: $_" -ForegroundColor Orange
}

Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "Phase 6 Complete!" -ForegroundColor Cyan
Write-Host "Autopilot servers are now blocked." -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Optional: Verify the entries
Write-Host "Verification - Current hosts entries:" -ForegroundColor Yellow
Select-String -Path $hostsPath -Pattern "ztd.desktop.microsoft.com|cs.dds.microsoft.com" | ForEach-Object { Write-Host $_.Line -ForegroundColor Green }

Write-Host ""
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
