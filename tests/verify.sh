#!/bin/sh
set -eu

site_url='https://lumos-2005.github.io/lumos-translator'

cmp -s source/SKILL.md skill.md
test "$(sed -n '1p' robots.txt)" = "User-agent: *"
grep -q '^Allow: /$' robots.txt
grep -q 'href="skill.md"' index.html
grep -q 'href="llms.txt"' index.html
grep -q 'data-copy-command' index.html
grep -q "${site_url}/skill.md" index.html
grep -q "${site_url}/skill.md" llms.txt
grep -q "${site_url}/skill.md" sitemap.xml
grep -q "${site_url}" site-config.js
grep -q 'skill.md' script.js
grep -q "${site_url}/skill.md" manifest.json
grep -q "${site_url}/" manifest.json
if rg -q 'YOUR-GITHUB-USERNAME|YOUR-REPOSITORY' --glob '!source/**' --glob '!tests/verify.sh' .; then exit 1; fi
grep -q 'Question Source Set' index.html
grep -q 'Answer Source Set' index.html
node -e 'const fs=require("fs"); const m=JSON.parse(fs.readFileSync("manifest.json", "utf8")); const u="https://lumos-2005.github.io/lumos-translator"; if(m.canonical_skill!==u+"/skill.md"||m.human_homepage!==u+"/") process.exit(1)'
if command -v xmllint >/dev/null 2>&1; then xmllint --noout sitemap.xml; fi
printf '%s\n' 'Static MVP verification passed.'
