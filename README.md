# The Replicability Project

A learning project and portfolio of reproduction and replication case studies across bioinformatics, cheminformatics, and machine learning **.

For each published paper, I try to (1) rerun the reported result, (2) re-implement it with different tools, and (3) test whether it holds on different data. Along the way I log every detail the paper did not state but I needed, so the next person has an easier time.

**Scope:** This is a personal learning project, not a systematic study. The sample is small and non-random, and any pattern across cases is anecdotal. Nothing here is a finding until its case report is linked and complete.

## Why

Computational results are often hard to rerun: environments are unspecified, data splits leak, seeds and preprocessing steps go unreported, and benchmarks contain flaws. AI coding tools add another risk, since generated code can look right while hiding errors. This project practices **verifying** analyses instead of trusting them, and documents what that takes.

## The three tiers

| Tier | Name | Same data? | Same tools? | Question |
|---|---|---|---|---|
| 1 | **Reproduce** | Yes | Yes | Does the reported result come back? |
| 2 | **Re-implement** | Yes | No | Does it survive a different implementation? |
| 3 | **Replicate** | No | Where possible, no | Does the finding generalize? |

Reproducibility is not correctness: a faithful rerun of a flawed analysis still passes. That is why Tiers 2 and 3 exist.

## How cases are chosen

- **Non-retracted papers first.** Each paper is checked for retractions and corrections (Crossref, PubMed, and the Retraction Watch database) on the day work begins, and the date is recorded. An erratum is noted, not disqualifying.
- **Specific claims, chosen in advance.** Before touching any data I write down three to five claims from the paper to audit, and the success criteria for each tier.
- **A screen before the work.** Papers are scored low, medium or high risk with a [checklist](screen/CHECKLIST.md) fixed beforehand, so the screen can later be compared with what actually happened.
- **Later track:** retracted papers and matched non-retracted controls, used to test what the screen and the checks can and cannot detect.

See [PROTOCOL.md](PROTOCOL.md) for the full method.

## Cases

All cases are currently **planned**; no results have been claimed yet.

| # | Case | Paper audited | Status |
|---|---|---|---|
| 1 | [Single-cell drug response](cases/01-single-cell-drug-response.md) | Paper for GEO GSE131984 | Accession and paper to be confirmed |
| 2 | [FAERS drug-safety signals](cases/02-faers-drug-safety.md) | Signal mining of adverse events of proteasome inhibitors in multiple myeloma based on FAERS (Front. Pharmacol., 2024) | Planned |
| 3 | [Cancer drug response](cases/03-cancer-drug-response.md) | Corsello et al., Nature Cancer, 2020 | Planned |
| 4 | [RNA-seq workflow](cases/04-rnaseq-workflow.md) | Paper for GEO GSE245268 | Accession and paper to be confirmed |
| 5 | [Spatial transcriptomics](cases/05-spatial-transcriptomics.md) | 10x Visium breast cancer dataset; Wu et al., Nature Genetics, 2021 as a Tier 3 source | Planned |
| 6 | [CRISPR dependencies](cases/06-crispr-dependencies.md) | Meyers et al., Nature Genetics, 2017 | Planned |
| 7 | [Variant benchmarking](cases/07-variant-benchmarking.md) | Wagner et al., Cell Genomics, 2022 | Planned |
| 8 | [Breast cancer survival](cases/08-breast-cancer-survival.md) | Pereira et al., Nature Communications, 2016 (METABRIC) | Planned |
| 9 | [Missing-information assistant](cases/09-missing-information-assistant.md) | Not a paper audit; evaluated on the logs from cases 1 to 8 | Starts after three finished cases |

Planned order: 4, 7, 2, 8, then 3, 6, 1, 5, and 9 last.

## Practices

- Pinned environments (lockfiles or container digests) and clean-environment reruns
- Workflow managers (Nextflow or Snakemake) where appropriate
- Logged software versions, seeds, parameters, data checksums and extraction dates
- **LLM use is logged:** model, version, prompts, and what was changed by hand
- Each case has `make demo` (small, labeled subset, runs in CI) and `make full` (complete run; large data is downloaded, never committed)

## How papers and authors are treated

Papers are audited because they are public and useful to test, not because they are suspected of anything. Failures are written as "could not reproduce with the information provided." I will contact the authors before publishing a failure where practical. Many failures will be my own error, so each report lists what I checked. I make no claims about intent. Retractions, when included later, are used as public records, linked to their notices.

## Limitations

- Small, non-random sample chosen partly by data and code availability
- Observations across cases are exploratory, not statistical conclusions
- Some problems (for example fabrication or lab-record errors) cannot be detected from a paper and its artifacts
- A failed reproduction can reflect my mistakes or changed data access, not only flaws in the paper

## Repository layout

```
README.md          This file
PROTOCOL.md        Shared method for every case
screen/            Screening checklist
cases/             One plan per case (and, as work happens, code and outputs)
reports/           Completed case reports (TEMPLATE.md included)
LEARNING_LOG.md    What I got wrong, and why
LICENSE            MIT (code)
LICENSE-docs       CC BY 4.0 (written material)
```

## AI assistance

Some drafting and code in this repository is AI-assisted. Each case keeps an LLM-use log recording the model, version, prompts and what was changed by hand, and all AI-written code is reviewed and tested before it is relied on.

## License

- **Code:** [MIT](LICENSE)
- **Written material** (case plans, protocol, checklists, reports): [CC BY 4.0](LICENSE-docs)

Third-party data, papers and tools referenced here keep their own licenses and terms. They are linked, not redistributed.

## Contributing and contact

Corrections, pointers to missing information, and reproduction attempts of your own are welcome via GitHub issues.
