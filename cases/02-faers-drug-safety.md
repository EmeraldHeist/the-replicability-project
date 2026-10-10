# Case 2: FAERS drug-safety signals

| | |
|---|---|
| **Paper** | Signal mining of adverse events of proteasome inhibitors in multiple myeloma based on FAERS. Frontiers in Pharmacology, 2024. DOI 10.3389/fphar.2024.1396378 |
| **Retraction check** | Crossref checked 2026-10-10: no update, correction or retraction record. PubMed and Retraction Watch checks pending |
| **Field** | Pharmacovigilance / data engineering |
| **Status** | Planned |

> This is a plan. No results have been obtained or claimed.

## Audit target

The paper above. Its quarters, drugs, signal method, thresholds and deduplication approach are to be recorded from the full text before work starts. A fallback is an earlier FAERS analysis of peripheral neuropathy with newer proteasome inhibitors.

## Data and feasibility

- Use the FAERS quarterly files for the quarters the paper states, and record the extraction date and dictionary versions.
- FAERS reports are revised over time, so exact count matches are not guaranteed. The tolerance is set before starting.
- FAERS is not a denominator for clinical incidence.

## Tier 1: Reproduce (same data, same tools)

- Rebuild the case, drug, reaction, indication and outcome tables with report versions and case identifiers preserved.
- Reproduce the paper's case counts, drug-event counts and reported disproportionality statistics for its top events.
- Log the deduplication rule, product-name mapping and primary-suspect definition if the paper omits them.

## Tier 2: Re-implement (same data, different tools)

- Write an independent implementation (SQL versus pandas or R) of the same definitions and compare.
- Then vary defensible choices: FDA-style deduplication, primary suspect only versus any role, and different comparator sets. Report which signals survive.

## Tier 3: Replicate (different data)

Later quarters the paper did not include, or a second drug class. Do the same signals appear?

## Checks and validation

- Recompute each statistic from the reported two-by-two counts and check for arithmetic inconsistencies.
- Hand-check examples, prevent many-to-many joins from multiplying reports, and flag sparse cells.
- A signal is a prompt for investigation, not evidence of causation.

## Optional extension exercise

Within-class adverse event patterns and a sensitivity table, plus a small dashboard showing uncertainty flags.

## Running it

- `make demo`: ingests an archived sample offline and runs schema checks, SQL summaries and verified calculations.
- `make full`: ingests versioned public data. Codespaces starts the database; Actions runs the offline demo.

## Deliverables

Versioned schema, ETL and SQL, data-quality report, missing-information log, tier comparison table, sensitivity table, and a plain-language explanation of FAERS limits.

## Shared method

Success criteria, outcome categories, logs and reporting language follow [PROTOCOL.md](../PROTOCOL.md). Results will go in a report based on [reports/TEMPLATE.md](../reports/TEMPLATE.md).
