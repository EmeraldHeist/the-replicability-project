# Case 8: Breast cancer survival

| | |
|---|---|
| **Paper** | Pereira et al., The somatic mutation profiles of 2,433 breast cancers refine their genomic and transcriptomic landscapes. Nature Communications, 2016 (METABRIC) |
| **Publication record check** | Crossref checked 2026-10-10: an erratum correcting a spelling error in the title; no retraction. The original METABRIC paper (Curtis et al., Nature, 2012) still needs checking. PubMed and Retraction Watch checks pending |
| **Field** | Computational biology / statistics |
| **Status** | Planned |

> This is a plan. No results have been obtained or claimed.

## Source paper

The paper above. Three to five claims, for example a survival association of a clinical variable or subtype, are chosen from the full text before the data are opened.

## Data and feasibility

- Use METABRIC from cBioPortal and TCGA-BRCA from the NCI Genomic Data Commons.
- Define the endpoint, follow-up rules, eligible cases and feature harmonization before fitting anything.
- Report sample attrition at every join.

## Tier 1: Reproduce (same data, same tools)

- Reproduce cohort characteristics and the chosen clinical survival results within METABRIC, including a proportional-hazards check.

## Tier 2: Re-implement (same data, different tools)

- Fit the same Cox models in R (survival) and Python (lifelines) and compare estimates, tie and censoring handling, and confidence intervals.

## Tier 3: Replicate (different data)

Apply the same prespecified model to TCGA-BRCA as an external cohort, documenting endpoint and platform differences.

## Checks and validation

- Keep normalization, imputation, feature selection and tuning inside training folds.
- Report concordance, calibration, confidence intervals and risk-group plots.

## Optional extension exercise

Do pathway-level multiomic features improve survival prediction beyond clinical variables? Uses nested validation and treats the external cohort as a genuine test.

## Running it

- `make demo`: simulated or small non-identifying matrices through the full workflow.
- `make full`: obtains the declared public data and freezes manifests. Tests cover patient joins, censoring logic and leakage barriers.

## Deliverables

Cohort flow diagram, prespecified models, per-claim reproduction table, tier comparison, calibration analysis, reconstruction log and limitations.

## Skills practiced

- Data management
- Version control and project hygiene
- Statistics and evaluation design
- Reading papers closely
- Multi-tool fluency
- Verifying AI-assisted work
- Documentation and communication

See [README](../README.md#skills-reproducibility-requires) for the full list. The skill numbers here are a plan, and the case report will record what was actually needed.

## Shared method

Success criteria, outcome categories, logs and reporting language follow [PROTOCOL.md](../PROTOCOL.md). Results will go in a report based on [reports/TEMPLATE.md](../reports/TEMPLATE.md).
