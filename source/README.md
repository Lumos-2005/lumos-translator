# Accessible Answer Key Skill

**Status:** v0.1 — experimental / test before classroom use

A reusable AI workflow for turning instructor question materials plus instructor answer materials into a faithful, accessible answer key in Word and PDF.

The central design goal is not generic OCR. It is **reconstruction with strict anti-omission and anti-invention rules**.

## Problem

Instructor answer material is often messy in ways that defeat one-shot AI conversion:

- handwriting is placed irregularly;
- answer parts have no clear dividing lines;
- one subpart may continue in another region or page;
- equations and annotations are easy to skip;
- models may confidently rewrite, simplify, or add steps;
- visually nearby content may actually answer a different question.

This skill uses the student-facing question material as the structural anchor. It maps answer fragments to questions primarily by **semantic fit**, with spatial location used only as supporting evidence.

## Required input

Two logical source sets are required:

1. **Question Source Set** — what students see.
2. **Answer Source Set** — the instructor's answers/solutions.

Either set may contain multiple files and may mix host-readable documents, scans, screenshots, photos, audio, or video.

## Output

When supported by the host AI:

- editable `.docx`
- accessible `.pdf`

## Core rules

- Match answers by meaning, not merely page position.
- Verify reconstruction, not whether the instructor is academically correct.
- Never add substantive content.
- Never silently drop uncertain content.
- Do not make the instructor perform routine intermediate steps.

See [`SKILL.md`](./SKILL.md) for the full workflow.

## What is a Skill?

A Skill is a folder whose required `SKILL.md` file contains metadata plus reusable workflow instructions. Systems that support the Agent Skills format can discover and load the workflow when relevant.

This repository intentionally keeps v0.1 **instruction-first** and has no required scripts. That makes the core behavior easier to test across different models and environments.

## Trying it in a system with Agent Skills support

Install or place the `accessible-answer-key` folder where your host expects skills, then explicitly invoke **accessible-answer-key** during early testing so routing behavior does not confound workflow testing.

## Trying it in an AI that does not support installable Skills

For experimental portability testing:

1. Start a new chat.
2. Provide `SKILL.md` to the model as task instructions (attach it if the host can read Markdown files, or paste it if necessary).
3. Upload the Question Source Set and Answer Source Set.
4. Tell the model which source set is the student-facing questions and which is the instructor answer material if that is not obvious.
5. Ask it to follow `SKILL.md` exactly and create the Word and PDF outputs.

A host that cannot create DOCX/PDF files cannot fully satisfy the output contract. The skill does not magically add file-generation or media-reading capabilities that the host model lacks.

## Suggested first tests

Do **not** begin with a 100-page packet. Start with a few representative instructor examples that expose the failure modes we care about:

- an answer written visually under the wrong subpart but semantically belonging to another;
- a derivation that continues in an unexpected part of the page;
- an isolated side annotation;
- a question with no instructor answer;
- a clearly crossed-out attempt;
- equations plus a diagram;
- mixed typed questions and photographed handwritten solutions.

Use [`TESTING.md`](./TESTING.md) to score results consistently.

## Project philosophy

This project intentionally does **not** try to make the AI a better professor. It tries to make the AI a more reliable document converter.

The AI may reason about **where source content belongs**. It should not reason about **what the answer ought to have been**.
