#!/bin/bash

# DevFolio - Developer Portfolio Generator
# Version: 1.0.0
# Author: Ricky Parmar

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

show_banner() {
	echo -e "${CYAN}"
	echo "╔═══════════════════════════════════════════════════════════════════╗"
	echo "║                                                                   ║"
	echo "║   ███████╗ ██████╗ ██████╗ ██╗    ██╗    ██████╗  █████╗ ██████╗  ║"
	echo "║   ██╔════╝██╔═══██╗██╔══██╗██║    ██║   ██╔════╝ ██╔══██╗██╔══██╗ ║"
	echo "║   █████╗  ██║   ██║██████╔╝██║ █╗ ██║   ██║  ███╗███████║██████╔╝ ║"
	echo "║   ██╔══╝  ██║   ██║██╔══██╗██║███╗██║   ██║   ██║██╔══██║██╔══██╗ ║"
	echo "║   ███████╗╚██████╔╝██║  ██║╚███╔███╔╝   ╚██████╔╝██║  ██║██║  ██║ ║"
	echo "║   ╚══════╝ ╚═════╝ ╚═╝  ╚═╝ ╚══╝╚══╝    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ║"
	echo "║                                                                   ║"
	echo "║          ⚡ Portfolio Generator for Developers ⚡                 ║"
	echo "╚═══════════════════════════════════════════════════════════════════╝${NC}"
	echo
}

show_help() {
	echo -e "${YELLOW}Usage: $0 [OPTIONS]${NC}"
	echo
	echo "Options:"
	echo "  -u, --username    Your GitHub username"
	echo "  -t, --theme       Theme to use (cyberpunk/minimal/ocean/fire/forest/dark)"
	echo "  --no-stats        Don't include stats"
	echo "  --no-badges       Don't include badges"
	echo "  --no-trophies     Don't include trophies"
	echo "  --no-streak       Don't include streak"
	echo "  -h, --help        Show this help message"
	echo
	echo "Examples:"
	echo "  $0 --username john --theme cyberpunk"
	echo "  $0 -u john -t minimal --no-trophies"
	echo "  $0 --help"
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

# Interactive mode if no username
if [ -z "$USERNAME" ]; then
	show_banner
	echo -e "${YELLOW}Let's create your portfolio!${NC}"
	echo
	read -p "Enter your GitHub username: " USERNAME
	echo
	echo -e "Available themes:"
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

echo -e "${GREEN}[*] Generating portfolio for ${CYAN}$USERNAME${GREEN} with ${CYAN}$THEME${GREEN} theme...${NC}"

# Colors based on theme
get_colors() {
	case $THEME in
	cyberpunk)
		PRIMARY="#ff00ff"
		SECONDARY="#00ffff"
		ACCENT="#ffff00"
		BACKGROUND="#0d0d0d"
		;;
	minimal)
		PRIMARY="#333333"
		SECONDARY="#666666"
		ACCENT="#007acc"
		BACKGROUND="#ffffff"
		;;
	ocean)
		PRIMARY="#0077b6"
		SECONDARY="#00b4d8"
		ACCENT="#90e0ef"
		BACKGROUND="#03045e"
		;;
	fire)
		PRIMARY="#ff4500"
		SECONDARY="#ff6b35"
		ACCENT="#ffa500"
		BACKGROUND="#1a0a00"
		;;
	forest)
		PRIMARY="#228b22"
		SECONDARY="#90ee90"
		ACCENT="#006400"
		BACKGROUND="#0d1f0d"
		;;
	dark)
		PRIMARY="#58a6ff"
		SECONDARY="#8b949e"
		ACCENT="#7ee787"
		BACKGROUND="#0d1117"
		;;
	esac
}

# Generate README content
generate_readme() {
	cat >README.md <<'EOF'
# DevFolio 🎯

<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&height=200&animation=twinkling&text=DevFolio" alt="header"/>
  <br>
  <img src="https://komarev.com/ghpvc/?username=USERNAME&label=Profile%20Views&color=ff6b6b&style=flat" alt="views"/>
  <a href="https://github.com/USERNAME/devfolio/stargazers"><img src="https://img.shields.io/github/stars/USERNAME/devfolio?v=2" alt="stars"/></a>
  <a href="https://github.com/USERNAME/devfolio/network/members"><img src="https://img.shields.io/github/forks/USERNAME/devfolio?v=2" alt="forks"/></a>
</p>

> ⚡ Generate stunning developer portfolios in seconds!

---

## ✨ Features

- 🎨 Multiple beautiful themes
- 📊 Dynamic GitHub stats
- 🔄 Auto-update with GitHub Actions
- 🏆 Trophy showcase
- 📈 Streak counter

---

## 🚀 Quick Start

```bash
git clone https://github.com/USERNAME/devfolio.git
cd devfolio
./devfolio.sh --username YOUR_NAME --theme cyberpunk
```

---

## ⭐ Show Your Support

Give a ⭐ if this helped!

---

<div align="center">
  Made with ❤️ by USERNAME
</div>
EOF

	# Replace USERNAME placeholder
	sed -i "s/USERNAME/$USERNAME/g" README.md
}

# Create theme files
create_themes() {
	mkdir -p themes

	# Cyberpunk theme
	cat >themes/cyberpunk.sh <<'EOF'
export PRIMARY="#ff00ff"
export SECONDARY="#00ffff"
export ACCENT="#ffff00"
export STATS_THEME="radical"
EOF

	# Minimal theme
	cat >themes/minimal.sh <<'EOF'
export PRIMARY="#333333"
export SECONDARY="#666666"
export ACCENT="#007acc"
export STATS_THEME="default"
EOF

	# Ocean theme
	cat >themes/ocean.sh <<'EOF'
export PRIMARY="#0077b6"
export SECONDARY="#00b4d8"
export ACCENT="#90e0ef"
export STATS_THEME="ocean"
EOF

	# Fire theme
	cat >themes/fire.sh <<'EOF'
export PRIMARY="#ff4500"
export SECONDARY="#ff6b35"
export ACCENT="#ffa500"
export STATS_THEME="fire"
EOF

	# Forest theme
	cat >themes/forest.sh <<'EOF'
export PRIMARY="#228b22"
export SECONDARY="#90ee90"
export ACCENT="#006400"
export STATS_THEME="green"
EOF

	# Dark theme
	cat >themes/dark.sh <<'EOF'
export PRIMARY="#58a6ff"
export SECONDARY="#8b949e"
export ACCENT="#7ee787"
export STATS_THEME="dark"
EOF

	echo -e "${GREEN}[✓] Themes created${NC}"
}

# Create GitHub Actions
create_actions() {
	mkdir -p .github/workflows

	cat >.github/workflows/update.yml <<'EOF'
name: Update Profile

on:
  schedule:
    - cron: '0 * * * *'
  workflow_dispatch:

jobs:
  update:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run DevFolio
        run: |
          chmod +x devfolio.sh
          ./devfolio.sh --username ${{ secrets.USERNAME }} --theme dark
      - name: Commit and Push
        run: |
          git config --local user.email "github-actions[bot]@users.noreply.github.com"
          git config --local user.name "github-actions[bot]"
          git add -A
          git commit -m "Update portfolio" || exit 0
          git push
EOF

	echo -e "${GREEN}[✓] GitHub Actions created${NC}"
}

# Create utils
create_utils() {
	mkdir -p utils

	cat >utils/stats.sh <<'EOF'
#!/bin/bash
echo "![Stats](https://github-readme-stats.vercel.app/api?username=\$1&theme=\$2&hide_border=true)"
EOF

	cat >utils/streak.sh <<'EOF'
#!/bin/bash
echo "![Streak](https://github-readme-streak-stats.herokuapp.com/?user=\$1&theme=\$2)"
EOF

	chmod +x utils/*.sh
	echo -e "${GREEN}[✓] Utils created${NC}"
}

# Main execution
show_banner
get_colors
generate_readme
create_themes
create_actions
create_utils

echo
echo -e "${GREEN}╔═══════════════════════════════════════════════════════════════╗"
echo -e "║                    🎉 PORTFOLIO GENERATED! 🎉                      ║"
echo -e "╚═══════════════════════════════════════════════════════════════════════╝${NC}"
echo
echo -e "Files created:"
echo "  - README.md"
echo "  - themes/"
echo "  - .github/workflows/"
echo "  - utils/"
echo
echo -e "${YELLOW}Next steps:${NC}"
echo "  1. Review README.md"
echo "  2. Push to your GitHub"
echo "  3. Share with friends!"
echo
