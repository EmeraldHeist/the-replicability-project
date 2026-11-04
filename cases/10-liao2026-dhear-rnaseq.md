# Case 10: Liao et al. 2026, Daphnia magna RNA-seq (D-HEART paper)

| | |
|---|---|
| **Paper** | Liao et al., "Multidimensional Cardiac Phenotyping of *Daphnia magna* Enables One-Hour Effect-Based Screening of Aquatic Toxicity", *Environ. Sci. Technol.* 2026, doi:10.1021/acs.est.6c09772 (PMID 42863106) |
| **Publication record check** | 2026-11-04. Crossref lists the paper (published 2026-10-01) with no update or relation records; PubMed lists one record (42863106). Retraction Watch database not checked. |
| **Field** | Bioinformatics, ecotoxicology (transcriptomics) |
| **Status** | Exploratory Tier 1 pass done; criteria and claims not set beforehand (see report). Outcome pending my decisions. |

> The report is [reports/10-liao2026-dhear-rnaseq.md](../reports/10-liao2026-dhear-rnaseq.md). Files for this case are in [10-liao2026-dhear-rnaseq/](10-liao2026-dhear-rnaseq/).

## Source paper

The paper builds a video-based cardiac phenotyping platform (D-HEART) and pairs it with RNA-seq of 24 pooled *D. magna* libraries (8 conditions x 3 pools of about 500 animals): control, Cd(II), Cr(VI), Pb(II), Hg(II), imidacloprid and triclosan after 1 h at the fitted 48 h EC50, plus imidacloprid at 3 h. This case reproduces only the RNA-seq part. The cardiac dataset (116 descriptors per animal) and raw videos are not public, so the cardiac claims cannot be attempted.

## Data and feasibility

- **Reads:** BioProject PRJNA1304005, 24 runs (SRR34936983 to SRR34937006), 44.5 GB of SRA, paired-end NovaSeq X Plus PE150. All validated with `vdb-validate`.
- **Reference:** NCBI RefSeq GCF_020631705.1 (ASM2063170v1.1), genomic FASTA and GTF, MD5 verified. The SI names the assembly but not the annotation release.
- **Code from the authors:** https://github.com/LiaoZitong/Heartbeat-of-Daphnia-magna (MIT), with video-decoding scripts and a two-record HTI worked example. It contains no RNA-seq analysis code.
- **Compute and storage:** about 45 GB of SRA and about 100 GB of scratch at peak. Free disk had to be raised from 26 GB first. On a 16 GB laptop, RSEM alone took about 36 h of wall time (2026-11-02 23:10 UTC to 2026-11-04 10:45 UTC), of which roughly 45 minutes per library was awake compute; the rest was the laptop sleeping or running on battery.
- **Not public:** per-animal cardiac descriptors, raw videos, DESeq2 results, WGCNA module membership.

## Tier 1: Reproduce (same data, same tools)

Stated pipeline (SI Notes S4 and S11): fastp 0.23.4, HISAT2 2.2.1 (`--rna-strandness RF`), StringTie 2.2.1, RSEM 1.3.3 (TPM), DESeq2 1.42.0 (FDR < 0.05, stated |log2FC| >= 1), GOATOOLS, WGCNA (signed, power 20, minModuleSize 30, minKMEtoStay 0.3, mergeCutHeight 0.25). Compare per-group DEG counts, the DEG union and shared set, the 11 modules, and the gene-level values in SI Table S4.

## Tier 2: Re-implement (same data, different tools)

Done as an exploratory comparison: counts from StringTie, featureCounts and RSEM, each run through DESeq2.

## Tier 3: Replicate (different data)

Not attempted.

## Checks and validation

- `make demo`: pairwise DESeq2 on the committed RSEM gene count matrix; exact match to the saved reference counts.
- HTI worked example from the authors' repository, run in a clean conda environment: validation script passes.

## Running it

- `make demo` (in `10-liao2026-dhear-rnaseq/`): runs from the committed small inputs.
- `make full`: not automated. See `RUNBOOK.md` for the documented manual sequence.

## Deliverables

Case plan, report, scripts, data manifest with checksums, environment exports, reconstruction log, LLM-use log, derived tables (small), logs.

## Skills practiced

See the report. The skill numbers are a record of what the work needed.

## Shared method

Success criteria, outcome categories, logs and reporting language follow [PROTOCOL.md](../PROTOCOL.md). Results are in the report, which follows [reports/TEMPLATE.md](../reports/TEMPLATE.md).
