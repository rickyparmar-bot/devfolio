#!/bin/bash

# DevFolio - Developer Portfolio Generator
# Version: 3.0 - PRO EDITION
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
NAME=""
BIO=""
LOCATION=""
WEBSITE=""
TWITTER=""
LINKEDIN=""
INSTAGRAM=""
GITHUB=""
INCLUDE_STATS=true
INCLUDE_BADGES=true
INCLUDE_TROPHIES=true
INCLUDE_STREAK=true
INCLUDE_REPOS=true
OUTPUT_DIR="."

# Theme configs with more options
declare -A THEME_CONFIGS
THEME_CONFIGS[cyberpunk]="primary=#ff00ff,secondary=#00ffff,accent=#ffff00,bg=#0d0d0d,stats=radical,card_bg=#161b22"
THEME_CONFIGS[minimal]="primary=#333333,secondary=#666666,accent=#007acc,bg=#ffffff,stats=default,card_bg=#f6f8fa"
THEME_CONFIGS[ocean]="primary=#0077b6,secondary=#00b4d8,accent=#90e0ef,bg=#03045e,stats=ocean,card_bg=#0a2540"
THEME_CONFIGS[fire]="primary=#ff4500,secondary=#ff6b35,accent=#ffa500,bg=#1a0a00,stats=fire,card_bg=#2d1810"
THEME_CONFIGS[forest]="primary=#228b22,secondary=#90ee90,accent=#006400,bg=#0d1f0d,stats=green_gruvbox,card_bg=#1a2f1a"
THEME_CONFIGS[dark]="primary=#58a6ff,secondary=#8b949e,accent=#7ee787,bg=#0d1117,stats=dark,card_bg=#161b22"

show_banner() {
	echo -e "${CYAN}"
	cat <<'BANNER'
╔═══════════════════════════════════════════════════════════════════════════╗
║                      ⚡ DevFolio PRO ⚡                     ║
║              Version 3.0 - Enhanced Edition                   ║
║                                                                   ║
║   ███████╗ ██████╗ ██████╗ ██╗    ██╗    ██████╗  █████╗ ██████╗  ║
║   ██╔════╝██╔═══██╗██╔══██╗██║    ██║   ██╔════╝ ██╔══██╗██╔══██╗ ║
║   █████╗  ██║   ██║██████╔╝██║ █╗ ██║   ██║  ███╗███████║██████╔╝ ║
║   ██╔══╝  ██║   ██║██╔══██╗██║███╗██║   ██║   ██║██╔══██║██╔══██╗ ║
║   ███████╗╚██████╔╝██║  ██║╚███╔███╔╝   ╚██████╔╝██║  ██║██║  ██║ ║
║   ╚══════╝ ╚═════╝ ╚═╝  ╚═╝ ╚══╝╚══╝    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ║
╚═══════════════════════════════════════════════════════════════════════════╝
BANNER
	echo
}

show_help() {
	echo -e "${YELLOW}Usage: $0 [OPTIONS]${NC}"
	echo
	echo "Options:"
	echo "  -u, --username   GitHub username (required)"
	echo "  -n, --name       Display name"
	echo "  -b, --bio        Short bio"
	echo "  -l, --location  Your location"
	echo "  -w, --website   Your website"
	echo "  -t, --twitter   Twitter handle"
	echo "  --theme         Theme: cyberpunk|minimal|ocean|fire|forest|dark"
	echo "  -o, --output   Output directory"
	echo "  --no-stats      Skip stats"
	echo "  --no-badges    Skip badges"
	echo "  --no-trophies  Skip trophies"
	echo "  --no-streak    Skip streak"
	echo "  --no-repos     Skip recent repos"
}

parse_args() {
	while [[ $# -gt 0 ]]; do
		case $1 in
		-u | --username) USERNAME="$2" ; shift 2 ;;
		-n | --name) NAME="$2" ; shift 2 ;;
		-b | --bio) BIO="$2" ; shift 2 ;;
		-l | --location) LOCATION="$2" ; shift 2 ;;
		-w | --website) WEBSITE="$2" ; shift 2 ;;
		-t | --twitter) TWITTER="$2" ; shift 2 ;;
		--linkedin) LINKEDIN="$2" ; shift 2 ;;
		--instagram) INSTAGRAM="$2" ; shift 2 ;;
		-t | --theme) THEME="$2" ; shift 2 ;;
		-o | --output) OUTPUT_DIR="$2" ; shift 2 ;;
		--no-stats) INCLUDE_STATS=false ; shift ;;
		--no-badges) INCLUDE_BADGES=false ; shift ;;
		--no-trophies) INCLUDE_TROPHIES=false ; shift ;;
		--no-streak) INCLUDE_STREAK=false ; shift ;;
		--no-repos) INCLUDE_REPOS=false ; shift ;;
		-h | --help) show_help ; exit 0 ;;
		*) echo -e "${RED}Unknown: $1" ; show_help ; exit 1 ;;
		esac
	done
}

interactive_mode() {
	show_banner
	echo -e "${YELLOW}Let's build your PRO profile!${NC}"
	echo
	read -p "GitHub username: " USERNAME
	read -p "Display name (ENTER for $USERNAME): " NAME
	[ -z "$NAME" ] && NAME="$USERNAME"
	read -p "Short bio: " BIO
	read -p "Location: " LOCATION
	read -p "Website (optional): " WEBSITE
	read -p "Twitter handle (optional): " TWITTER
	read -p "Instagram handle (optional): " INSTAGRAM
	echo
	echo "Choose theme:"
	echo "  1. cyberpunk  2. minimal  3. ocean  4. fire  5. forest  6. dark"
	read -p "Theme [1]: " THEME_CHOICE
	case $THEME_CHOICE in
	2) THEME="minimal" ;;
	3) THEME="ocean" ;;
	4) THEME="fire" ;;
	5) THEME="forest" ;;
	6) THEME="dark" ;;
	*) THEME="cyberpunk" ;;
	esac
}

get_config() {
	local config="${THEME_CONFIGS[$THEME]}"
	IFS=',' read -ra C <<< "$config"
	for c in "${C[@]}"; do
		IFS='=' read -r k v <<< "$c"
		case $k in primary) PRIMARY="$v" ;; secondary) SECONDARY="$v" ;; accent) ACCENT="$v" ;; bg) BACKGROUND="$v" ;; stats) STATS_THEME="$v" ;; card_bg) CARD_BG="$v" ;; esac
	done
}

fetch_repos() {
	REPOS=$(curl -s "https://api.github.com/users/$USERNAME/repos?sort=updated&per_page=6" 2>/dev/null | jq -r '.[] | "- [\(.name)](\(.html_url)): \(.description // "No description")"' 2>/dev/null || echo "")
}

generate_readme() {
	local readme="$OUTPUT_DIR/README.md"
	
	[ -z "$NAME" ] && NAME="$USERNAME"
	[ -z "$BIO" ] && BIO="Building cool stuff 🤖"
	
	# Build social links
	local socials=""
	[ -n "$TWITTER" ] && socials+="[![Twitter](https://img.shields.io/badge/-@$TWITTER-1DA1F2?style=flat&logo=twitter&logoColor=white)](https://twitter.com/$TWITTER) "
	[ -n "$LINKEDIN" ] && socials+="[![LinkedIn](https://img.shields.io/badge/-Connect-0077B5?style=flat&logo=linkedin&logoColor=white)](https://linkedin.com/in/$LINKEDIN) "
	[ -n "$INSTAGRAM" ] && socials+="[![Instagram](https://img.shields.io/badge/-@$INSTAGRAM-E4405F?style=flat&logo=instagram&logoColor=white)](https://instagram.com/$INSTAGRAM) "
	[ -n "$WEBSITE" ] && socials+="[![Website](https://img.shields.io/badge/-Website-$PRIMARY?style=flat&logo=firefox&logoColor=white)]($WEBSITE) "
	socials+="[![GitHub](https://img.shields.io/badge/-Follow-$PRIMARY?style=flat&logo=github&logoColor=white)](https://github.com/$USERNAME)"
	
	cat > "$readme" <<HEADER
<div align="center">

# 👋 Hi, I'm **$NAME**!

$([ -n "$BIO" ] && echo "*$BIO*")

<p>

![header](https://capsule-render.vercel.app/api?type=waving&color=gradient&height=180&animation=twinkling&text=$NAME&fontSize=60)

</p>

$([ -n "$LOCATION" ] && echo "<p align=\"center\">📍 $LOCATION</p>")

$socials

---

</div>

HEADER

	# Stats section
	if [ "$INCLUDE_STATS" = true ]; then
		cat >> "$readme" <<STATS

## 📊 GitHub Stats

<p align="center">

<img src="https://github-readme-stats.vercel.app/api?username=$USERNAME&theme=$STATS_THEME&hide_border=true&title_color=$PRIMARY&text_color=$SECONDARY&icon_color=$ACCENT&bg_color=$CARD_BG" height="165"/>

<img src="https://github-readme-stats.vercel.app/api/top-langs/?username=$USERNAME&theme=$STATS_THEME&hide_border=true&title_color=$PRIMARY&text_color=$SECONDARY&icon_color=$ACCENT&bg_color=$CARD_BG&layout=pie" height="165"/>

</p>
STATS
	fi

	# Streak section
	if [ "$INCLUDE_STREAK" = true ]; then
		cat >> "$readme" <<STREAK

## 🔥 Streak

<p align="center">

<img src="https://github-readme-streak-stats.herokuapp.com/?user=$USERNAME&theme=$STATS_THEME&hide_border=true&fire=$PRIMARY&ring=$SECONDARY&stroke=$ACCENT" alt="streak"/>

</p>
STREAK
	fi

	# Trophies section
	if [ "$INCLUDE_TROPHIES" = true ]; then
		cat >> "$readme" <<TROPHY

## 🏆 Trophies

<p align="center">

<img src="https://github-profile-trophy.vercel.app/?username=$USERNAME&theme=$THEME&no-frame=true&column=3&margin-w=10&margin-h=10" alt="trophy"/>

</p>
TROPHY
	fi

	# Recent repos section
	if [ "$INCLUDE_REPOS" = true ]; then
		cat >> "$readme" <<REPOS

## 🛠️ Recent Projects

<p align="center">

$REPOS

</p>
REPOS
	fi

	# Tech stack / badges
	if [ "$INCLUDE_BADGES" = true ]; then
		cat >> "$readme" <<BADGES

## 🧰 Tech Stack

<p align="center">

<!-- Dynamic tech badges would go here -->
<img src="https://skillicons.dev/icons?tags=$([ -n "$TECH_STACK" ] && echo "$TECH_STACK" || echo "bash,arduino,esp32,python,embedded")" alt="techstack"/>

</p>
BADGES
	fi

	# Footer
	cat >> "$readme" <<FOOTER

---

<div align="center">

### 📈 Activity Graph

<img src="https://github-readme-activity-graph.vercel.app/graph?username=$USERNAME&theme=$THEME&hide_border=true&color=$PRIMARY" alt="activity"/>

---

<img src="https://komarev.com/ghpvc/?username=$USERNAME&label=Profile+Views&color=$PRIMARY&style=flat" alt="views"/>

*Last updated: $(date '+%Y-%m-%d')*

**Made with ❤️ using [DevFolio](https://github.com/rickyparmar-bot/devfolio)**

</div>
FOOTER

	echo -e "${GREEN}[✓] PRO README generated${NC}"
}

create_workflow() {
	mkdir -p "$OUTPUT_DIR/.github/workflows"
	cat > "$OUTPUT_DIR/.github/workflows/update.yml" <<EOF
name: Update Profile

on:
  schedule:
    - cron: '0 */6 * * *'
  workflow_dispatch:
  push:
    branches: [main]

jobs:
  update:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Update with DevFolio
        run: |
          chmod +x devfolio.sh
          ./devfolio.sh --username \${{ github.repository.owner }} --theme dark --output .
      - name: Commit
        if: github.event_name != 'pull_request'
        run: |
          git config user.email "github-actions[bot]@users.noreply.github.com"
          git config user.name "github-actions[bot]"
          git add -A
          git commit -m "Update profile" || exit 0
          git push https://x-access-token:\${{ secrets.GH_TOKEN }}@github.com/\${{ github.repository }} --force
EOF
	echo -e "${GREEN}[✓] Workflow created${NC}"
}

create_install_script() {
	cat > "$OUTPUT_DIR/install.sh" <<'INSTALL'
#!/bin/bash
# DevFolio Quick Install
# Run: chmod +x install.sh && ./install.sh

echo "🔧 Setting up DevFolio..."

# Check dependencies
command -v jq >/dev/null 2>&1 || { echo "Installing jq..."; apt update && apt install -y jq; }

# Generate profile
read -p "GitHub username: " USERNAME
read -p "Theme [cyberpunk]: " THEME
THEME=${THEME:-cyberpunk}

chmod +x devfolio.sh
./devfolio.sh --username "$USERNAME" --theme "$THEME"

echo "✅ Done! Check README.md"
INSTALL
	chmod +x "$OUTPUT_DIR/install.sh"
}

save_config() {
	cat > "$OUTPUT_DIR/.devfolio" <<EOF
USERNAME=$USERNAME
NAME=$NAME
BIO=$BIO
LOCATION=$LOCATION
WEBSITE=$WEBSITE
TWITTER=$TWITTER
LINKEDIN=$LINKEDIN
INSTAGRAM=$INSTAGRAM
THEME=$THEME
EOF
}

main() {
	parse_args "$@"
	
	if [ -z "$USERNAME" ]; then
		interactive_mode
	fi
	
	if [[ ! -v THEME_CONFIGS[$THEME] ]]; then
		echo -e "${RED}Invalid theme: $THEME${NC}"
		exit 1
	fi
	
	OUTPUT_DIR="${OUTPUT_DIR%/}"
	mkdir -p "$OUTPUT_DIR"
	
	get_config
	fetch_repos
	
	show_banner
	echo -e "${GREEN}[*] Generating PRO profile for $USERNAME...${NC}"
	
	generate_readme
	create_workflow
	create_install_script
	save_config
	
	echo
	echo -e "${GREEN}╔════════════════════════════════════════╗"
	echo -e "║   🎉 PROFILE GENERATED! 🎉          ║"
	echo -e "╚════════════════════════════════════╝${NC}"
}

main "$@"