<img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&height=200&animation=twinkling&text=DevFolio" alt="header"/>

<p align="center">
  <a href="https://github.com/rickyparmar-bot/devfolio/stargazers"><img src="https://img.shields.io/github/stars/rickyparmar-bot/devfolio?label=Stars&style=social" alt="stars"/></a>
  <a href="https://github.com/rickyparmar-bot/devfolio/network/members"><img src="https://img.shields.io/github/forks/rickyparmar-bot/devfolio?label=Forks&style=social" alt="forks"/></a>
  <img src="https://img.shields.io/github/license/rickyparmar-bot/devfolio" alt="license"/>
</p>

⚡ Generate stunning developer portfolios in seconds! Stand out with beautiful GitHub READMEs, dynamic stats, and personalized themes.

## ✨ Features

- 🎨 **6 Beautiful Themes**: Cyberpunk, Minimal, Ocean, Fire, Forest, Dark
- 📊 **Dynamic GitHub Stats**: Using github-readme-stats API
- 🔥 **Streak Counter**: GitHub contribution streaks
- 🏆 **Trophies**: Auto-generated trophy showcase
- ⚙️ **GitHub Actions**: Auto-update your profile every 6 hours
- 🛠️ **Utility Scripts**: Real stats/streak fetchers
- 📝 **Config File**: Regenerate anytime from `.devfolio` config

## 🚀 Quick Start

### Generate Your Portfolio

```bash
git clone https://github.com/rickyparmar-bot/devfolio.git
cd devfolio
chmod +x devfolio.sh
./devfolio.sh --username YOUR_USERNAME --theme cyberpunk
```

### Interactive Mode

```bash
./devfolio.sh
```

### Options

| Option | Description | Default |
|--------|------------|---------|
| `-u, --username` | GitHub username | (required) |
| `-t, --theme` | Theme name | cyberpunk |
| `-o, --output` | Output directory | current |
| `--no-stats` | Skip stats section | false |
| `--no-badges` | Skip badges section | false |
| `--no-trophies` | Skip trophies | false |
| `--no-streak` | Skip streak | false |

## 🎨 Themes

### Cyberpunk
Neon glow aesthetic with pink/cyan accents.

### Minimal  
Clean and simple — perfect for professionals.

### Ocean
Blue waves vibe — calm and cool.

### Fire
Flaming hot design — for the bold.

### Forest
Nature-inspired — organic and fresh.

### Dark
Classic dark mode — GitHub's default style.

## 📁 Generated Files

```
your-profile/
├── README.md              # Your profile page
├── .github/
│   └── workflows/
│       └── update.yml   # Auto-update workflow
├── utils/
│   ├── stats.sh       # Fetch user stats
│   ├── streak.sh     # Fetch streak data
│   └── badges.sh    # Generate badges
└── .devfolio        # Config for regeneration
```

## 🔄 Auto-Update Setup

1. Create a **classic personal access token** (repo scope)
2. Go to your profile repo → Settings → Secrets
3. Add new secret: `GH_TOKEN`
4. Enable GitHub Actions
5. Workflow runs every 6 hours automatically!

## 🛠️ Tech Stack

- **Shell**: Pure bash, no dependencies
- **APIs**: github-readme-stats, github-profile-trophy
- **CDN**: Vercel for dynamic badges

## 🤝 Contributing

1. Fork the repo
2. Create feature branch: `git checkout -b feature/amazing`
3. Commit changes: `git commit -m 'Add amazing feature'`
4. Push: `git push origin feature/amazing`
5. Open PR 🎉

## ⚠️ v2.0 Changes (Fixed!)

- ✅ Fixed broken badge URLs
- ✅ Fixed workflow secret requirement
- ✅ Added real utility scripts
- ✅ Proper username substitution
- ✅ Reduced cron to 6 hours (was hourly = rate limit hell)
- ✅ Added error handling
- ✅ Config file for regeneration

## �� License

MIT License — See [LICENSE](LICENSE)

## 👤 Author

**Ricky Parmar**
- GitHub: [@rickyparmar-bot](https://github.com/rickyparmar-bot)
- Project: [DevFolio](https://github.com/rickyparmar-bot/devfolio)

---

<p align="center">
  Give a ⭐ if this helped!
</p>