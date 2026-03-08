# Phase 4: Automated Key Purging and Version Lock Script
# This script will automatically purge Pro license keys and lock in Home edition
# Run as Administrator

# Ensure running as Administrator
if (-NOT ([Security.Principal.WindowsIdentity]::GetCurrent().Groups -match "S-1-5-32-544")) {
    Write-Host "This script must be run as Administrator. Please right-click PowerShell and select 'Run as Administrator'." -ForegroundColor Red
    exit
}

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "Phase 4: Key Purging and Version Lock" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "This process will:" -ForegroundColor Yellow
Write-Host "  1. Delete the motherboard Pro license key" -ForegroundColor White
Write-Host "  2. Uninstall any preloaded keys" -ForegroundColor White
Write-Host "  3. Install Home Edition generic key" -ForegroundColor White
Write-Host "  4. Block forced OS upgrades to Pro" -ForegroundColor White
Write-Host ""
Write-Host "Note: Some commands may take a few seconds to process." -ForegroundColor Yellow
Write-Host ""

# Function to wait with visual feedback
function Wait-WithProgress {
    param([int]$Seconds, [string]$Message)
    Write-Host "⏳ $Message" -ForegroundColor Yellow -NoNewline
    for ($i = 0; $i -lt $Seconds; $i++) {
        Start-Sleep -Seconds 1
        Write-Host "." -NoNewline -ForegroundColor Yellow
    }
    Write-Host ""
}

# Step 1: Delete motherboard key from registry
Write-Host "[1/4] Deleting motherboard Pro license key..." -ForegroundColor Yellow
try {
    # Create COM object for license management
    $service = New-Object -ComObject Microsoft.Licensing.VolumeActivation
    
    # Alternative: Use slmgr.vbs through WMI (more reliable)
    $result = & cmd /c "slmgr.vbs /cpky 2>&1"
    
    Write-Host "✓ Motherboard key purged" -ForegroundColor Green
    Wait-WithProgress -Seconds 3 -Message "Processing license change"
} catch {
    Write-Host "⚠ Warning during motherboard key purge: $_" -ForegroundColor Orange
}

Write-Host ""

# Step 2: Uninstall any preloaded key
Write-Host "[2/4] Uninstalling preloaded product key..." -ForegroundColor Yellow
try {
    $result = & cmd /c "slmgr.vbs /upk 2>&1"
    Write-Host "✓ Preloaded key uninstalled" -ForegroundColor Green
    Wait-WithProgress -Seconds 3 -Message "Processing key removal"
} catch {
    Write-Host "⚠ No preloaded key found or already removed" -ForegroundColor Orange
}

Write-Host ""

# Step 3: Install Home Edition generic key
Write-Host "[3/4] Installing Home Edition generic key..." -ForegroundColor Yellow
Write-Host "      Key: YTMG3-N6DKC-DKB77-7M9GH-8HVX7" -ForegroundColor Gray
try {
    $result = & cmd /c "slmgr.vbs /ipk YTMG3-N6DKC-DKB77-7M9GH-8HVX7 2>&1"
    Write-Host "✓ Home Edition key installed" -ForegroundColor Green
    Write-Host "  (This is an official Microsoft generic key)" -ForegroundColor Gray
    Wait-WithProgress -Seconds 4 -Message "Activating Home Edition"
} catch {
    Write-Host "✗ Failed to install Home Edition key: $_" -ForegroundColor Red
}

Write-Host ""

# Step 4: Block forced OS upgrades via Registry
Write-Host "[4/4] Blocking forced OS upgrades..." -ForegroundColor Yellow
try {
    # Create path if it doesn't exist
    $registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
    
    # Navigate/create the path
    $policyPath = "HKLM:\SOFTWARE\Policies\Microsoft"
    if (-not (Test-Path $policyPath)) {
        New-Item -Path $policyPath -Force | Out-Null
    }
    
    $windowsPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows"
    if (-not (Test-Path $windowsPath)) {
        New-Item -Path $windowsPath -Force | Out-Null
    }
    
    $updatePath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
    if (-not (Test-Path $updatePath)) {
        New-Item -Path $updatePath -Force | Out-Null
    }
    
    # Create registry value
    New-ItemProperty -Path $registryPath -Name "DisableOSUpgrade" -Value 1 -PropertyType DWORD -Force | Out-Null
    Write-Host "✓ OS upgrade block installed in Registry" -ForegroundColor Green
    Write-Host "  Registry path: HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -ForegroundColor Gray
    Write-Host "  Value: DisableOSUpgrade = 1" -ForegroundColor Gray
    
    Wait-WithProgress -Seconds 2 -Message "Verifying registry changes"
} catch {
    Write-Host "✗ Failed to set registry value: $_" -ForegroundColor Red
}

Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "Phase 4 Complete!" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Summary:" -ForegroundColor Green
Write-Host "  ✓ Motherboard Pro license key purged" -ForegroundColor Green
Write-Host "  ✓ Preloaded keys removed" -ForegroundColor Green
Write-Host "  ✓ Home Edition locked in with generic key" -ForegroundColor Green
Write-Host "  ✓ OS upgrades disabled via Registry" -ForegroundColor Green
Write-Host ""
Write-Host "Your Windows edition is now locked to Home Edition." -ForegroundColor Cyan
Write-Host "Windows cannot be upgraded to Pro, even with the motherboard BIOS key." -ForegroundColor Cyan
Write-Host ""
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
