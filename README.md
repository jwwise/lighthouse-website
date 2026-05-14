# Lighthouse Baptist Church — Website Rebuild

Redesign and Elementor-removal project for **https://lbcpayette.net** (WordPress 6.8.5).

**Goals:**
- Remove Elementor dependency; migrate all 9 pages to native WordPress block editor (Gutenberg)
- Refresh design: warm & welcoming palette (navy/cream/gold), Lora headings, DM Sans body

**Working directly on the live site.** Admin access only (no FTP/SSH). Theme uploaded as a .zip.

---

## Checklist

### Phase 1 — Backup
- [x] Install UpdraftPlus plugin on live site
- [x] Take full site + database backup
- [x] Download backup archive locally

### Phase 2 — Design System
- [ ] Define final color palette in `lighthouse-theme/theme.json`
- [ ] Define typography (Lora headings, DM Sans body)
- [ ] Define spacing scale and container width

### Phase 3 — Build Custom Block Theme
- [ ] Scaffold `lighthouse-theme/` directory structure
- [ ] Write `style.css` (theme header)
- [ ] Write `theme.json` (design tokens)
- [ ] Write `functions.php` (enqueue Google Fonts)
- [ ] Build `templates/index.html` (default template)
- [ ] Build `templates/page.html` (interior page template)
- [ ] Build `parts/header.html` (logo + nav, sticky)
- [ ] Build `parts/footer.html` (address, service times, nav)
- [ ] Build `patterns/hero.html` (homepage hero pattern)
- [ ] Build `patterns/page-banner.html` (interior page title banner)
- [ ] Build `patterns/service-times.html` (homepage info block)

### Phase 4 — Deploy Theme
- [x] Zip `lighthouse-theme/` directory
- [x] Upload to WP Admin → Appearance → Themes → Add New → Upload
- [x] Activate theme; verify header and footer render correctly

#### Building the theme zip

PowerShell's `Compress-Archive` and .NET's `ZipFile.CreateFromDirectory` both write backslash path separators on Windows. PHP's `ZipArchive` on Linux (where WordPress runs) treats backslash paths as flat filenames — it won't resolve `lighthouse-theme\style.css` as a file inside a folder, causing "style.css missing" or "Template is missing" errors on upload.

**Always build the zip with this script** (uses the `ZipArchive` API to force forward-slash entry names):

```powershell
Add-Type -Assembly System.IO.Compression.FileSystem
Add-Type -Assembly System.IO.Compression

$dest = "lighthouse-theme.zip"
if (Test-Path $dest) { Remove-Item $dest -Force }
$themeRoot = "$PSScriptRoot\lighthouse-theme"
$stream = [System.IO.File]::Open($dest, [System.IO.FileMode]::Create)
$archive = New-Object System.IO.Compression.ZipArchive($stream, [System.IO.Compression.ZipArchiveMode]::Create)

Get-ChildItem $themeRoot -Recurse -File | ForEach-Object {
    $rel = $_.FullName.Substring($themeRoot.Length + 1).Replace('\', '/')
    $entry = $archive.CreateEntry("lighthouse-theme/$rel", [System.IO.Compression.CompressionLevel]::Optimal)
    $es = $entry.Open(); $fs = [System.IO.File]::OpenRead($_.FullName)
    $fs.CopyTo($es); $fs.Close(); $es.Close()
}
$archive.Dispose(); $stream.Close()
```

Then upload `lighthouse-theme.zip` via **WP Admin → Appearance → Themes → Add New Theme → Upload Theme**.

### Phase 5 — Page-by-Page Content Migration
Rebuild each page in the block editor. Elementor stays active until all pages are done.
Use `site-mirror/` for content reference.

- [ ] Statement of Faith — Heading, Paragraph, List blocks
- [ ] Church History — Heading, Paragraph, Image blocks
- [ ] Our Pastor — Columns, Image, Paragraph blocks
- [ ] About Us — Heading, Paragraph, Columns blocks
- [ ] Missions — Heading, Paragraph, Image blocks
- [ ] Our Ministries — Heading, Paragraph, Image blocks
- [ ] Services / Church Media — Heading, YouTube embed, Group blocks
- [ ] Contact — Heading, HTML (Google Maps), WPForms shortcode
- [ ] Home — Cover (hero with church photo), Group, Columns blocks

### Phase 6 — Remove Elementor
- [ ] Confirm all 9 pages look correct in the new theme
- [ ] WP Admin → Plugins → Deactivate Elementor
- [ ] Delete Elementor plugin(s)

### Phase 7 — QA & Launch
- [ ] All 9 pages render correctly
- [ ] No `elementor-*` classes in page source
- [ ] Contact form submits successfully (WPForms)
- [ ] Google Maps loads on Contact page
- [ ] YouTube embeds load on Services/Media page
- [ ] Mobile responsiveness verified (all breakpoints)
- [ ] No broken internal links

---

## Tech Stack

| Layer | Current | After |
|---|---|---|
| CMS | WordPress 6.8.5 | WordPress 6.8.5 |
| Theme | Astra | `lighthouse-theme` (custom) |
| Page builder | Elementor | Native block editor |
| Forms | WPForms | WPForms (unchanged) |
| Body font | DM Sans | DM Sans |
| Heading font | DM Sans | Lora (serif) |

## Design Tokens

| Token | Value |
|---|---|
| Navy (primary) | `#1a3255` |
| Gold (accent) | `#c8921a` |
| Cream (background) | `#fdf9f3` |
| White (surfaces) | `#ffffff` |
| Dark (text) | `#1c1c1c` |
| Muted (secondary text) | `#5c5c5c` |

## Repo Structure

```
lighthouse-theme/    Custom WordPress block theme (Phase 3+)
site-mirror/         Static HTML snapshot of live site (content reference)
scrape.mjs           Re-mirror script: rm -rf site-mirror && node scrape.mjs
CLAUDE.md            Guidance for Claude Code
```
