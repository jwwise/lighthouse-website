# Lighthouse Baptist Church — Website Rebuild

Redesign and Elementor-removal project for **https://lbcpayette.net** (WordPress 6.8.5).

**Goals:**
- Remove Elementor dependency; migrate all 9 pages to native WordPress block editor (Gutenberg)
- Refresh design: warm & welcoming palette (navy/cream/gold), Lora headings, DM Sans body

**Status: Complete.** All phases shipped. The live site runs on `lighthouse-theme` with no Elementor dependency.

**Working directly on the live site.** Admin access only (no FTP/SSH). Theme uploaded as a .zip.

---

## Checklist

### Phase 1 — Backup ✅
- [x] Install UpdraftPlus plugin on live site
- [x] Take full site + database backup
- [x] Download backup archive locally

### Phase 2 — Design System ✅
- [x] Define final color palette in `lighthouse-theme/theme.json`
- [x] Define typography (Lora headings, DM Sans body)
- [x] Define spacing scale and container width

### Phase 3 — Build Custom Block Theme ✅
- [x] Scaffold `lighthouse-theme/` directory structure
- [x] Write `style.css` (theme header + all component CSS)
- [x] Write `theme.json` (design tokens)
- [x] Write `functions.php` (enqueue Google Fonts)
- [x] Build `templates/front-page.html` (home page — no banner)
- [x] Build `templates/index.html` (default template)
- [x] Build `templates/page.html` (interior page template — navy banner)
- [x] Build `parts/header.html` (logo + nav, sticky)
- [x] Build `parts/footer.html` (address, service times, nav)
- [x] Build `patterns/hero.php` (homepage hero pattern)
- [x] Build `patterns/page-banner.php` (interior page title banner)
- [x] Build `patterns/service-times.php` (homepage service times strip)

### Phase 4 — Deploy Theme ✅
- [x] Zip `lighthouse-theme/` directory
- [x] Upload to WP Admin → Appearance → Themes → Add New → Upload
- [x] Activate theme; verify header and footer render correctly

#### Building the theme zip

PowerShell's `Compress-Archive` and .NET's `ZipFile.CreateFromDirectory` both write backslash path separators on Windows. PHP's `ZipArchive` on Linux (where WordPress runs) treats backslash paths as flat filenames — it won't resolve `lighthouse-theme\style.css` as a file inside a folder, causing "style.css missing" or "Template is missing" errors on upload.

**Always build the zip using `build-theme.ps1`** from the repo root:

```powershell
.\build-theme.ps1
```

This uses the `ZipArchive` API to force forward-slash entry names. Then upload `lighthouse-theme.zip` via **WP Admin → Appearance → Themes → Add New Theme → Upload Theme**.

### Phase 5 — Page-by-Page Content Migration ✅
All pages built using `preview/` HTML files as the design reference. Block markup stored in `page-content/`.

- [x] Statement of Faith
- [x] Church History
- [x] Our Pastor
- [x] About Us
- [x] Missions
- [x] Our Ministries
- [x] Services / Church Media
- [x] Contact (WPForms shortcode — replace `REPLACE_WITH_WPFORMS_ID` with actual form ID)
- [x] Home

### Phase 6 — Remove Elementor ✅
- [x] Confirmed all 9 pages render correctly in new theme
- [x] Deactivated and deleted Elementor plugin(s)

### Phase 7 — QA & Launch ✅
- [x] All 9 pages render correctly
- [x] No `elementor-*` classes in page source
- [x] Contact form submits successfully (WPForms + Brevo SMTP)
- [x] Google Maps loads on Contact page
- [x] YouTube embeds load on Services/Media page
- [x] Mobile responsiveness verified (375px, 768px, 1024px)
- [x] Internal links audited — fixed `/church-media` → `/services`
- [x] Email deliverability resolved — switched from NameHero/MailChannels to Brevo SMTP

---

## Tech Stack

| Layer | Value |
|---|---|
| CMS | WordPress 6.8.5 |
| Theme | `lighthouse-theme` (custom block theme) |
| Page builder | Native block editor (Gutenberg) |
| Forms | WPForms |
| Email relay | Brevo SMTP (via WP Mail SMTP plugin) |
| Body font | DM Sans |
| Heading font | Lora (serif) |

## Design Tokens

| Token | Value |
|---|---|
| Navy (primary) | `#1a3255` |
| Navy Dark (accents) | `#122440` |
| Gold (accent) | `#c8921a` |
| Cream (background) | `#fdf9f3` |
| White (surfaces) | `#ffffff` |
| Dark (text) | `#1c1c1c` |
| Muted (secondary text) | `#5c5c5c` |

## Repo Structure

```
lighthouse-theme/    Custom WordPress block theme
  style.css          Theme header + all component CSS
  theme.json         Design tokens (colors, typography, spacing)
  functions.php      Enqueues Google Fonts (Lora + DM Sans)
  screenshot.png     Theme thumbnail (shown in WP Admin)
  templates/         front-page.html, page.html, index.html
  parts/             header.html, footer.html
  patterns/          hero.php, page-banner.php, service-times.php
page-content/        Block markup for all 9 pages (paste into WP Code Editor)
preview/             Static HTML design reference (approved before build)
build-theme.ps1      Builds lighthouse-theme.zip with correct forward-slash paths
site-mirror/         Static HTML snapshot of original live site (gitignored)
scrape.mjs           Re-mirror script: rm -rf site-mirror && node scrape.mjs
CLAUDE.md            Guidance for Claude Code
```
