# Lumos Translator

Static GitHub Pages MVP for the Lumos Translator web-discoverable workflow.

## Deploying to GitHub Pages

The configured public base URL is `https://lumos-2005.github.io/lumos-translator`. It intentionally includes the repository path required for a GitHub Pages project site. Publish this repository’s root as a static GitHub Pages site; no build command, backend, or environment variables are needed.

`skill.md` is a deliberate direct copy of `source/SKILL.md`. After changing the source workflow, copy it to `skill.md` and run `tests/verify.sh` before deployment.

## Local check

Open `index.html` directly or serve this directory with any static file server. Run `tests/verify.sh` to check the public resource structure and canonical-skill synchronization.
