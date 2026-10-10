# Case 4: RNA-seq workflow

| | |
|---|---|
| **Paper** | To be confirmed (publication linked to GEO GSE245268) |
| **Retraction check** | Pending until the paper is identified |
| **Field** | Bioinformatics |
| **Status** | Accession and paper to be confirmed |

> This is a plan. No results have been obtained or claimed.

## Audit target

The publication linked to GEO series GSE245268. A related BioProject (PRJNA1018977) may exist for this study, but the link has not been verified. If only deposited data or a non-peer-reviewed report exist, this case is labeled a **pipeline audit** rather than a paper audit.

## Data and feasibility

- Use a small balanced subset for development and the full accession for the final run.
- Freeze the genome build, annotation release, accession-to-sample mapping, pipeline version and container digests.

## Tier 1: Reproduce (same data, same tools)

- Run read QC, alignment or quantification, gene counting and MultiQC with a pinned nf-core/rnaseq version.
- Compare count totals and QC patterns with the authors' processed data or stated methods, and explain differences instead of forcing identical output.

## Tier 2: Re-implement (same data, different tools)

- Compare STAR plus featureCounts with Salmon on matched samples: count correlation, differential-expression overlap, runtime and storage.

## Tier 3: Replicate (different data)

A second small public RNA-seq accession. Run the same workflow and record which parameters had to change.

## Checks and validation

- Rule-based sample flags for mapping, duplication, assigned reads, strandedness, library composition and metadata inconsistencies, treated as review prompts and not proof a sample is invalid.
- Unit tests for metadata parsing and QC rules, plus an end-to-end test on tiny public reads.
- Confirm failed tasks resume without silently reusing incompatible outputs.

## Optional extension exercise

Production-workflow features: a machine-readable QC table, a human-readable report, local and AWS execution profiles, and a cost and runtime summary.

## Running it

- `make demo`: a compact test dataset in GitHub Actions.
- `make full`: the full accession on local, Docker or AWS profiles. A versioned release archives configuration, reports and a provenance manifest without large sequencing files.

## Deliverables

Public workflow repository, containers, test data, automated checks, MultiQC report, QC decision table, tier comparison, missing-information log, cost and runtime summary, and an architecture diagram.

## Shared method

Success criteria, outcome categories, logs and reporting language follow [PROTOCOL.md](../PROTOCOL.md). Results will go in a report based on [reports/TEMPLATE.md](../reports/TEMPLATE.md).
