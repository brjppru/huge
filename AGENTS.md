# AGENTS.md

## Project Overview
Hugo site in the repository root. Theme is PaperMod as a git submodule in `themes/PaperMod` (pinned to release tag `v8.0`).

## Key Configuration
- Main config: `hugo.yaml`.
- `baseURL: "https://brjed.netlify.app/"` — must remain unchanged unless explicitly requested.
- `languageCode` must remain unchanged (`en-us`) unless explicitly requested.
- Menu is defined in `hugo.yaml`.
- `enableRobotsTXT: true` and custom `sitemap` config are set in `hugo.yaml`.
- `ignoreLogs` suppresses the PaperMod partial prefix warning.
- `params.description`, `params.author`, `params.schema.publisherType/sameAs`, `params.images` are set for SEO.

## Content
- Markdown content in `content/`.
- Home page: `content/_index.md` (link hub).
- Other pages are link lists (`content/about.md`, `content/net.md`, `content/hl.md`, `content/cl.md`, `content/kz.md`, `content/orn.md`, `content/ru.md`).
- New content defaults to `draft: true` via `archetypes/default.md`; set `draft: false` when publishing.

## Layout Overrides
- `layouts/_default/list.html`
- `layouts/partials/extend_head.html` includes `/css/brj.css`
- `layouts/404.html`
- `layouts/partials/partials/templates/_funcs/get-page-images.html` is a shim to satisfy PaperMod v8.0 partial path on Netlify/Hugo.
- `layouts/partials/templates/opengraph.html` overrides PaperMod to avoid deprecated `site.Social`.
- `layouts/partials/templates/twitter_cards.html` overrides PaperMod to avoid deprecated `site.Social`.
- `layouts/partials/templates/schema_json.html` overrides PaperMod's broken JSON-LD; generates valid Schema.org via `jsonify` on a Hugo dict. Home: `WebSite` + `Person`. Other pages: `WebPage`.

## Static Assets
- Active CSS: `static/css/brj.css`
- Favicon: `static/favicon.ico`
- OG image: `static/img/og.jpg` (1200×630)

## Development / Build
- Local dev: `hugo server --ignoreCache --disableFastRender --bind 0.0.0.0 --port 8080 --baseURL "http://localhost:8080/"`
  - `bin/run.sh` runs the above but starts with `cd ..`.
- Build (Netlify): `hugo --gc --minify --cleanDestinationDir`
  - Netlify uses `HUGO_VERSION = 0.159.1` from `netlify.toml`.
- Schema/OG/Twitter tags render only in production mode (`hugo.IsProduction`).

## Conventions / Constraints
- Do not change overall visual styles unless explicitly asked.
- Do not change `languageCode` or `baseURL` unless explicitly asked.
- Theme updates must prefer stable releases (tags) over `master` unless explicitly requested.
- Generated/ignored: `public/`, `.hugo_build.lock`, `resources/_gen/`.
- Content includes internal/private links and IPs (e.g., `content/cl.md`, `content/hl.md`, `content/orn.md`); treat as sensitive.
- Always update `AGENTS.md` to reflect the current project context after the user confirms "everything is OK" or "all good."
- Answer in one sentence where possible.
