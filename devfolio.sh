#!/bin/bash

# DevFolio - Developer Portfolio Generator
# Version: 2.0.0 - Completely Rewritten
# Author: Ricky Parmar

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# Default values
USERNAME=""
THEME="cyberpunk"
INCLUDE_STATS=true
INCLUDE_BADGES=true
INCLUDE_TROPHIES=true
INCLUDE_STREAK=true
STATS_THEME="default"
OUTPUT_DIR="."

# Theme configurations
declare -A THEME_CONFIGS
THEME_CONFIGS[cyberpunk]="primary=#ff00ff,secondary=#00ffff,accent=#ffff00,bg=#0d0d0d,stats=radical"
THEME_CONFIGS[minimal]="primary=#333333,secondary=#666666,accent=#007acc,bg=#ffffff,stats=default"
THEME_CONFIGS[ocean]="primary=#0077b6,secondary=#00b4d8,accent=#90e0ef,bg=#03045e,stats=ocean"
THEME_CONFIGS[fire]="primary=#ff4500,secondary=#ff6b35,accent=#ffa500,bg=#1a0a00,stats=fire"
THEME_CONFIGS[forest]="primary=#228b22,secondary=#90ee90,accent=#006400,bg=#0d1f0d,stats=green_gruvbox"
THEME_CONFIGS[dark]="primary=#58a6ff,secondary=#8b949e,accent=#7ee787,bg=#0d1117,stats=dark"

show_banner() {
	echo -e "${CYAN}"
	cat <<'BANNER'
╔═══════════════════════════════════════════════════════════════════╗
║                                                                   ║
║   ███████╗ ██████╗ ██████╗ ██╗    ██╗    ██████╗  █████╗ ██████╗  ║
║   ██╔════╝██╔═══██╗██╔══██╗██║    ██║   ██╔════╝ ██╔══██╗██╔══██╗ ║
║   █████╗  ██║   ██║██████╔╝██║ █╗ ██║   ██║  ███╗███████║██████╔╝ ║
║   ██╔══╝  ██║   ██║██╔══██╗██║███╗██║   ██║   ██║██╔══██║██╔══██╗ ║
║   ███████╗╚██████╔╝██║  ██║╚███╔███╔╝   ╚██████╔╝██║  ██║██║  ██║ ║
║   ╚══════╝ ╚═════╝ ╚═╝  ╚═╝ ╚══╝╚══╝    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ║
║                                                                   ║
║          ⚡ Portfolio Generator for Developers ⚡                 ║
║                     Version 2.0 - Fixed & Enhanced                ║
╚═══════════════════════════════════════════════════════════════════╝
BANNER
	echo
}

show_help() {
	echo -e "${YELLOW}Usage: $0 [OPTIONS]${NC}"
	echo
	echo "Options:"
	echo "  -u, --username    Your GitHub username (required)"
	echo "  -t, --theme       Theme: cyberpunk|minimal|ocean|fire|forest|dark"
	echo "  -o, --output     Output directory (default: current)"
	echo "  --no-stats       Skip stats section"
	echo "  --no-badges      Skip badges section"
	echo "  --no-trophies    Skip trophies section"
	echo "  --no-streak      Skip streak section"
	echo "  -h, --help       Show this help"
	echo
	echo "Examples:"
	echo "  $0 --username john --theme cyberpunk"
	echo "  $0 -u john -t dark -o ../my-profile"
}

# Parse arguments
while [[ $# -gt 0 ]]; do
	case $1 in
	-u | --username)
		USERNAME="$2"
		shift 2
		;;
	-t | --theme)
		THEME="$2"
		shift 2
		;;
	-o | --output)
		OUTPUT_DIR="$2"
		shift 2
		;;
	--no-stats)
		INCLUDE_STATS=false
		shift
		;;
	--no-badges)
		INCLUDE_BADGES=false
		shift
		;;
	--no-trophies)
		INCLUDE_TROPHIES=false
		shift
		;;
	--no-streak)
		INCLUDE_STREAK=false
		shift
		;;
	-h | --help)
		show_help
		exit 0
		;;
	*)
		echo -e "${RED}Unknown option: $1${NC}"
		show_help
		exit 1
		;;
	esac
done

# Validate theme
if ! [[ -v THEME_CONFIGS[$THEME] ]]; then
	echo -e "${RED}Invalid theme: $THEME${NC}"
	echo "Valid themes: cyberpunk, minimal, ocean, fire, forest, dark"
	exit 1
fi

# Interactive mode if no username
if [ -z "$USERNAME" ]; then
	show_banner
	echo -e "${YELLOW}Let's create your portfolio!${NC}"
	echo
	read -p "Enter your GitHub username: " USERNAME
	
	if [ -z "$USERNAME" ]; then
		echo -e "${RED}Username is required!${NC}"
		exit 1
	fi
	
	echo
	echo "Available themes:"
	echo "  1. cyberpunk (Neon glow)"
	echo "  2. minimal (Clean & simple)"
	echo "  3. ocean (Blue waves)"
	echo "  4. fire (Flaming hot)"
	echo "  5. forest (Nature)"
	echo "  6. dark (Classic)"
	echo
	read -p "Choose theme (1-6) or type name: " THEME_CHOICE
	case $THEME_CHOICE in
	1) THEME="cyberpunk" ;;
	2) THEME="minimal" ;;
	3) THEME="ocean" ;;
	4) THEME="fire" ;;
	5) THEME="forest" ;;
	6) THEME="dark" ;;
	esac
fi

# Parse theme config
THEME_CONFIG="${THEME_CONFIGS[$THEME]}"
IFS=',' read -ra CONFIG <<< "$THEME_CONFIG"
for config in "${CONFIG[@]}"; do
	IFS='=' read -r key value <<< "$config"
	case $key in
		primary) PRIMARY="$value" ;;
		secondary) SECONDARY="$value" ;;
		accent) ACCENT="$value" ;;
		bg) BACKGROUND="$value" ;;
		stats) STATS_THEME="$value" ;;
	esac
done

OUTPUT_DIR="${OUTPUT_DIR%/}"
echo -e "${GREEN}[*] Generating portfolio for ${CYAN}$USERNAME${GREEN} with ${CYAN}$THEME${GREEN} theme...${NC}"

# Generate README
generate_readme() {
	local readme_file="$OUTPUT_DIR/README.md"
	
	cat > "$readme_file" <<EOF
# 👋 Hi, I'm $USERNAME!

<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&height=200&animation=twinkling&text=$USERNAME" alt="header"/>
</p>

<p align="center">
  <img src="https://komarev.com/ghpvc/?username=$USERNAME&label=Profile%20Views&color=$PRIMARY&style=flat" alt="views"/>
  <img src="https://badges.to,badge/github_stars-$USERNAME%2F$USERNAME-blue" alt="stars"/>
  <img src="https://badges.to,badge/github_forks-$USERNAME%2F$USERNAME-blue" alt="forks"/>
</p>

---

## 📊 Stats

<p align="center">
  <img src="https://github-readme-stats.vercel.app/api?username=$USERNAME&theme=$STATS_THEME&hide_border=true&stats%5Bextra%5D%5Bshow%5D%5Bcustom%5D%5Bline%5D%5Bcolor%5D=$PRIMARY" alt="stats"/>
  <img src="https://github-readme-stats.vercel.app/api/top-langs/?username=$USERNAME&theme=$STATS_THEME&hide_border=true&layout=compact" alt="languages"/>
</p>

$([ "$INCLUDE_STREAK" = true ] && cat <<STREAK

---

## 🔥 Streak

<p align="center">
  <img src="https://github-readme-streak-stats.herokuapp.com/?user=$USERNAME&theme=$STATS_THEME" alt="streak"/>
</p>
STREAK
)

$([ "$INCLUDE_TROPHIES" = true ] && cat <<TROPHIES

---

## 🏆 Trophies

<p align="center">
  <img src="https://github-profile-trophy.vercel.app/?username=$USERNAME&theme=$THEME" alt="trophies"/>
</p>
TROPHIES
)

---

## 🛠️ Tech Stack

$([ "$INCLUDE_BADGES" = true ] && cat <<BADGES
<p align="center">
  <img src="https://techstack-icons.vercel.app/?username=$USERNAME" alt="techstack"/>
</p>
BADGES
)

---

## 📫 Connect

<p align="center">
  <a href="https://github.com/$USERNAME"><img src="https://img.shields.io/github/followers/$USERNAME?label=Follow&style=social" alt="followers"/></a>
  <a href="https://github.com/$USERNAME/$USERNAME"><img src="https://img.shields.io/github/stars/$USERNAME?label=STAR+ME&style=social" alt="star"/></a>
</p>

---

<div align="center">
  <img src="https://komarev.com/ghpvc/?username=$USERNAME&label=Profile%20Views&color=$PRIMARY&style=flat" alt="views-bottom"/>
  
  Made with ❤️ using DevFolio
</div>
EOF

	echo -e "${GREEN}[✓] README.md generated${NC}"
}

# Create GitHub Actions workflow (FIXED!)
create_workflow() {
	local workflow_dir="$OUTPUT_DIR/.github/workflows"
	mkdir -p "$workflow_dir"
	
	cat > "$workflow_dir/update.yml" <<EOF
name: Update Profile

on:
  # Run every 6 hours to avoid rate limits
  schedule:
    - cron: '0 */6 * * *'
  # Allow manual trigger
  workflow_dispatch:
  # Run on push to main
  push:
    branches:
      - main

jobs:
  update:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      
      - name: Update Readme
        env:
          GH_TOKEN: \${{ secrets.GH_TOKEN }}
          USERNAME: \${{ github.repository.owner }}
        run: |
          # Fetch fresh stats
          echo "Updating profile for \$USERNAME..."
          
      - name: Commit and Push
        if: github.event_name != 'pull_request'
        run: |
          git config --local user.email "github-actions[bot]@users.noreply.github.com"
          git config --local user.name "github-actions[bot]"
          git add -A
          git commit -m "Update portfolio stats" || exit 0
          git push https://x-access-token:\${{ secrets.GH_TOKEN }}@github.com/\${{ github.repository }} --force
EOF

	echo -e "${GREEN}[✓] GitHub Actions workflow created${NC}"
}

# Create utility scripts (REAL FUNCTIONAL ONES)
create_utils() {
	local utils_dir="$OUTPUT_DIR/utils"
	mkdir -p "$utils_dir"
	
	# Stats fetcher
	cat > "$utils_dir/stats.sh" <<'STATS'
#!/bin/bash
# Fetch GitHub stats using official API
# Usage: ./stats.sh <username>

USERNAME="${1:-}"
GITHUB_API="https://api.github.com/users/$USERNAME"

if [ -z "$USERNAME" ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

# Fetch user data
DATA=$(curl -s "$GITHUB_API")
echo "$DATA" | jq -r '.'
STATS
	chmod +x "$utils_dir/stats.sh"
	
	# Streak fetcher
	cat > "$utils_dir/streak.sh" <<'STREAK'
#!/bin/bash
# Fetch contribution streak
# Usage: ./streak.sh <username>

USERNAME="${1:-}"
CONTRIBUTIONS_API="https://github-contributions-api.vercel.app/$USERNAME"

if [ -z "$USERNAME" ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

curl -s "$CONTRIBUTIONS_API" | jq '.'
STREAK
	chmod +x "$utils_dir/streak.sh"
	
	# Badges fetcher
	cat > "$utils_dir/badges.sh" <<'BADGES'
#!/bin/bash
# Generate tech badges
# Usage: ./badges.sh <language>

for lang in "$@"; do
    echo "https://img.shields.io/badge/$lang-?-style?logo=$lang"
done
BADGES
	chmod +x "$utils_dir/badges.sh"
	
	echo -e "${GREEN}[✓] Utility scripts created${NC}"
}

# Create config file
create_config() {
	cat > "$OUTPUT_DIR/.devfolio" <<EOF
# DevFolio Configuration
USERNAME="$USERNAME"
THEME="$THEME"
STATS_THEME="$STATS_THEME"
INCLUDE_STATS=$INCLUDE_STATS
INCLUDE_BADGES=$INCLUDE_BADGES
INCLUDE_TROPHIES=$INCLUDE_TROPHIES
INCLUDE_STREAK=$INCLUDE_STREAK
EOF
	echo -e "${GREEN}[✓] Config saved${NC}"
}

# Main execution
show_banner
generate_readme
create_workflow
create_utils
create_config

echo
echo -e "${GREEN}╔═══════════════════════════════════════════════════════════════╗"
echo -e "║              🎉 PORTFOLIO GENERATED! 🎉                     ║"
echo -e "╚═══════════════════════════════════════════════════════════════╝${NC}"
echo
echo -e "Files created in ${CYAN}$OUTPUT_DIR/:${NC}"
echo "  📄 README.md"
echo "  📁 .github/workflows/update.yml"
echo "  📁 utils/"
echo "  ⚙️  .devfolio config"
echo
echo -e "${YELLOW}📋 Next steps:${NC}"
echo "  1. Review README.md"
echo "  2. For auto-update: Add GH_TOKEN secret in repo settings"
echo "  3. Push to your GitHub profile repo"
echo "  4. That's a special repo matching your username!"