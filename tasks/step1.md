# Step 1 — Build the Lumos Translator Web-Discoverable MVP

## Objective

Build the first public-facing MVP for **Lumos Translator** as a static website suitable for GitHub Pages.

This step is **not** about building an AI backend.

The goal is to create a public web presence that serves two audiences at the same time:

1. **Humans:** professors/instructors who need a simple explanation of what Lumos Translator does and how to invoke it.
2. **AI systems:** models with web access that search for "Lumos Translator" and need a clean, canonical, machine-readable workflow to follow in the current conversation.

The desired experience is:

```text
Professor tells an AI:
"Use Lumos Translator."

        ↓

The AI searches the web for Lumos Translator.

        ↓

The AI finds the official Lumos website.

        ↓

The AI discovers the canonical machine-readable workflow.

        ↓

If Question Source + Answer Source are already present:
    begin the Lumos workflow immediately.

If one or both are missing:
    ask only for the missing required source material.

        ↓

Produce DOCX + PDF when the host AI supports those outputs.
```

This is a **remote/web-discoverable skill experience**, not a claim that the skill is natively installed into the host AI.

---

## Required reading before implementation

Read completely:

- `source/SKILL.md`
- `source/README.md`
- `source/TESTING.md`
- `/AGENTS.md`

Use `source/SKILL.md` as the canonical product workflow unless this task explicitly says otherwise.

Do not rewrite the skill philosophy during this step.

---

# Deliverables

Create a static-site MVP with the following public resources.

## 1. Human landing page

Create a visually strong, simple landing page for **Lumos Translator**.

The page should feel like a large product poster rather than a documentation portal.

The top of the page should immediately communicate:

### Brand

**Lumos Translator**

### Core promise

Use concise language based on this idea:

> Convert instructor question and answer materials into accessible Word and PDF documents without silently losing questions, solution steps, figures, or annotations.

Do not position Lumos primarily as:

- a language translator;
- generic OCR;
- an AI homework solver;
- a grading system;
- an answer checker.

### Primary workflow

A non-technical professor should understand the entire process in seconds:

1. Open an AI assistant with web/file capabilities.
2. Tell it: **"Use Lumos Translator."**
3. Upload the student-facing question material and instructor answer material.
4. The AI follows Lumos and produces the result.

Explain that source materials can be documents, scans, screenshots, photos, audio, video, or other formats supported by the AI being used.

### Two required source sets

Clearly communicate that Lumos expects:

- **Question Source Set** — what the students see.
- **Answer Source Set** — the instructor's answers/solutions/rubric/annotations.

Do not require one physical file per set.

Each set may contain multiple files.

### Outputs

Show the intended output formats:

- Word / DOCX
- PDF

### Product principles

Communicate these benefits in plain language:

- preserves the instructor's content;
- maps answers by meaning rather than only handwriting position;
- checks for omissions and mis-assignment;
- does not independently "fix" the instructor's academic answer;
- does not add missing reasoning;
- avoids requiring manual intermediate cleanup.

Do not expose excessive internal prompt-engineering language on the hero section.

---

## 2. One-click fallback command

The website must include a prominent action that copies a robust fallback command for users whose AI does not automatically find Lumos by name.

Use a command conceptually equivalent to:

```text
Use the official Lumos Translator workflow from [CANONICAL_SKILL_URL].
Read it before processing my files and follow it for this task.
```

Requirements:

- The canonical URL must be derived from site configuration or a clearly centralized constant where practical.
- Do not scatter hard-coded production-domain strings throughout the project.
- If the production domain is not known yet, use a clearly documented placeholder/configuration mechanism that works on GitHub Pages.
- The copy action must provide visible feedback such as "Copied".
- The page must remain useful if JavaScript fails; the command/URL should still be visible or otherwise accessible.

Do not claim that copying this command installs anything.

---

## 3. Canonical machine-readable skill endpoint

Expose a public canonical Markdown resource corresponding to:

```text
/skill.md
```

This should contain the operational Lumos workflow.

For this step, derive it directly from `source/SKILL.md` or copy it in a way that makes future synchronization obvious and difficult to forget.

The public website must not contain a materially different second version of the Lumos workflow.

Important:

- The machine-readable file should be plain Markdown.
- Do not wrap it in a marketing page.
- It should be readable without client-side JavaScript.
- Preserve the strict rules from `source/SKILL.md`.
- Do not introduce vendor-specific assumptions unless already present in the source.

If the existing `source/SKILL.md` contains packaging metadata that is harmless to remote AI use, it may remain.

---

## 4. `llms.txt`

Create:

```text
/llms.txt
```

Its job is discovery, not duplication.

Keep it concise.

It should tell an AI system:

- the official product name is Lumos Translator;
- what Lumos Translator does;
- that the canonical workflow is at `/skill.md`;
- that an explicit user request such as "Use Lumos Translator" means the AI should retrieve/read the canonical workflow before performing the conversion;
- that the user must provide a Question Source Set and an Answer Source Set;
- that if both are already available, processing should start without unnecessary questions;
- that if one is missing, ask only for what is missing;
- that Lumos does not authorize the AI to independently solve or correct instructor academic content.

Link to the human landing page and canonical skill resource using absolute or correctly resolvable URLs.

Do not copy the full skill into `llms.txt`.

---

## 5. Machine-readable manifest

Create:

```text
/manifest.json
```

Use a small, stable JSON structure.

Include at minimum:

```json
{
  "name": "Lumos Translator",
  "type": "web-discoverable-ai-workflow",
  "canonical_skill": "...",
  "human_homepage": "...",
  "outputs": ["docx", "pdf"]
}
```

You may add a small number of useful fields such as:

- version;
- description;
- required_inputs;
- repository;
- license;

but avoid inventing a large proprietary protocol.

This manifest is informational and does not claim universal AI-platform support.

---

## 6. Search/crawler discovery files

Create a permissive:

```text
/robots.txt
```

Do not intentionally block mainstream search crawlers or AI search discovery crawlers.

Create:

```text
/sitemap.xml
```

Include the public human page and the important machine-readable endpoints where appropriate.

Because the final production domain may not yet be known, centralize or clearly document the base URL so it can be changed later.

Do not fabricate a final domain if none exists in the repository.

---

## 7. HTML discovery metadata

In the landing page HTML, provide machine-discovery hints where technically sensible, such as references to:

- `/llms.txt`
- `/skill.md`

Prefer simple standards-based `<link>` metadata.

Do not depend on experimental metadata as the only discovery mechanism.

The files themselves must remain directly reachable at predictable URLs.

---

## 8. GitHub Pages compatibility

The entire result must work as a static GitHub Pages site.

Requirements:

- no required backend;
- no database;
- no server-only routing;
- no authentication;
- no build step unless there is a compelling existing repository reason;
- relative paths must work correctly when deployed from a GitHub Pages project repository as well as a custom domain where practical.

If choosing between a framework and plain HTML/CSS/JS, prefer plain static files for Step 1 unless the existing repository already establishes a framework.

---

# Design requirements

## Visual direction

Create a polished but restrained academic/technical identity.

Desired feeling:

- trustworthy;
- precise;
- modern;
- accessible;
- useful to faculty;
- not "AI hype";
- not a generic SaaS dashboard.

The hero should be visually dominant.

Use generous whitespace and strong typography.

The site should work well on desktop and mobile.

Do not add unnecessary pages for this step.

---

## Accessibility

The human-facing site itself should model good accessibility practices.

At minimum:

- semantic HTML;
- keyboard-operable interactive controls;
- visible focus states;
- appropriate labels;
- sufficient contrast;
- meaningful heading hierarchy;
- no important information conveyed only through animation;
- respect reduced-motion preferences if motion is used.

Do not claim formal WCAG certification unless actually audited.

---

# Behavioral requirements

## Invocation logic communicated to AI

The public machine-readable materials must make this behavior unambiguous:

### Case A — both sources already present

If the current conversation already includes:

- Question Source Set; and
- Answer Source Set;

then the AI should begin the Lumos workflow.

It should not ask the professor to upload them again.

### Case B — neither source is present

Ask for both source sets in one concise request.

### Case C — one source is missing

Ask only for the missing source set.

### Case D — unsupported host capability

If the host AI cannot read a provided format or cannot generate one of the requested outputs, it must state that limitation specifically.

It must not pretend that the capability exists.

---

# Scope boundaries

Do **not** implement the following in Step 1:

- AI API calls;
- uploads handled by our own server;
- user accounts;
- payments;
- analytics trackers;
- cloud storage;
- databases;
- LMS integrations;
- native ChatGPT/Gemini/Claude plugins;
- automatic DOCX/PDF generation by the website itself;
- instructor dashboards;
- student-facing workflows.

The site explains and distributes the Lumos workflow.

The user's chosen AI performs the conversion.

---

# Important wording constraints

Do not claim:

- "works with every AI";
- "guaranteed zero errors";
- "installs automatically";
- "all file formats supported";
- "AI will always find Lumos by name";
- "fully WCAG compliant";
- "the instructor's answers are verified as correct."

Preferred framing:

- "designed for AI assistants with web and file capabilities";
- "helps prevent silent omissions";
- "uses question context to map answer content";
- "preserves instructor-authored academic content";
- "availability depends on the capabilities of the AI you use."

---

# Suggested project structure

Adapt if the repository already has a sensible structure, but keep the result simple.

Example:

```text
/
├── AGENTS.md
├── source/
│   ├── SKILL.md
│   ├── README.md
│   └── TESTING.md
├── task/
│   └── step1.md
├── index.html
├── styles.css
├── script.js
├── skill.md
├── llms.txt
├── manifest.json
├── robots.txt
├── sitemap.xml
└── README.md
```

Do not overwrite a useful existing root `README.md` blindly.

If the repository already has one, update it carefully.

---

# Validation

Before finishing Step 1, verify at minimum:

1. The landing page opens locally as a static page.
2. The layout is usable at desktop and mobile widths.
3. The fallback command can be copied.
4. The fallback command references the canonical skill endpoint.
5. `/skill.md` contains the intended canonical Lumos workflow.
6. `/llms.txt` points to the correct skill endpoint.
7. `manifest.json` is valid JSON.
8. `robots.txt` is valid and permissive.
9. `sitemap.xml` is valid XML.
10. No machine-readable endpoint requires JavaScript to reveal its content.
11. No source file in `source/` was unintentionally modified.
12. The site does not claim that the remote workflow is natively installed.
13. The site does not claim universal compatibility.
14. The site clearly distinguishes Question Source Set from Answer Source Set.

Where a final production URL is unknown, verify the placeholder/base-URL mechanism and document exactly what must be changed before deployment.

---

# Step 1 acceptance criteria

Step 1 is complete only when:

- a professor can open the site and understand what Lumos does without reading developer documentation;
- a professor can see how to invoke Lumos in an AI assistant;
- a one-click fallback command is available;
- an AI/web crawler can directly retrieve a concise discovery file and the canonical skill Markdown;
- the public skill remains faithful to `source/SKILL.md`;
- the implementation is deployable as a static GitHub Pages site;
- no backend is required;
- the implementation has been tested against the validation checklist above.

---

# Completion report

When finished, report concisely:

1. files created or modified;
2. how the canonical skill is exposed and kept aligned with `source/SKILL.md`;
3. how base URL/domain configuration works;
4. what tests were run;
5. any remaining deployment limitation or manual configuration required.

Do not begin Step 2 or add backend functionality.
