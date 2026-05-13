# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Purpose

This repo is a working copy of **Lighthouse Independent Baptist Church** — a live WordPress site at `https://lbcpayette.net`. The goal is to analyze the current site and develop updates/improvements to it.

## Re-mirroring the Site

To pull a fresh static copy of the live site:

```
# Remove the old mirror first (website-scraper won't overwrite)
rm -rf site-mirror

node scrape.mjs
```

Requires Node.js ≥ 17 with `npm install` already run. The script saves all pages, CSS, JS, fonts, and images under `site-mirror/`.

## Site-Mirror Structure

`site-mirror/` is a static snapshot of the rendered WordPress output — not the source PHP. It reflects what a browser receives, not what lives on the server. Use it for:
- Reading current page content and markup
- Analyzing layout, styles, and existing copy
- Finding what needs to change before touching the live site

Pages: `index.html`, `about-us.html`, `church-history.html`, `contact.html`, `missions.html`, `our-ministries.html`, `our-pastor.html`, `services.html`, `statement-of-faith.html`

## Live Site Tech Stack

- **CMS**: WordPress 6.8.5
- **Theme**: Astra (`main.min.css`, `style.min.css`)
- **Page builder**: Elementor (all page layouts are Elementor-built)
- **Forms**: WPForms
- **Typography**: DM Sans (body/headings) + Forum (display/h4) via Google Fonts
- **Icons**: Font Awesome 6 + Elementor Icons

## Design Tokens (CSS Variables)

Defined as both Astra `--ast-global-color-*` and Elementor `--e-global-color-*` variables:

| Variable | Value | Role |
|---|---|---|
| `color-0` | `#ffd936` | Primary (yellow/gold) |
| `color-1` | `#dab200` | Primary hover |
| `color-2` | `#536942` | Dark green (headings, text) |
| `color-3` | `rgba(82,104,64,0.75)` | Body text |
| `color-4` | `#f6f8f5` | Light background |
| `color-5` | `#ffffff` | White background |
