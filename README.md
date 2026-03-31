# DevFolio 🎯

<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&height=200&animation=twinkling&text=DevFolio" alt="header"/>
  <br>
  <img src="https://komarev.com/ghpvc/?username=devfolio&label=Profile%20Views&color=ff6b6b&style=flat" alt="views"/>
  <a href="https://github.com/rickyparmar-bot/devfolio/stargazers"><img src="https://img.shields.io/github/stars/rickyparmar-bot/devfolio?v=2" alt="stars"/></a>
  <a href="https://github.com/rickyparmar-bot/devfolio/network/members"><img src="https://img.shields.io/github/forks/rickyparmar-bot/devfolio?v=2" alt="forks"/></a>
  <img src="https://img.shields.io/github/license/rickyparmar-bot/devfolio" alt="license"/>
  <img src="https://img.shields.io/github/languages/code-size/rickyparmar-bot/devfolio" alt="size"/>
</p>

> ⚡ Generate stunning developer portfolios in seconds! Stand out with beautiful GitHub READMEs, dynamic stats, and personalized themes.

---

## ✨ Features

### 🎨 Multiple Themes
- **Cyberpunk** - Neon glow aesthetic
- **Minimal** - Clean and simple
- **Ocean** - Blue waves vibe  
- **Fire** - Flaming hot design
- **Forest** - Nature-inspired
- **Dark** - Classic dark mode

### 📊 Dynamic Stats
- GitHub stats with custom colors
- Streak counter with fire animation
- Top languages pie chart
- Contribution graph
- Trophy showcase

### 🏆 Badges & Trophies
- Auto-generated badges
- Custom badge support
- Trophy showcase
- Activity milestones

### 🔄 Auto-Update
- GitHub Actions integration
- Scheduled updates
- No manual work needed

---

## 🚀 Quick Start

```bash
# Clone the repo
git clone https://github.com/rickyparmar-bot/devfolio.git
cd devfolio

# Run the generator
chmod +x devfolio.sh
./devfolio.sh
```

---

## 🎯 Usage

### Interactive Mode
```bash
./devfolio.sh
```
Follow the prompts to customize your portfolio!

### Quick Generate
```bash
./devfolio.sh --theme cyberpunk --username yourname
```

### Available Options
```bash
--theme, -t        Choose theme (cyberpunk/minimal/ocean/fire/forest/dark)
--username, -u     Your GitHub username
--stats            Include stats section
--badges           Include badges section
--trophies         Include trophies
--streak           Include streak counter
--help, -h         Show this help message
```

---

## 📁 Project Structure

```
devfolio/
├── devfolio.sh          # Main generator script
├── themes/              # Theme configurations
│   ├── cyberpunk.sh
│   ├── minimal.sh
│   ├── ocean.sh
│   ├── fire.sh
│   ├── forest.sh
│   └── dark.sh
├── templates/           # README templates
│   ├── basic.md
│   ├── advanced.md
│   └── minimal.md
├── actions/             # GitHub Actions for auto-update
│   └── update.yml
├── utils/               # Helper scripts
│   ├── stats.sh
│   ├── badges.sh
│   └── streak.sh
├── examples/            # Example outputs
├── docs/                 # Documentation
├── CONTRIBUTING.md
├── LICENSE
└── README.md
```

---

## 🖥️ Preview

### Cyberpunk Theme
![Cyberpunk](https://user-images.githubusercontent.com/placeholder/cyberpunk.png)

### Stats Preview
![Stats](https://github-readme-stats.vercel.app/api?username=devfolio&theme=radical)

### Streak Preview
![Streak](https://github-readme-streak-stats.herokuapp.com/?user=devfolio&theme=radical)

---

## 🔧 Configuration

### Set GitHub Username
```bash
export GITHUB_USERNAME="yourusername"
```

### Choose Theme
```bash
export DEFAULT_THEME="cyberpunk"
```

### Enable Auto-Update
```bash
cp actions/update.yml .github/workflows/devfolio.yml
```

---

## 🤝 Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) first.

1. Fork the repo
2. Create your feature branch (`git checkout -b feature/amazing`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing`)
5. Open a Pull Request

---

## ⭐ Show Your Support

Give a ⭐ if this project helped you!

[![Star](https://img.shields.io/github/stars/rickyparmar-bot/devfolio?style=social)](https://github.com/rickyparmar-bot/devfolio)

---

## 📝 License

MIT License - See [LICENSE](LICENSE)

---

## 🧑‍💻 Created By

**Ricky Parmar**
- GitHub: [@rickyparmar-bot](https://github.com/rickyparmar-bot)
- Instagram: [@ricky_._parmar](https://instagram.com/ricky_._parmar)

---

<div align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&height=100&text=Made%20with%20❤️" alt="footer"/>
</div>