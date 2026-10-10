# Case 5: Spatial transcriptomics

| | |
|---|---|
| **Paper** | No paper tied to the 10x dataset has been identified. Candidate Tier 3 source: Wu et al., A single-cell and spatially resolved atlas of human breast cancers. Nature Genetics, 2021 |
| **Publication record check** | Crossref checked 2026-10-10: no update, correction or retraction record for Wu et al. PubMed and Retraction Watch checks pending |
| **Field** | Bioinformatics |
| **Status** | Planned |

> This is a plan. No results have been obtained or claimed.

## Source paper

The 10x Genomics Human Breast Cancer Visium Fresh Frozen Whole Transcriptome dataset. Tier 1 reproduces the vendor's published outputs and a documented tutorial workflow. Whether the spatial data from Wu et al. can be used for Tier 3 depends on data access and comparable processing, which are to be confirmed.

## Data and feasibility

- Use the Space Ranger outputs, feature-barcode matrix, spatial coordinates, scale factors and tissue image.
- One tissue section supports method checks and description, not patient-level conclusions.

## Tier 1: Reproduce (same data, same tools)

- Load the Space Ranger output and reproduce the vendor-reported QC metrics, spot counts and clustering using a documented workflow.
- Annotate broad regions with published markers and keep uncertain labels explicit.

## Tier 2: Re-implement (same data, different tools)

- Run the workflow in Seurat and in Scanpy with Squidpy, and compare clusters and spatially variable genes from two methods.

## Tier 3: Replicate (different data)

A second breast cancer section, for example from the Wu et al. data if usable. Record which annotations can be reused.

## Checks and validation

- Use spatial blocks, not random spots, for train and test separation.
- Repeat results across filtering, normalization, neighborhood-size and pathway-scoring choices.
- Do not read spot-level mixtures as single cells.

## Optional extension exercise

Compare gene, pathway and spatial-neighborhood representations for classifying independently defined tissue regions.

## Running it

- `make demo`: a reduced matrix and downsampled image.
- `make full`: downloads the documented 10x files. Actions tests loading, coordinate alignment, scoring and a small blocked-validation run.

## Deliverables

Reproducible spatial report, tissue maps, tier comparison, sensitivity analysis, reconstruction log and limitations.

## Skills practiced

- Version control and project hygiene
- Statistics and evaluation design
- Domain knowledge
- Multi-tool fluency
- Verifying AI-assisted work
- Documentation and communication

See [README](../README.md#skills-reproducibility-requires) for the full list. The skill numbers here are a plan, and the case report will record what was actually needed.

## Shared method

Success criteria, outcome categories, logs and reporting language follow [PROTOCOL.md](../PROTOCOL.md). Results will go in a report based on [reports/TEMPLATE.md](../reports/TEMPLATE.md).
