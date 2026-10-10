# The Replicability Project

A learning project and portfolio of reproduction and replication case studies across bioinformatics, cheminformatics, and machine learning.

For each paper that shares its data and methods, I rerun the analysis as described, rebuild it with different tools, and test the same question on different data. Along the way I log every detail I had to look up or work out, and I check my own work, including AI-assisted code, so the next person has an easier path.

**Scope:** This is a personal learning project, not a systematic study. The sample is small and non-random, and any pattern across cases is anecdotal. Nothing here is a finding until its case report is linked and complete. Where my result differs from a paper's, that tells you what I could reconstruct from public information. It is not a judgment on the paper.

## Why

Computational results are often hard to rerun: environments are unspecified, data splits leak, seeds and preprocessing steps go unreported, and benchmarks can contain flaws [1-4]. AI coding tools add another risk, since generated code can look right while hiding errors [5]. This project practices key skills in verifying analyses and documenting decisions along the way. 

## What this project produces (minimum)

  - Case studies that reproduce a result, rebuild it with different tools, and test it on different data
  - A reproducible setup for every case: pinned environments, scripted workflows, data manifests with checksums, automated demo runs, and tagged,    citable releases
  - A reconstruction log for each case, listing the key decisions and details a replicator needs, plus notes on how AI-assisted work was verified

## The three steps

| Tier | Name | Same data? | Same tools? | Question |
|---|---|---|---|---|
| 1 | **Reproduce** | Yes | Yes | Does the reported result come back when I follow the description? |
| 2 | **Re-implement** | Yes | No | Does it hold up when I rebuild it with different tools? |
| 3 | **Replicate** | No | Where possible, no | Does the finding hold on different data? |

Getting the same answer twice with the same tools shows an analysis is repeatable. Getting it with different tools or data is stronger evidence, which is why all three steps are here.

## Skills reproducibility requires

Reproducing or replicating research draws on many skills beyond the analysis itself. This project practices these:

1. **Environment and dependency management:** pinning versions, lockfiles, containers, clean-environment reruns
2. **Workflow and automation:** Nextflow, Snakemake, scripted pipelines that run end to end
3. **Data management:** exact accessions and release versions, checksums, provenance
4. **Version control and project hygiene:** Git, clear structure, readable history
5. **Statistics and evaluation design:** splits that match how data are related, leakage checks, baselines, variance across seeds, tolerances for "the same result"
6. **Domain knowledge:** knowing what a QC step or preprocessing choice is for
7. **Reading papers closely:** extracting testable claims and noticing what the text does not spell out
8. **Multi-tool fluency:** R and Python, and more than one tool for the same task
9. **Verifying AI-assisted work:** reviewing, testing and cross-checking generated code
10. **Documentation and communication:** notes others can follow, and respectful questions to authors
11. **Compute awareness:** memory, time and cost, and when cloud resources help

This list is my own working synthesis, informed by the literature on reproducibility barriers [4, 12, 13]. The case logs will show which skills each reproduction needed, and I will revise the list as evidence accumulates.

| Case | Skills most exercised |
|---|---|
| 1 Single-cell | 3, 5, 6, 8 |
| 2 FAERS | 3, 4, 5, 6, 8 |
| 3 Drug response | 3, 5, 6, 8 |
| 4 RNA-seq workflow | 1, 2, 3, 8, 11 |
| 5 Spatial | 5, 6, 8 |
| 6 CRISPR | 3, 5, 6, 7 |
| 7 Variant benchmarking | 3, 5, 6, 8 |
| 8 Survival | 3, 5, 7, 8 |
| 9 Method-details assistant | 7, 9, 10 |
| All cases | 4, 9, 10 |

## Working with AI agents

Agents change where the effort goes. They can take over some execution, which makes verification and judgment matter more. What published work suggests so far:

- **Reproduction is still hard for agents.** On CORE-Bench, a benchmark of computational reproducibility tasks drawn from 90 papers, the best baseline agent in the original paper reached 21% on the hardest level [6]. On PaperBench, which asks agents to replicate ICML 2024 papers from scratch, the top agent scored 21.0% [7]. Both used 2024 to 2025 models, and newer systems likely score higher.
- **Agents are better at pointing at a problem than pinpointing it.** In a study of 1,149 machine learning papers, the best agent setup surfaced at least one related human-reported reproducibility problem for about 90% of papers, but agents may still be insufficient at exact localization [8].
- **Plausible output can hide errors.** In a bioinformatics study, three coding agents produced credible-looking pipelines and documentation for a CUT&Tag analysis, but the outputs did not fully match a hand-coded reference, and some errors needed domain knowledge to spot [5].
- **Assessing reproducibility is harder than rerunning.** On REPRO-Bench, the best of three agents judged the reproducibility of social science papers with 21.4% accuracy [9].
- **Agent benchmarks need checking too.** Work on agentic benchmarks describes validity issues such as guessing vulnerability and tool failure, so a high or low score is not always what it seems [10].
- **Collaboration may help.** A small randomized experiment on reproduction tasks found a roughly 2x speedup for human-agent teams, likely an underestimate because about one-fifth of human-only attempts hit the time limit [11].

What this means for the skills above:

- **Matter more:** verifying AI work (9), evaluation design (5), domain knowledge (6), reading papers closely (7), and documentation (10). Agents optimize toward "it runs," so I define splits, baselines and tolerances beforehand.
- **Change in kind:** environments (1), workflows (2), data (3), tools (8) and compute (11). The agent writes more of the code, but I need enough fluency to read it, notice a wrong tool choice or a silent change, and keep provenance.
- **New:** scoping a task into checkable steps, reviewing at checkpoints before expensive runs, and logging model versions and prompts so my own run is reproducible.
- **The risk to manage:** you cannot verify what you do not understand. I rebuild parts of each case by hand, without an agent, to keep my skills my own, and I compare effort and errors with and without agent help. These comparisons are anecdotal.

## How cases are chosen

- **Papers that share their data and methods openly**, which is what makes reproduction possible.
- **Specific claims, chosen in advance.** Before touching data I write down three to five claims from the paper to attempt, and the success criteria for each step.
- **A readiness check.** I estimate how much groundwork a case needs using a [checklist](readiness/CHECKLIST.md), then compare that estimate with the actual effort, so I get better at planning.
- **A publication record check.** I look for corrections or retractions on the day I start and record the date, so I am working from the current record.

See [PROTOCOL.md](PROTOCOL.md) for the full method.

## Cases

All cases are currently **planned**. No results have been claimed yet.

| # | Case | Paper studied | Status |
|---|---|---|---|
| 1 | [Single-cell drug response](cases/01-single-cell-drug-response.md) | Paper for GEO GSE131984 | Accession and paper to be confirmed |
| 2 | [FAERS drug-safety signals](cases/02-faers-drug-safety.md) | Signal mining of adverse events of proteasome inhibitors in multiple myeloma based on FAERS (Front. Pharmacol., 2024) | Planned |
| 3 | [Cancer drug response](cases/03-cancer-drug-response.md) | Corsello et al., Nature Cancer, 2020 | Planned |
| 4 | [RNA-seq workflow](cases/04-rnaseq-workflow.md) | Paper for GEO GSE245268 | Accession and paper to be confirmed |
| 5 | [Spatial transcriptomics](cases/05-spatial-transcriptomics.md) | 10x Visium breast cancer dataset; Wu et al., Nature Genetics, 2021 as a Tier 3 source | Planned |
| 6 | [CRISPR dependencies](cases/06-crispr-dependencies.md) | Meyers et al., Nature Genetics, 2017 | Planned |
| 7 | [Variant benchmarking](cases/07-variant-benchmarking.md) | Wagner et al., Cell Genomics, 2022 | Planned |
| 8 | [Breast cancer survival](cases/08-breast-cancer-survival.md) | Pereira et al., Nature Communications, 2016 (METABRIC) | Planned |
| 9 | [Method-details assistant](cases/09-method-details-assistant.md) | Not a paper reproduction; evaluated on the logs from cases 1 to 8 | Starts after three finished cases |

Planned order: 4, 7, 2, 8, then 3, 6, 1, 5, and 9 last.

## Practices

- Pinned environments (lockfiles or container digests) and clean-environment reruns
- Workflow managers (Nextflow or Snakemake) where appropriate
- Logged software versions, seeds, parameters, data checksums and extraction dates
- **A reconstruction log** for every case: each detail I had to look up, infer or ask about, and how I resolved it
- **LLM use is logged:** model, version, prompts, and what was changed by hand
- Each case has `make demo` (small, labeled subset, runs in CI) and `make full` (complete run; large data is downloaded, never committed)

## Respect for the source papers

I chose these papers because their authors shared data and methods, and that openness is what makes this project possible. Each report credits and links the paper and describes my attempt in terms of what I did and what I needed. If my result differs from the paper's, I treat my own reconstruction as the first suspect and list what I checked. I will share my notes with the authors and welcome corrections. I make no claims about the quality or intent of anyone's work.

## Limitations

- Small, non-random sample chosen partly by data and code availability
- Observations across cases are exploratory, not statistical conclusions
- A difference between my result and a paper's can come from my choices, changed data access or software versions, as well as from missing detail in the text
- The skills list and the agent observations above are my working synthesis, and the cited studies are mostly preprints

## References

Numbered citations in the text refer to [REFERENCES.md](REFERENCES.md).

## Repository layout

```
README.md          This file
PROTOCOL.md        Shared method for every case
REFERENCES.md      Sources cited, with what each is cited for
readiness/         Readiness checklist
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

Corrections, pointers to details I missed, and reproduction attempts of your own are welcome via GitHub issues.
