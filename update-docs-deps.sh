#!/usr/bin/env bash
# ============================================================
# Arctyk Docs – Dependency Updater (Linux/macOS version)
# ============================================================
# Recompiles requirements.txt and dev-requirements.txt using pip-tools.
# Optionally syncs the environment so it matches the compiled lockfiles.
# ------------------------------------------------------------
# Usage:
#   chmod +x update-docs-deps.sh
#   ./update-docs-deps.sh
# ============================================================

set -e

CYAN='\033[1;36m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No color

echo -e "${CYAN}=====================================${NC}"
echo -e "${CYAN} Arctyk Docs – Dependency Updater ${NC}"
echo -e "${CYAN}=====================================${NC}"

# Ensure pip-tools is installed
if ! python -m pip show pip-tools >/dev/null 2>&1; then
  echo -e "\n${YELLOW}Installing pip-tools...${NC}"
  python -m pip install pip-tools
fi

# Step 1: Compile base requirements
echo -e "\n${GREEN}Compiling requirements.in → requirements.txt${NC}"
pip-compile --upgrade requirements.in

# Step 2: Compile dev requirements
echo -e "\n${GREEN}Compiling dev-requirements.in → dev-requirements.txt${NC}"
pip-compile --upgrade dev-requirements.in

# Step 3: Prompt for sync
read -p $'\nWould you like to sync your docs environment now? (y/n) ' sync_choice
if [[ "$sync_choice" == "y" || "$sync_choice" == "Y" ]]; then
  echo -e "\n${GREEN}Syncing environment...${NC}"
  pip-sync dev-requirements.txt
else
  echo -e "\n${YELLOW}Skipping sync. Run 'pip-sync dev-requirements.txt' later.${NC}"
fi

echo -e "\n${CYAN}✅ Documentation dependencies updated successfully!${NC}"
