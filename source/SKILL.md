---
name: accessible-answer-key
description: Convert instructor-provided question materials and answer materials into a faithful, accessible answer key in DOCX and PDF. Use for handwritten, scanned, photographed, screenshot, document, audio, or video solution sources when omissions, misplaced answer fragments, invented steps, or AI rewriting must be avoided. The workflow maps answer content to the actual student-facing questions by meaning rather than page position, preserves the instructor's content, and verifies reconstruction without checking whether the instructor's answers are academically correct.
---

# Accessible Answer Key

## Mission

Convert two source sets into a faithful, accessible answer key:

1. **Question Source Set** — the material students actually see.
2. **Answer Source Set** — the instructor's answers, solutions, annotations, worked steps, diagrams, spoken explanation, or other answer material.

Produce, when the host AI can create files:

- an editable **DOCX** master; and
- an accessible **PDF** distribution copy.

The primary objective is faithful reconstruction, not rewriting.

## Non-negotiable principles

Follow these principles throughout the task:

1. **Match by meaning, not merely by position.** Spatial layout is supporting evidence only. A handwritten fragment must not be assigned to a question or subpart solely because it appears near that question number or in that region of a page.
2. **Verify reconstruction, never the instructor's academic correctness.** Use logic only to determine what source content belongs where and whether anything was omitted, duplicated, misplaced, or invented. Do not independently solve, grade, fact-check, recompute, or improve the instructor's answer.
3. **Never add substantive content.** Do not add missing reasoning, explanations, examples, equations, conclusions, definitions, transitions, or answers that are not present in the Answer Source Set.
4. **Preserve the instructor's method and order.** Do not replace the instructor's derivation with a cleaner one, merge steps for elegance, or substitute a different method.
5. **Completeness is more important than cosmetic polish.** If content is difficult to read or place, preserve and flag it rather than silently dropping it.
6. **Minimize user intervention.** Once both required source sets are available, perform the workflow autonomously. Do not make the user manually classify pages, renumber fragments, compare transcriptions, convert files, or approve intermediate stages unless a host-platform limitation makes progress impossible.

## Required inputs

Both logical source sets are required.

### Question Source Set

This is the ground-truth structure for the assignment, quiz, exam, worksheet, homework, lecture exercise, or similar material.

It may contain one or many host-readable files, including documents, scans, screenshots, photographs, images, audio, or video.

### Answer Source Set

This is the ground-truth content for the instructor's answer.

It may contain one or many host-readable files and may mix modalities. Examples include handwritten pages, whiteboard photographs, screenshots, annotated PDFs, typed notes, audio explanations, or video recordings.

### Input classification

- If the two sets are clearly distinguishable from filenames, content, ordering, or user wording, classify them automatically.
- If sources are mixed, classify each source internally before beginning transcription.
- Ask a clarification **only before processing begins** when one required source set is genuinely absent or when the two sets cannot be distinguished reliably.
- Do not interrupt the workflow later for routine uncertainty. Use the ambiguity rules below instead.
- Do not require a user to convert a file merely for convenience. Request a different representation only when the host AI truly cannot access that source.

## Host capability rule

Accept any source modality the host AI can actually read. Do not claim support for a file or modality the host cannot inspect.

Typical intended source types include:

- PDF, DOCX, PPTX, TXT and similar documents;
- PNG, JPG/JPEG, HEIC/HEIF and similar images;
- screenshots and scanned pages;
- MP3, M4A, WAV and similar audio;
- MP4, MOV and similar video.

If the host cannot read one source, identify that specific limitation. Do not pretend to have inspected inaccessible content.

## Workload preflight

Before detailed transcription, perform a lightweight capacity assessment. This is not a content-verification pass.

Estimate workload from factors such as:

- number of pages, images, files, and questions;
- audio/video duration;
- handwriting density and legibility;
- equation and diagram density;
- number of subparts;
- mixed-modality complexity.

Do not claim an exact token count or exact remaining quota unless the host explicitly provides it.

Classify the workload internally as approximately **normal**, **high**, or **extreme**.

- **Normal:** complete the full workflow without asking the user to continue between stages.
- **High:** process in internal chunks but still aim to return one complete final DOCX and PDF. Do not expose chunking unless necessary.
- **Extreme / likely to exceed the current session:** process the largest safe contiguous portion, create usable partial DOCX/PDF output before capacity is exhausted, and report the exact completed range and continuation point. Never silently stop after consuming the available capacity.

Do not spend excessive capacity on repeated checking. This workflow uses only the targeted validation gates defined below.

# Workflow

## Stage 1 — Build the Question Map

Read the entire Question Source Set sufficiently to reconstruct its structure before assigning answer content.

Create an internal Question Map containing, for every visible question and subpart:

- question identifier;
- subpart identifier, if any;
- original question wording or a faithful extraction of it;
- source location;
- a short **semantic signature** derived only from the question itself.

A semantic signature describes what the question is asking for without solving it. Examples:

- "calculate propagation delay using the provided circuit parameters";
- "identify the addressing mode";
- "draw the requested timing diagram";
- "explain two causes".

The semantic signature is routing metadata only. Never derive the missing answer from it.

Preserve the original question structure. Do not invent missing question numbers or subparts.

## Stage 2 — Read the Answer Source as Content Fragments

Inspect the Answer Source Set completely enough to avoid losing isolated material.

Segment it into logical **content fragments**, not arbitrary rectangular page regions. A fragment may be:

- a line or short block of prose;
- a continuous equation or derivation sequence;
- a diagram and its labels;
- an annotation or arrow-linked note;
- a clearly connected group of calculations;
- a spoken explanation segment;
- a visible board-writing sequence in video;
- an explicit question/subpart label.

Preserve source order and source location metadata internally.

Do not assume that a fragment belongs to the nearest printed or handwritten question label.

### Deletions and crossed-out material

- Exclude content only when the instructor has clearly deleted or struck it out.
- If a mark may be either a deletion or an annotation and the intent is unclear, preserve it as ambiguous rather than silently removing it.

## Stage 3 — Map Answer Fragments to the Question Map

Assign each answer fragment to the most defensible question/subpart using the following evidence.

Use these signals in combination; do not mechanically rely on only one signal:

1. explicit instructor numbering or labels **when they are semantically compatible with the question**;
2. semantic correspondence between the fragment and what the question asks;
3. continuity with surrounding derivation, variables, references, diagrams, or explanation;
4. source sequence or temporal continuity;
5. spatial proximity or page region.

Spatial proximity is the weakest normal signal. It may support a mapping, but it must not override a clear semantic mismatch.

### Required mapping behavior

- If a fragment visually appears under part (a) but its content clearly answers part (b), do not assign it to (a) merely because of layout.
- If an explicit label conflicts with the apparent semantic fit, do not silently "correct" the instructor. Reassess the surrounding fragments. If the conflict remains genuinely unresolved, flag the placement as uncertain.
- A single visual region may contain fragments belonging to multiple subparts. Split only at genuine semantic or derivational boundaries.
- Preserve the instructor's internal order within each derivation or explanation.
- Never create an answer for a question solely because the Question Map indicates that an answer should exist.

## Stage 4 — Resolve Only Necessary Ambiguities

Use additional reasoning only when necessary to decide source reconstruction questions such as:

- which question a fragment belongs to;
- whether two fragments are one continuous derivation;
- whether an annotation refers to a nearby equation or diagram;
- whether content continues across pages or media segments.

Do **not** use additional reasoning to determine whether the answer is correct.

Do not search the web, consult external subject knowledge, or independently solve the problem for validation.

If placement remains uncertain after using the available source evidence:

- keep the fragment;
- do not force a confident assignment;
- place it in the most conservative location only if there is a clearly best candidate;
- otherwise preserve it in a final **Conversion Notes / Unassigned Source Content** section;
- identify its source location so the instructor can inspect it quickly.

Never discard an unresolved fragment.

## Stage 5 — Faithful Transcription

After mapping is stable, transcribe the source content.

Preserve:

- numerical values;
- equations and symbols;
- significant notation choices;
- derivation steps;
- diagrams and labels;
- answer ordering;
- instructor wording when academically meaningful;
- conclusions actually present in the source.

### Allowed corrections

Only make corrections that are clearly non-substantive and highly certain, such as:

- an obvious OCR character error verified against the source;
- an obvious spelling typo;
- trivial punctuation needed for readable digital text;
- digital formatting of subscripts, superscripts, symbols, or equations that preserves the same content.

### Forbidden corrections or improvements

Do not:

- change a number because a calculation appears wrong;
- change an equation because another equation would be more correct;
- fix a factual or conceptual mistake;
- add an omitted algebraic step;
- add explanatory prose;
- add a definition, assumption, example, or justification;
- summarize a longer derivation into a shorter one;
- expand a short answer into a teaching explanation;
- replace the instructor's method with a standard method;
- answer a question that the instructor did not answer.

When uncertain whether a change is merely typographical or substantively interpretive, preserve the source.

## Stage 6 — Completeness Audit

Perform one targeted completeness audit before accessibility formatting.

Compare the Question Map, all non-deleted Answer Fragments, and the assembled transcription.

Check only for reconstruction failures:

- every question/subpart from the Question Source is represented in the final structure;
- every answer fragment is accounted for, including annotations, equations, diagrams, and continuations;
- no answer fragment has been duplicated;
- no fragment has been silently dropped;
- no fragment is assigned to a question solely because of spatial proximity when the semantics conflict;
- source content that has no reliable assignment remains preserved and flagged.

If a question has no corresponding answer content, do not invent one. Keep the question in the structure and indicate, neutrally, that no answer content was found in the provided Answer Source Set.

This audit must not evaluate academic correctness.

## Stage 7 — Accessibility Transformation

Now transform the verified content into accessible digital form without changing its substance.

### DOCX requirements

When the host can create DOCX:

- use real heading styles for title, questions, and subparts;
- use real numbered/bulleted lists when the source is a list;
- use real tables when the source is a table;
- keep text selectable and editable;
- use native or structurally accessible equation representation when the host supports it;
- preserve logical reading order;
- include meaningful alt text for retained figures, diagrams, or source images;
- do not use whitespace alone to simulate structure.

### PDF requirements

When the host can create PDF:

- preserve selectable text;
- preserve the same logical order and content as the DOCX;
- use tagged/structured PDF features when the host supports them;
- preserve accessible descriptions for figures where supported;
- do not claim formal accessibility certification unless it has actually been tested by an appropriate validator.

### Figures and diagrams

Do not invent information while making a figure accessible.

An alt description should describe the visible, academically relevant information in the instructor's figure. It must not add an interpretation or conclusion that is not present in the source.

## Stage 8 — Final No-Addition Audit

Perform one final targeted audit. Ask only:

1. **Was any source content omitted?**
2. **Was any content placed under the wrong question/subpart?**
3. **Did the AI add substantive content that was not in the source?**

Correct only these reconstruction problems.

Do not perform a second academic correctness review.

# Output rules

## Normal completion

Return both, when supported by the host:

- `<source-name>_accessible_answer_key.docx`
- `<source-name>_accessible_answer_key.pdf`

The two files must contain materially identical answer-key content.

Keep the user-facing completion message concise. Mention only:

- the files created;
- any genuinely unresolved source/placement issue requiring human review;
- any host capability limitation that prevented a required output.

Do not burden the user with the internal workflow when the conversion succeeds normally.

## Partial completion caused by capacity

If the workload is too large to finish safely in the current run:

1. complete the largest safe contiguous range;
2. create partial DOCX and PDF files for that completed range before ending;
3. state the exact completed questions/pages/time range;
4. state the exact next continuation point;
5. identify any source file that still needs processing.

Do not pretend the partial output is complete.

## Unresolved source content

If content cannot be reliably mapped, preserve it in a clearly separated conversion-notes section rather than dropping it or inventing a placement. Include only the minimum information necessary to locate the source fragment.

# Prohibited behaviors

The following are hard failures:

- solving or re-solving the assignment to check the instructor;
- grading the instructor's correctness;
- changing mathematical or factual content because the model thinks it is wrong;
- adding missing solution steps;
- fabricating answers for unanswered questions;
- assigning content based only on physical page location;
- silently omitting unreadable or ambiguous content;
- silently omitting diagrams, side annotations, or continuation material;
- rewriting the solution into the model's preferred style;
- asking the user to perform routine intermediate processing that the AI can do itself;
- claiming to have read inaccessible files;
- claiming formal accessibility compliance without actual validation.

# Priority order when rules compete

Use this priority order:

1. **No invented substantive content**
2. **No silent omission**
3. **Correct question-to-answer mapping**
4. **Faithful preservation of instructor content and method**
5. **Accessibility and editability**
6. **Cosmetic polish**

When uncertainty remains, preserve and flag rather than guess.
