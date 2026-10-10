# Case 7: Variant benchmarking

| | |
|---|---|
| **Paper** | Wagner et al., Benchmarking challenging small variants with linked and long reads. Cell Genomics, 2022. DOI 10.1016/j.xgen.2022.100128 |
| **Retraction check** | Crossref checked 2026-10-10: no update, correction or retraction record. PubMed and Retraction Watch checks pending |
| **Field** | Bioinformatics / genomics |
| **Status** | Planned |

> This is a plan. No results have been obtained or claimed.

## Audit target

The paper above. Per its abstract, the HG002 benchmark covers 92% of the autosomal GRCh38 assembly (up from 85%), adds over 300,000 SNVs and about 50,000 indels, and finds eight times more false negatives in a short-read call set than the previous benchmark. These are the claims to audit. The full text must be read to identify the exact call set and comparison used.

## Data and feasibility

- Use the declared GRCh38 HG002 benchmark, the previous benchmark it is compared with, and the call set the paper used.
- Verify reference build and chromosome naming before comparing.
- Check whether newer HG002 benchmark releases exist, and justify the release chosen.

## Tier 1: Reproduce (same data, same tools)

- Compute benchmark region coverage and reproduce the comparison of false negatives between the old and new benchmarks on the same call set.
- Left-normalize and decompose variants consistently, and count only benchmark regions.

## Tier 2: Re-implement (same data, different tools)

- Benchmark the same call set with different comparison tools (for example hap.py and RTG vcfeval) and measure how variant representation and matching change precision, recall and F1.

## Tier 3: Replicate (different data)

Another GIAB sample among those in the paper, or a newer HG002 release if one is confirmed. Does the claimed improvement hold?

## Checks and validation

- Test with known edge cases and retain source dates, versions and missingness.
- Do not count unassessed regions as true negatives.

## Optional extension exercise

A versioned ClinVar and VEP evidence workbench showing how variant summaries change across ClinVar dates. Research use only; no clinical classification claims.

## Running it

- `make demo`: a small permitted slice of HG002 with cached annotation examples.
- `make full`: downloads the declared public benchmark. Actions runs normalization and comparison tests.

## Deliverables

Tested VCF workflow, per-claim reproduction table, tool comparison, provenance record, missing-information log and a research-only disclaimer.

## Shared method

Success criteria, outcome categories, logs and reporting language follow [PROTOCOL.md](../PROTOCOL.md). Results will go in a report based on [reports/TEMPLATE.md](../reports/TEMPLATE.md).
