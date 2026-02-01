Codex context (project snapshot)

Project
- Hugo site in .
- Theme: PaperMod submodule in themes/PaperMod (commit 1cf5327)
- Config: hugo.yaml (baseURL "/", languageCode en-us, title "Roman Bogdanov", menu entries incl. 🇷🇺 ru and 🇰🇿 kz)
- Custom CSS: static/css/brj.css (linked via layouts/partials/extend_head.html)
- Layout overrides: layouts/_default/list.html, layouts/404.html

Content (front matter)
- content/_index.md: title "go", description "start here"
- content/about.md: title "Hi, 👋", description "About me"
- content/ru.md: title "ru", description "site description"
- content/kz.md: title "🇰🇿 kz", description "Kazakhstan"
- content/net.md: title "network", description "network tools"
- content/hl.md: title "Home lab", description "Home Lab links"
- content/cl.md: title "CloudLinux", description "daily driver"
- content/orn.md: title "orion nlab", description "orion lab links"

Repo state
- Working tree has uncommitted changes: content/_index.md, content/hl.md, hugo.yaml, CODEX_CONTEXT.md.
- Untracked: content/ru.md, content/kz.md.
- public/ and .hugo_build.lock are present but ignored by .gitignore; resources/_gen/ is ignored (not present).

User preferences
- Do not change overall styles unless explicitly asked.
- LanguageCode should remain unchanged (user said "язык править не нужно").

Useful commands
- Build: hugo --gc --minify --cleanDestinationDir
- Re-init theme: git submodule update --init --recursive
