Codex context (project snapshot)

Project
- Hugo site in /Users/brjed/devel/huge
- Theme: PaperMod as git submodule (themes/PaperMod)
- Config: hugo.yaml (baseURL "/", languageCode en-us, menu entries)
- Custom CSS: static/css/brj.css (linked via layouts/partials/extend_head.html)

User preferences
- Do not change overall styles unless explicitly asked.
- LanguageCode should remain unchanged (user said "язык править не нужно").

What was done in this session
- Initialized theme submodule: git submodule update --init --recursive
- Built site: hugo --gc --minify --cleanDestinationDir (requires cache write access)
- A11y scan (simple HTML parse):
  - After fixes, only public/page/1/index.html lacks h1 (redirect page).
- Fixed missing/empty h1 by adding titles and overriding templates:
  - Added title to content/_index.md (Home)
  - Added title to content/net.md (Net)
  - Added title to content/hl.md (Homelab)
  - Added title to content/cl.md (CloudLinux)
  - Added title to content/orn.md (Orion)
  - Removed description: "welcome" from content/_index.md (to remove header description)
  - Added layouts/_default/list.html override to show h1 on home list pages
  - Added layouts/404.html override with <h1 class="not-found">404</h1>
- Added menu hover style matching content link hover:
  - static/css/brj.css: new #menu a hover/focus rules (background + brackets)

Current state notes
- public/ is in .gitignore, so build output is ignored.
- resources/_gen/ and .hugo_build.lock are ignored too.
- Node/npx are not installed; full Lighthouse/axe a11y audit not run.

Files changed by Codex in this session
- content/_index.md
- content/net.md
- content/hl.md
- content/cl.md
- content/orn.md
- layouts/_default/list.html (new)
- layouts/404.html (new)
- static/css/brj.css

Existing repo changes not made by Codex (seen in git status)
- content/about.md (modified)
- content/inda.md (deleted)
- hugo.yaml (modified)

Useful commands
- Build: hugo --gc --minify --cleanDestinationDir
- Re-init theme: git submodule update --init --recursive
