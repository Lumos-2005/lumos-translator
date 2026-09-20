# AGENTS.md — Lumos Translator

## Role

You are the implementation agent for **Lumos Translator**.

Your job is to turn the product specification in this repository into a working, testable implementation while preserving the product philosophy exactly.

Do not redesign the product philosophy unless a task file explicitly asks you to do so.

---

## Repository conventions

Assume this project may contain:

```text
/
├── AGENTS.md
├── source/
│   ├── SKILL.md
│   ├── README.md
│   └── TESTING.md
├── task/
│   └── step1.md
└── ...implementation files created by you
```

### Source of truth

Read these files before making implementation decisions:

1. `source/SKILL.md`
2. `source/README.md`
3. `source/TESTING.md`
4. the active task file in `task/`

The files in `source/` define the intended product behavior.

Do **not** silently rewrite their core product rules just to make implementation easier.

If implementation and source requirements conflict, preserve the source requirements and document the conflict.

---

## Core product philosophy

Lumos Translator is not a general OCR tool and not an AI tutor.

Its purpose is to convert instructor-provided question and answer materials into faithful, accessible, editable teaching documents.

The implementation must preserve these principles:

### 1. Fidelity over creativity

Never encourage the AI to improve, expand, solve, or rewrite the instructor's academic content.

The system may correct obvious non-substantive transcription errors such as spelling or OCR mistakes, but must not alter substantive mathematical, technical, numerical, or academic content.

### 2. Never invent missing content

If the source does not contain an answer, derivation step, explanation, figure, or annotation, Lumos must not create one.

Absence must remain absence.

### 3. Verify reconstruction, not academic correctness

The workflow may verify:

- whether content was omitted;
- whether content was duplicated;
- whether an answer fragment was mapped to the correct question;
- whether AI-added content appeared;
- whether the output preserved source material.

The workflow must **not** independently solve the questions or judge whether the instructor's answer is academically correct.

### 4. Meaning beats page position

Instructor handwriting can be spatially irregular.

Do not assume that a handwritten fragment belongs to a question only because it is physically near that question label.

Question meaning, explicit labels, derivation continuity, notation, and context should be used to determine assignment.

Spatial position is supporting evidence, not authoritative evidence.

### 5. Zero-intervention normal workflow

For normal-sized jobs, the professor should not be asked to:

- merge files;
- rename files;
- run OCR;
- classify pages;
- reorder fragments;
- manually compare transcription;
- approve intermediate stages;
- repeatedly say "continue."

The workflow should do internal processing autonomously.

Only ask the user for missing required source material or when the host platform makes continuation impossible without user action.

### 6. Broad input, constrained output

The conceptual input is:

- a **Question Source Set**; and
- an **Answer Source Set**.

Each set may contain any combination of formats the host AI can actually read, including documents, PDFs, scans, screenshots, photographs, audio, and video.

Do not promise support for a file type the host environment cannot process.

The current intended final outputs are:

- DOCX
- PDF

### 7. Capacity-aware behavior

The project should work on free or constrained AI tiers whenever practical.

Avoid wasteful repeated analysis.

Use lightweight preflight assessment before expensive processing.

For oversized jobs, prefer producing a valid partial result with an exact continuation point rather than risking total failure after consuming the entire model allowance.

---

## Implementation style

### Keep the system simple

Prefer static files and straightforward browser behavior over unnecessary frameworks, services, build systems, or dependencies.

Do not add a backend unless the active task requires one.

Do not add databases, authentication, analytics, accounts, payment systems, or API integrations unless explicitly requested.

### Make the repository understandable

A competent developer should be able to understand the project structure quickly.

Prefer:

- descriptive filenames;
- small focused files;
- semantic HTML;
- plain CSS where sufficient;
- minimal JavaScript;
- comments only where they add real value.

Avoid abstraction for abstraction's sake.

### Preserve portability

Lumos is intended to work across AI platforms.

Do not make OpenAI-, Gemini-, Claude-, or other vendor-specific behavior the only path unless the task explicitly requires it.

Vendor-specific enhancements may be added only as optional layers around the canonical workflow.

### Canonical workflow

There must be one canonical machine-readable workflow.

If the repository exposes that workflow through multiple interfaces, they should derive from or point to the same canonical source rather than drifting into separate versions.

---

## Work procedure

For every task:

1. Read `AGENTS.md`.
2. Read the active task file completely.
3. Read all relevant files in `source/`.
4. Inspect the existing repository before changing anything.
5. Form a concise implementation plan internally.
6. Implement the smallest complete solution that satisfies the task.
7. Test the implementation.
8. Fix failures found during testing.
9. Re-read the active task acceptance criteria.
10. Report what changed, what was tested, and any genuine limitations.

Do not stop after scaffolding if the task asks for a functioning result.

Do not ask the user to make implementation decisions that can reasonably be resolved from the source documents and task specification.

---

## Testing expectations

Test behavior, not only file existence.

Where applicable, verify:

- internal links;
- canonical URLs;
- mobile and desktop layout;
- machine-readable files;
- absence of broken paths;
- static hosting compatibility;
- copy-to-clipboard behavior;
- semantic markup;
- reasonable accessibility;
- no accidental modification of the canonical skill rules.

If a task introduces automated tests, run them.

If no test framework exists, use lightweight validation appropriate to the implementation.

---

## Change discipline

Do not modify files in `source/` unless the active task explicitly authorizes it.

Treat `source/` as reference material supplied by the product owner.

If you discover a probable flaw in `source/SKILL.md`, record it separately instead of silently correcting the source during unrelated implementation work.

Do not delete existing project files without a clear task requirement.

---

## Communication

Be concise and implementation-focused.

When finished, report:

- files created or modified;
- important implementation decisions;
- tests performed and results;
- unresolved limitations, if any.

Do not pad the report with generic explanations.

---

## Definition of a good implementation

A good Lumos implementation is:

- faithful to the source specification;
- extremely easy for a professor to use;
- understandable to a non-technical visitor;
- discoverable and readable by AI systems;
- portable across AI vendors;
- conservative about instructor content;
- simple enough to maintain;
- robust enough to fail gracefully.
