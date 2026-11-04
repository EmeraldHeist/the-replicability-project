# Learning log

What I got wrong, what I misunderstood, and what changed. Entries are dated and tied to a case.

## 2026-11-04, Case 10 (Liao et al. 2026, Daphnia RNA-seq)

Entries come from the session worklog. "I" is my own decision or action; "Claude" is a choice or mistake made by the AI assistant. I will add what I learned myself in the report.

- **A stated cutoff can disagree with the paper's own table.** The methods say changed genes need at least 2-fold change, but SI Table S4 lists significant genes at 1.5 to 2-fold. Claude chose 1.5-fold after seeing the paper's totals, so the match is a fit, not a finding.
- **Gene-level checks are sharper than totals.** Matching per-group totals looked good. Comparing 31 gene results from Table S4 showed which count source (RSEM) and model (separate comparisons) fit best.
- **Claude's time estimate was wrong.** It said RSEM would take about 4 days. The laptop had been asleep. The real time was about 45 minutes per sample.
- **Claude recorded a tool version wrongly.** The manifest said fastp matched the paper (0.23.4), but 1.0.1 was installed. Found and fixed on 2026-11-04.
- **Mac scripting problems.** `mapfile` is missing in the Mac's bash 3.2, HISAT2 fails on paths with spaces, and `prepDE.py` crashed. All were fixed.
- **Not set beforehand:** claims, pass/fail criteria and written instructions. Next time they come first.

