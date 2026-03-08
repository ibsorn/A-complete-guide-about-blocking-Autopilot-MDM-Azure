# Phase 1: Deep Hardware Cleanup (BIOS/UEFI)

Before installing Windows, we must destroy any cryptographic traces or tracking software anchored in the old company's motherboard.

1. Turn on the device and enter the BIOS/UEFI (usually by pressing F2, F10, F12, Del, or Esc repeatedly when starting up).

2. **Clean the TPM module**: Look for the Security tab. Locate the option related to the TPM chip (it may be called TPM Security, Security Chip, or Intel PTT/AMD fTPM). Select the Clear TPM (Clear TPM) or Reset to Factory option. This will delete any corporate certificates or keys physically stored in the chip.

3. **Disable the Absolute Persistence Module (Computrace)**: In the same Security tab, check if the device has options called Absolute Persistence, Computrace, or Lojack. If it does, change its status to Permanently Disable. Save the changes and exit the BIOS.