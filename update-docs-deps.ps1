<#
.SYNOPSIS
    Update and optionally sync documentation dependencies for Arctyk Docs.

.DESCRIPTION
    Recompiles requirements.txt and dev-requirements.txt from their *.in files
    using pip-tools. Optionally syncs the current virtual environment so it
    matches the compiled lockfiles exactly.
#>

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host " Arctyk Docs – Dependency Updater "   -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan

# Ensure pip-tools is installed
if (-not (pip show pip-tools | Out-Null)) {
    Write-Host "`nInstalling pip-tools..." -ForegroundColor Yellow
    pip install pip-tools
}

# Step 1 – Compile base requirements
Write-Host "`nCompiling requirements.in → requirements.txt" -ForegroundColor Green
pip-compile --upgrade requirements.in

# Step 2 – Compile dev requirements
Write-Host "`nCompiling dev-requirements.in → dev-requirements.txt" -ForegroundColor Green
pip-compile --upgrade dev-requirements.in

# Step 3 – Ask whether to sync environment
$sync = Read-Host "`nWould you like to sync your docs environment now? (y/n)"
if ($sync -eq "y") {
    Write-Host "`nSyncing environment..." -ForegroundColor Green
    pip-sync dev-requirements.txt
}
else {
    Write-Host "`nSkipping sync. You can run 'pip-sync dev-requirements.txt' later." -ForegroundColor Yellow
}

Write-Host "`n Documentation dependencies updated successfully!" -ForegroundColor Cyan
