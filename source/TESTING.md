# v0.1 Test Plan

The goal of testing is to measure reconstruction reliability, not subject-matter intelligence.

For each test, keep the original Question Source Set and Answer Source Set available for manual comparison after the AI finishes.

## Pass/fail dimensions

Score each dimension as PASS or FAIL.

### 1. Question coverage

PASS if every question and subpart in the Question Source appears in the output structure.

A question with no instructor answer may remain unanswered, but it must not disappear and the AI must not invent an answer.

### 2. Answer-fragment coverage

PASS if every non-deleted instructor answer fragment is represented exactly once.

Check side notes, small equations, arrows, labels, and page continuations carefully.

### 3. Mapping accuracy

PASS if answer content is assigned to the question/subpart it semantically answers rather than merely to the nearest visual region.

### 4. No invention

PASS if the output contains no substantive explanation, equation, calculation step, conclusion, example, or answer that was not present in the instructor source.

### 5. No academic correction

PASS if the AI did not alter a numerical, mathematical, factual, or conceptual answer merely because it appeared incorrect.

Obvious spelling/OCR corrections are allowed.

### 6. Instructor method preservation

PASS if derivations and methods are preserved rather than replaced, shortened, or rewritten into the model's preferred solution.

### 7. Accessibility structure

PASS if the Word output uses logical headings/structure and selectable text, and figures are given useful descriptions without invented interpretation.

For PDF, do not mark formal standards compliance unless independently validated; this test is only a practical structure/readability check.

### 8. User intervention

PASS if the model completed normal-size work without making the user manually split pages, label fragments, compare intermediate transcriptions, or approve each stage.

## Recommended adversarial tests

### Test A — Spatial trap

Create or select an answer page where a calculation for part (b) is physically closer to the handwritten label for part (a).

Expected behavior: semantic fit wins over proximity.

### Test B — Continuation trap

Use a derivation that continues at the top of the next page without repeating the question number.

Expected behavior: the continuation stays with the same answer.

### Test C — Missing-answer trap

Include a question in the Question Source that has no corresponding instructor answer.

Expected behavior: no answer is invented.

### Test D — Wrong-but-source-faithful trap

Use an instructor source containing an intentionally incorrect arithmetic result or equation.

Expected behavior: the AI preserves the instructor's substantive content rather than correcting it.

### Test E — Side-note trap

Include a small margin note or arrow annotation.

Expected behavior: it is neither dropped nor detached from its meaningful context.

### Test F — Cross-out trap

Include one clearly crossed-out attempt and one ambiguous mark.

Expected behavior: clearly deleted content is excluded; ambiguous content is preserved/flagged instead of silently deleted.

### Test G — Mixed modality

Use typed questions plus photographed answers, or questions in PDF plus an answer explanation containing both an image and audio/video material.

Expected behavior: the same mapping and fidelity rules apply across modalities supported by the host.

## First comparison experiment

For a useful baseline, run the exact same source pair through:

1. the target AI with no special instructions other than "make this an accessible answer key";
2. the target AI with this Skill.

Compare the two outputs on the eight pass/fail dimensions above.

The main success metric for v0.1 is a reduction in:

- omitted fragments;
- wrong-subpart assignments;
- invented material;
- unnecessary instructor intervention.
