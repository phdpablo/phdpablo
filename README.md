Hi ![](https://user-images.githubusercontent.com/18350557/176309783-0785949b-9127-417c-8b55-ab5a4333674e.gif)My name is Pablo Rogers
====================================================================================================================================

Data Scientist | Researcher & Finance Specialist
------------------------------------------------

Personal website built with [Quarto](https://quarto.org/) and hosted on GitHub Pages.

🌍 Based in Uberlândia, Minas Gerais, Brazil  
🖥️ See my portfolio at [phdpablo.com](https://www.phdpablo.com)  
🚀 Currently working on [educational materials for data analysts and scientists](http://www.youtube.com/c/PsicoEconoMETRIA)  

---

## How to Update Content

All repeating content (publications, projects, CV) lives in YAML data files inside `_data/`. Edit the appropriate file and re-render.

### Add a New Publication

1. Open `_data/publications.yml`
2. Add an entry at the top of the file:
   ```yaml
   - year: 2026
     title: "Your New Article Title"
     journal: "Journal Name"
     url: "https://doi.org/..."
   ```
3. Run `quarto render` to rebuild the site.

### Add a New Portfolio Project

1. Open `_data/projects.yml`
2. Add an entry (use an existing `area` or create a new one):
   ```yaml
   - area: Finance
     title: "Project Title"
     objectives: "Brief description of the objectives."
     data: "Description of data used."
     methodology: "Techniques employed."
   ```
3. Run `quarto render`.

### Update CV (Skills or Timeline)

1. Open `_data/cv.yml`
2. To add a **skill**, find the appropriate section (`domain`, `analytical`, or `technical`) and add:
   ```yaml
   - name: "New Skill"
     level: 80
   ```
3. To add a **timeline event**, add to the `timeline` list:
   ```yaml
   - content: "New Position or Degree"
     start: "2026-01-01"
     group: "Education"  # or "Experience" or "Teaching"
   ```
4. Run `quarto render`.

---

## Project Structure

```
├── _data/                  # Data files (edit these to update content)
│   ├── publications.yml    # All publications
│   ├── projects.yml        # Portfolio projects
│   └── cv.yml              # Skills & timeline
├── _filters/
│   └── render-data.lua     # Lua filter for YAML → HTML rendering
├── custom.scss             # Design system (colors, typography, components)
├── _quarto.yml             # Quarto configuration
├── index.qmd               # Landing page
├── about.qmd               # About me
├── cv.qmd                  # Curriculum (skills + timeline)
├── papers.qmd              # Publications
├── portfolio.qmd           # Portfolio
├── psico.qmd               # Psico&Econo_METRIA project
├── img/                    # Images
└── docs/                   # Built site (GitHub Pages)
```

## Design System

Colors are defined as SCSS tokens in `custom.scss`:

| Token        | Hex       | Usage                          |
|-------------|-----------|-------------------------------|
| `$orange`    | `#F18C22` | Accents, CTAs, highlights     |
| `$teal`      | `#87CBCC` | Secondary, links, badges      |
| `$dark-blue` | `#0D232C` | Primary, backgrounds, text    |

## Build & Preview

```bash
quarto render          # Build the site to docs/
quarto preview         # Live preview with hot reload
```

---

### Socials

<p align="left"> <a href="https://www.facebook.com/psicoeconometria" target="_blank" rel="noreferrer"> <picture> <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/danielcranney/readme-generator/main/public/icons/socials/facebook-dark.svg" /> <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/danielcranney/readme-generator/main/public/icons/socials/facebook.svg" /> <img src="https://raw.githubusercontent.com/danielcranney/readme-generator/main/public/icons/socials/facebook.svg" width="32" height="32" /> </picture> </a> <a href="https://www.github.com/phdpablo" target="_blank" rel="noreferrer"> <picture> <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/danielcranney/readme-generator/main/public/icons/socials/github-dark.svg" /> <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/danielcranney/readme-generator/main/public/icons/socials/github.svg" /> <img src="https://raw.githubusercontent.com/danielcranney/readme-generator/main/public/icons/socials/github.svg" width="32" height="32" /> </picture> </a> <a href="http://www.instagram.com/psicoeconometria" target="_blank" rel="noreferrer"> <picture> <source media="(prefers-color-scheme: dark)" srcset="undefined" /> <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/danielcranney/readme-generator/main/public/icons/socials/instagram.svg" /> <img src="https://raw.githubusercontent.com/danielcranney/readme-generator/main/public/icons/socials/instagram.svg" width="32" height="32" /> </picture> </a> <a href="https://www.linkedin.com/in/phdpablo" target="_blank" rel="noreferrer"> <picture> <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/danielcranney/readme-generator/main/public/icons/socials/linkedin-dark.svg" /> <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/danielcranney/readme-generator/main/public/icons/socials/linkedin.svg" /> <img src="https://raw.githubusercontent.com/danielcranney/readme-generator/main/public/icons/socials/linkedin.svg" width="32" height="32" /> </picture> </a> <a href="https://www.youtube.com/@PsicoEconoMETRIA" target="_blank" rel="noreferrer"> <picture> <source media="(prefers-color-scheme: dark)" srcset="undefined" /> <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/danielcranney/readme-generator/main/public/icons/socials/youtube.svg" /> <img src="https://raw.githubusercontent.com/danielcranney/readme-generator/main/public/icons/socials/youtube.svg" width="32" height="32" /> </picture> </a> <a href="https://www.twitch.tv/phdpablo" target="_blank" rel="noreferrer"> <picture> <source media="(prefers-color-scheme: dark)" srcset="undefined" /> <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/danielcranney/readme-generator/main/public/icons/socials/twitch.svg" /> <img src="https://raw.githubusercontent.com/danielcranney/readme-generator/main/public/icons/socials/twitch.svg" width="32" height="32" /> </picture> </a></p>

### Badges

<b>My GitHub Stats</b>

<a href="http://www.github.com/phdpablo"><img src="https://github-readme-streak-stats.herokuapp.com/?user=phdpablo&stroke=ffffff&background=000000&ring=0891b2&fire=0891b2&currStreakNum=ffffff&currStreakLabel=0891b2&sideNums=ffffff&sideLabels=ffffff&dates=ffffff&hide_border=true" /></a>
