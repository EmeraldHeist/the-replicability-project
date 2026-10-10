# Protocol

The method shared by every case. Each case plan only lists what is specific to it.

## 1. Paper selection record

Record: DOI; the date and sources of the retraction and correction check (Crossref, PubMed, Retraction Watch database); data and code availability; and why the paper was chosen. An erratum is recorded, not disqualifying.

Before touching data, read the paper and write down **three to five specific claims** to audit.

## 2. Screen before work

Score the paper low, medium or high risk using [screen/CHECKLIST.md](screen/CHECKLIST.md) before any rerun. The checklist is not changed after outcomes are known. The score is later compared with what happened, so the screen itself can be evaluated.

## 3. Success criteria, set before each tier

Written down before running. Starting defaults, adjusted per case:

- identifiers and counts match exactly
- continuous metrics fall within 5% relative, or inside the paper's reported interval, whichever is wider
- methods keep the same ranking
- effects keep the same direction and significance

## 4. Outcome categories

- Reproduced
- Reproduced with documented deviations
- Not reproduced: information missing from the paper or repository
- Not reproduced: discrepancy persists after the missing information was resolved
- Not testable: data or compute unavailable

## 5. Logs kept for every case

- **Missing-information log:** every detail needed but not stated, how it was resolved (author repository, supplement, a documented guess, a question to the authors), and whether it changed the result.
- **LLM-use log:** model, version, prompts, and what was changed by hand.
- **Environment record:** lockfile or container digest, software versions, seeds, data checksums, extraction dates.

## 6. Reporting language

Failures are written as "could not reproduce with the information provided." Authors are contacted before publication where practical. Reports say nothing about intent. My own error is a possible cause of every failure, so each report lists what was checked.

## 7. Running a case

Every case provides `make demo`, a small labeled subset that runs in GitHub Actions without paid services, and `make full`, the documented complete run. Large data is downloaded and never committed. Each case keeps a data manifest with checksums and licenses.

## 8. Practice rebuilds

For learning, parts of each case are rebuilt independently: once with notes, once from a checklist, then from the question alone using documentation. What changed between passes goes in [LEARNING_LOG.md](LEARNING_LOG.md).
