# Case 6: CRISPR dependencies

| | |
|---|---|
| **Paper** | Meyers et al., Computational correction of copy number effect improves specificity of CRISPR-Cas9 essentiality screens in cancer cells. Nature Genetics, 2017 |
| **Publication record check** | Crossref checked 2026-10-10: no update, correction or retraction record. PubMed and Retraction Watch checks pending |
| **Field** | Computational biology |
| **Status** | Planned |

> This is a plan. No results have been obtained or claimed.

## Source paper

The paper above. Three to five specific claims are chosen from the full text before the data are opened.

## Data and feasibility

- Use one frozen DepMap Public release; record release names, checksums, model and gene identifiers and access terms.
- The release is newer than the paper, so processing may differ. Expected deviations are documented and treated as part of the result.
- The lineage is chosen before looking at results.

## Tier 1: Reproduce (same data, same tools)

- Reproduce the chosen qualitative claims on the release data, such as the effect of copy number on gene-effect scores or known selective dependencies, using the paper's stated approach.
- Distinguish selective dependencies from broadly essential genes.

## Tier 2: Re-implement (same data, different tools)

- Compare gene-effect scores from different processing methods if the releases distribute more than one (availability to be confirmed), and measure agreement in dependency calls.

## Tier 3: Replicate (different data)

A second DepMap release, and an independent screen type if available. Measure the rank stability of the dependencies.

## Checks and validation

- Bootstrap resampling to test rank stability.
- Keep feature selection inside training data and use leave-one-lineage-out tests where they fit.
- Correlation between knockout and drug response is not proof that a compound acts through that target.

## Optional extension exercise

An interpretable evidence score and ranked evidence cards for candidate dependencies in one lineage.

## Running it

- `make demo`: a small redistributable extract or synthetic schema-compatible data.
- `make full`: requires obtaining the DepMap files under their terms. Tests verify identifiers, score direction, joins and rankings.

## Deliverables

Data manifest, harmonization notes, per-claim reproduction table, tier comparison, stability analysis, reconstruction log and limitations.

## Skills practiced

- Data management
- Version control and project hygiene
- Statistics and evaluation design
- Domain knowledge
- Reading papers closely
- Verifying AI-assisted work
- Documentation and communication

See [README](../README.md#skills-this-project-develops) for the full list. The skill numbers here are a plan, and the case report will record what was actually needed.

## Shared method

Success criteria, outcome categories, logs and reporting language follow [PROTOCOL.md](../PROTOCOL.md). Results will go in a report based on [reports/TEMPLATE.md](../reports/TEMPLATE.md).
