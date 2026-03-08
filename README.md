# Blocking Autopilot, MDM & Azure

This repository hosts a step-by-step guide to remove Microsoft Autopilot, Mobile Device Management (MDM) and Azure/Entra ID management from Windows devices.

The documentation is built with MkDocs and published automatically to GitHub Pages via the existing workflow. Simply push changes to the `main` branch and GitHub Actions will rebuild the `gh-pages` branch.

See `docs/index.md` for the introduction and navigate through the phases.

## Building locally

Install Python and the requirements:

```powershell
pip install -r requirements.txt
mkdocs serve
```
