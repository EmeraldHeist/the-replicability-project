# The Replicability Project

A learning project and portfolio of reproduction and replication case studies across bioinformatics, cheminformatics, and machine learning.

For each paper listed below, I rerun the analysis from description with published methods and tools. I then rebuild it with different tools, and test the same question on different data. Along the way I log the details that turned out to matter for reproducing each result.

**Scope:** This is a personal learning project, not a systematic study. The sample is small and non-random, and any pattern across cases is anecdotal. Nothing here is a finding until its case report is linked and complete. If my result differs from a paper's, that does not negate the paper's finding. It could simply mean that I could not reproduce it, possibly because the paper left out some information or because I missed something or made a wrong assumption in my own implementation.

**Disclosure:** I intend to be fully transparent about using AI-assisted code to reproduce and replicate these papers. The final methodology, core assumptions, and AI-assisted code frameworks will be fully documented and disclosed.

## Why this project

Computational results are often hard to reproduce. Researchers may not specify exactly what software versions they used, test data can accidentally overlap with training data, random starting points and data-cleaning steps go unreported, and the benchmarks used to judge results can have flaws [1-4]. AI coding tools add a new risk on top of this, since the code they generate can look correct while still containing hidden errors [5]. This project builds the habits needed to catch these problems: checking work carefully and writing down every decision along the way.

## What this project produces (minimum)

- Case studies that reproduce a result, rebuild it with different tools, and test it on different data (replicability)
- A reproducible setup for every case: pinned environments, scripted workflows, data manifests with checksums, automated demo runs, and tagged, citable releases
- A reconstruction log for each case, listing the key decisions and details a replicator needs, plus notes on how AI-assisted work was verified

## The three steps

| Tier | Name | Same data? | Same tools? | Question |
|---|---|---|---|---|
| 1 | **Reproduce** | Yes | Yes | Does the reported result come back when I follow the description? |
| 2 | **Re-implement** | Yes | No | Does it hold up when I rebuild it with different tools? |
| 3 | **Replicate** | No | No |  Does the finding hold on different data? |

Getting the same answer twice with the same tools shows an analysis is repeatable. Getting it with different tools or data is stronger evidence, which is why all three steps are here.

## Skills this project develops

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

## How I work with AI on a case

The order matters more than the tool. Reading, judging and deciding what success means come first and are mine.

1. **Read alone.** I read the paper before using any AI summary, and take notes on key assumptions, criteria and details the text does not spell out.
2. **Draft a preliminary workflow.**
3. **Define success first.** For each claim I write the success criterion and a one-line justification for it (see [PROTOCOL.md](PROTOCOL.md) section 3), and commit both before any code runs.
4. **Check with an AI, interactively.** I work through my notes, assumptions and criteria with an AI, which flags ambiguities and challenges my justifications, and I use it to plan the infrastructure. What each of us missed goes in the reconstruction log.
5. **Write the spec.** Claims, criteria, assumptions (each traced to paper text, a supplement or a repository, or marked as mine) and open questions. The written spec is the only handoff to the agent.
6. **Implement iteratively with a coding agent,** comparing against the published results and logging each difference and challenge. I do not loosen the criteria along the way. Each change is logged as either a fix that follows from the paper's description or a tweak made to close a gap.
7. **Record the AI mode for each tier,** and vary it on purpose across cases so effort and errors can be compared (anecdotally). The modes are defined by how much I stay in the loop, not by the product:
   - **Agent-led:** I hand over the written spec, the agent works through steps on its own, and I review at checkpoints.
   - **Paired:** I stay in the editor and work at the level of a function or a few lines, accepting or rejecting each change as it happens.
   - **By hand:** no AI.

   Using different model families for different tiers can reduce shared mistakes. The model and version are logged for every run.
8. **Later, extend and reuse.** A case with a recorded outcome of reproduced, or reproduced with documented differences, can become a base for new questions and for evaluating other work, worked on in pair with an AI. "Validated" means only this: for that paper's data and question, under the criteria set beforehand and with the pinned versions, the outcome was recorded. It does not mean the code is correct on any input. Each reuse starts by rerunning the case's `make demo`, reusable parts are kept apart from case-specific scripts, and extensions are labeled exploratory, reported separately, and never change the original case report.

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
- Each case has `make demo` (small labeled subset or synthetic data, runs in CI) and `make full` (complete run; large data is downloaded, never committed)

## Respect for the source papers

I chose these papers because their authors shared data and methods, and that openness is what makes this project possible. Each report credits and links the paper and describes my attempt in terms of what I did and what I needed. If my result differs from the paper's, I treat my own reconstruction as the first suspect and list what I checked. I will share my notes with the authors and welcome corrections. I make no claims about the quality or intent of anyone's work.

## Limitations

- Small, non-random sample chosen partly by data and code availability
- Observations across cases are exploratory, not statistical conclusions
- A difference between my result and a paper's can come from my choices, changed data access or software versions, as well as from missing detail in the text
- The skills list and the agent observations above are my working synthesis, and the cited studies are mostly preprints

## References

Numbered citations in the text refer to the list below. Most are preprints, and I have read abstracts and summaries, not every full text. [REFERENCES.md](REFERENCES.md) gives, for each source, what it is cited for. Accessed October 10, 2026.

1. Huang A, Knight IS, Naprienko S. 2025. *Data Leakage and Redundancy in the LIT-PCBA Benchmark.* arXiv:2507.21404. https://arxiv.org/abs/2507.21404
2. Liu H, Bushuiev R, Lightheart I, et al. 2026. *MassSpecGym in the Wild: Uncovering and Correcting Evaluation Pitfalls in AI-Driven Molecule Discovery.* arXiv:2606.19624. https://arxiv.org/abs/2606.19624
3. Chemistry World. *Benchmark flaws may be distorting AI drug discovery leaderboards.* https://www.chemistryworld.com/news/benchmark-flaws-may-be-distorting-ai-drug-discovery-leaderboards/4024084.article
4. Semmelrock H, et al. 2025. *Reproducibility in machine-learning-based research: Overview, barriers, and drivers.* AI Magazine. https://doi.org/10.1002/aaai.70002
5. Munn PR, Grenier JK. 2026. *From Prompt to Pipeline: A Comparative Evaluation of Large Language Model Coding Agents for Reproducible Bioinformatics Pipeline Construction.* bioRxiv. https://doi.org/10.64898/2026.09.11.751004
6. Siegel ZS, Kapoor S, Nadgir N, Stroebl B, Narayanan A. 2024. *CORE-Bench: Fostering the Credibility of Published Research Through a Computational Reproducibility Agent Benchmark.* Transactions on Machine Learning Research; arXiv:2409.11363. https://arxiv.org/abs/2409.11363
7. Starace G, Jaffe O, Sherburn D, et al. 2025. *PaperBench: Evaluating AI's Ability to Replicate AI Research.* arXiv:2504.01848. https://arxiv.org/abs/2504.01848
8. Li S, Wei QA, Tang J, et al. 2026. *ReproRepo: Scaling Reproducibility Audits with GitHub Repository Issues.* arXiv:2606.18237. https://arxiv.org/abs/2606.18237
9. Hu C, Zhang L, Lim Y, Wadhwani A, Peters A, Kang D. 2025. *REPRO-Bench: Can Agentic AI Systems Assess the Reproducibility of Social Science Research?* Findings of ACL 2025; arXiv:2507.18901. https://arxiv.org/abs/2507.18901
10. Mohl J, Gardner-Challis N, Dubois M, et al. 2026. *Automated Transcript Analysis for Detecting Flaws in Agentic Benchmarks.* arXiv:2607.27518. https://arxiv.org/abs/2607.27518
11. Nadgir N, Kapoor S, Liu K, et al. 2026. *Life After Benchmark Saturation: A Case Study of CORE-Bench.* arXiv:2606.26158. https://arxiv.org/abs/2606.26158
12. Kitzes J, Turek D, Deniz F, eds. 2018. *The Practice of Reproducible Research.* University of California Press. https://www.ucpress.edu/book/9780520294752/the-practice-of-reproducible-research
13. The Turing Way Community. *The Turing Way: Guide for Reproducible Research.* https://book.the-turing-way.org/reproducible-research/reproducible-research/

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