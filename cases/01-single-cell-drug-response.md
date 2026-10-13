# Case 1: Single-cell drug response

| | |
|---|---|
| **Paper** | To be confirmed (publication linked to GEO GSE131984) |
| **Publication record check** | Pending until the paper is identified |
| **Field** | Bioinformatics |
| **Status** | Accession and paper to be confirmed |

> This is a plan. No results have been obtained or claimed.

## Source paper

The publication linked to GEO series GSE131984. Before anything else, confirm that the accession is a single-cell study with treatment and resistance labels, and identify its paper. If there is no linked paper or the labels are unusable, this case switches to another public single-cell drug-treatment dataset that has a paper, and the reason is recorded here.

## Data and feasibility

- Record the exact accession, files, sample identifiers, biological replicate structure, and whether processed counts are available.
- Check the paper's publication record for corrections or retractions, and note the date.

## Tier 1: Reproduce (same data, same tools)

- Rerun the authors' stated QC, normalization, feature selection, dimensionality reduction, clustering and marker analysis.
- Reproduce one or two reported findings, such as cluster counts, marker genes or a treatment-associated state.
- Log every filter, threshold, resolution and seed the paper does not state.

## Tier 2: Re-implement (same data, different tools)

- Run the same analysis in Seurat and Scanpy and compare cluster agreement (for example the adjusted Rand index) and marker overlap.
- Aggregate counts by biological replicate and compare two differential expression methods (for example DESeq2 and edgeR).

## Tier 3: Replicate (different data)

A second public single-cell dataset with a comparable treatment design. Does the reported association hold? Record which QC and validation decisions had to change.

## Checks and validation

- Check whether batch, culture or donor is confounded with treatment.
- Split at the donor, culture or replicate level, never by cell.
- For any prediction, keep normalization and feature selection inside training folds and compare with a majority-class baseline.

## Optional extension exercise

Do pathway-level scores predict resistance more consistently than individual genes? Only attempted if resistance labels are independent of the features, and treated as a learning exercise.

## Running it

- `make demo`: a small labeled subset through QC, feature generation and a baseline evaluation.
- `make full`: the documented complete analysis after data download.
- A manually triggered GitHub Action checks the demo; a rendered report on GitHub Pages follows once results exist.

## Deliverables

Repository, lockfile, data manifest, QC and sample table, results table for each claim attempted, reconstruction log, tier comparison, and limitations.

## Skills practiced

- Data management
- Version control and project hygiene
- Statistics and evaluation design
- Domain knowledge
- Multi-tool fluency
- Verifying AI-assisted work
- Documentation and communication

See [README](../README.md#skills-this-project-develops) for the full list. The skill numbers here are a plan, and the case report will record what was actually needed.

## Shared method

Success criteria, outcome categories, logs and reporting language follow [PROTOCOL.md](../PROTOCOL.md). Results will go in a report based on [reports/TEMPLATE.md](../reports/TEMPLATE.md).
