# Case 3: Cancer drug response

| | |
|---|---|
| **Paper** | Corsello et al., Discovering the anticancer potential of non-oncology drugs by systematic viability profiling. Nature Cancer, 2020 |
| **Retraction check** | Crossref checked 2026-10-10: no update, correction or retraction record. PubMed and Retraction Watch checks pending |
| **Field** | Cheminformatics / computational biology |
| **Status** | Planned |

> This is a plan. No results have been obtained or claimed.

## Audit target

The paper above. Three to five specific claims, for example a response distribution or a reported selective sensitivity with its biomarker, are chosen from the full text before the data are opened.

## Data and feasibility

- Use the PRISM Repurposing release the paper describes with a matching molecular feature release. Record release names, cell line and compound identifiers, coverage and data-use terms.
- Note any difference between the paper's processing and the released data.

## Tier 1: Reproduce (same data, same tools)

- Harmonize cell line and compound identifiers.
- Reproduce the chosen results from the released data using the paper's stated processing.
- Distinguish reported dose-response parameters from newly fitted curves.

## Tier 2: Re-implement (same data, different tools)

- Refit response summaries and biomarker associations with different tools or models, for example elastic net and a tree-based model, and compare.
- Compare against a tissue-only baseline.

## Tier 3: Replicate (different data)

A newer PRISM release, or an independent screen such as GDSC or CTRP for overlapping compounds and cell lines. Does the selective sensitivity replicate?

## Checks and validation

- Audit overlap between training and test cell lines and related screens.
- Check that tissue labels and batch structure do not create shortcuts.
- Keep preprocessing inside training folds, report per-drug results with uncertainty, and compare with simple baselines.

## Optional extension exercise

Do pathway-level features generalize to held-out cancer types better than gene expression? Uses a predeclared drug panel.

## Running it

- `make demo`: a small versioned extract verifies joins, splits and baselines.
- `make full`: fetches the frozen releases. Actions checks only the demo.

## Deliverables

Data manifest, harmonization audit, split definitions, per-claim reproduction table, tier comparison, missing-information log and limitations.

## Shared method

Success criteria, outcome categories, logs and reporting language follow [PROTOCOL.md](../PROTOCOL.md). Results will go in a report based on [reports/TEMPLATE.md](../reports/TEMPLATE.md).
