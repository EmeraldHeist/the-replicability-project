# Protocol

The method shared by every case. Each case plan only lists what is specific to it.

## 1. Paper record

Record the citation and DOI, the date and sources of the publication record check (corrections or retractions: Crossref, PubMed, Retraction Watch database), data and code availability, and why the paper was chosen. An erratum is recorded and does not rule a paper out.

Before touching data, read the paper and write down **three to five specific claims** to attempt.

## 2. Readiness check

Before starting, estimate the groundwork a case needs using [readiness/CHECKLIST.md](readiness/CHECKLIST.md): straightforward, some groundwork, or substantial groundwork. When the case is done, compare the estimate with the actual effort. The point is to improve my planning, and the estimate says nothing about the paper's quality.

## 3. Success criteria, set and justified before each tier

Written down and committed before running, with the commit noted in the report. Each criterion gets a one-line justification: the paper's own reported interval, variability I measured across seeds or folds on a baseline, the precision of the reported numbers, or a field convention. The defaults below are starting points, not justifications.

- identifiers and counts match exactly
- continuous metrics fall within 5% relative, or inside the paper's reported interval, whichever is wider
- methods keep the same ranking
- effects keep the same direction and significance

If a criterion has to change after I see results, I add a dated amendment with the reason, keep the original visible, and report the outcome against both. An outcome that depends on an amended criterion is recorded as "Reproduced with documented differences" at best.

## 4. Outcome categories

- Reproduced
- Reproduced with documented differences
- Not yet reproduced: details still needed
- Not reproduced after details were clarified: cause unknown
- Could not attempt: data or compute unavailable

None of these is a verdict on the paper. They describe what I was able to do.

## 5. Logs kept for every case

- **Reconstruction log:** every detail I had to look up, infer or ask about, how I resolved it (the authors' repository, the supplement, a documented assumption, a question to the authors), and whether it changed the result.
- **LLM-use log:** model, version, prompts, and what was changed by hand.
- **Environment record:** lockfile or container digest, software versions, seeds, data checksums, extraction dates.
- **Skills record:** which of the [skills listed in the README](README.md#skills-this-project-develops) the case needed, where I was strong, and where I had to learn. The list is tested against real work and revised.

## 6. Working with AI agents

When an agent writes or runs code, I record what it did, what I verified myself, and what I corrected. Agent output is checked against a reference, a different tool or a hand-computed example before it is relied on, and agents never choose splits, baselines or success criteria on my behalf. Some tiers or passes are done by hand, without an agent, to keep my own skills sharp and to compare effort and errors. See [REFERENCES.md](REFERENCES.md) for the evidence behind this approach. Reading the paper, choosing claims and setting criteria are done by me before an agent is involved. The agent works from a written spec in which each assumption states its source. The AI mode (agent-led, paired or by hand) is recorded for each tier, as described in [How I work with AI on a case](README.md#how-i-work-with-ai-on-a-case). For Tier 2, the agent does not see the Tier 1 code, so the re-implementation stays independent; using a different model family is an option.

## 7. Reporting language

- Describe what I did and what I found. Write "my attempt differed" and not "the paper failed."
- Treat my own reconstruction as the first suspect, and list what I checked before suggesting any other explanation.
- Share notes with the authors and invite correction before publishing a difference where practical.
- Say nothing about intent, and credit the source paper.

## 8. Running a case

Every case provides make demo, a small labeled subset that runs in GitHub Actions without paid services, and make full, the documented complete run. Large data is downloaded and never committed. Each case keeps a data manifest with checksums and licenses.

## 9. Practice rebuilds

For learning, parts of each case are rebuilt independently: once with notes, once from a checklist, then from the question alone using documentation. What changed between passes goes in [LEARNING_LOG.md](LEARNING_LOG.md).

## 10. Refactoring validated code

Refactoring means restructuring code, for example splitting it into functions, removing repetition, or separating reusable parts from case-specific ones, without changing what it produces. Fixing a bug, changing a parameter or adding a feature is not refactoring, because those change results.

- **Decide at the end of each case.** Whether the code needs refactoring is an explicit decision recorded in the report. A one-off script I will not reuse can be left alone. Asking for structure in the written spec (separate loading, QC, analysis and plotting; parameters in one config file) reduces the work later.
- **After, not during.** I do not refactor while reproducing a paper, because cleanup would confound the comparison. I refactor only after the case outcome is recorded.
- **Freeze the baseline first.** I tag the validated version in git and save its reference outputs (demo and full results) with checksums.
- **Prove nothing changed.** The refactored code must reproduce the saved outputs: exactly for identifiers and counts, and within the case's original tolerances for continuous values. I add tests that lock in current behavior before changing anything.
- **Small steps, separate commits.** Refactoring commits are kept apart from commits that change behavior, and `make demo` is rerun after each step. `make full` is rerun before I call the refactor done.
- **Watch for silent changes.** AI-assisted refactors can alter behavior without saying so (the order of random draws, default parameters, join and sort behavior, floating-point details). A refactor that moves a result beyond tolerance is treated as a bug in the refactor, not a finding.
- **Log it.** AI-assisted refactoring goes in the LLM-use log like any other AI work.
