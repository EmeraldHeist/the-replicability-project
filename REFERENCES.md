# References

Sources cited in this repository, each with what it is cited for. Most are preprints, and I have read abstracts and summaries, not every full text. Claims are stated only as far as the abstract or page supports them. Accessed October 10, 2026. Corrections are welcome via issues.

## Benchmark flaws and evaluation problems

**[1]** Huang A, Knight IS, Naprienko S. 2025. *Data Leakage and Redundancy in the LIT-PCBA Benchmark.* arXiv:2507.21404. https://arxiv.org/abs/2507.21404
Cited for: an audit of a virtual screening benchmark reporting leakage and redundancy across its splits, and a no-parameter memorization baseline matching or exceeding several reported models.

**[2]** Liu H, Bushuiev R, Lightheart I, et al. 2026. *MassSpecGym in the Wild: Uncovering and Correcting Evaluation Pitfalls in AI-Driven Molecule Discovery.* arXiv:2606.19624. https://arxiv.org/abs/2606.19624
Cited for: evaluation issues (data leakage, shortcut learning, implementation bugs) found in at least 17 of 26 papers reporting results on one benchmark in its first year.

**[3]** Chemistry World. *Benchmark flaws may be distorting AI drug discovery leaderboards.* https://www.chemistryworld.com/news/benchmark-flaws-may-be-distorting-ai-drug-discovery-leaderboards/4024084.article
Cited for: a news report on a study finding train-test leakage and contradictory labels in most biomolecular benchmark datasets examined. The underlying study is not separately cited here.

**[4]** Semmelrock H, et al. 2025. *Reproducibility in machine-learning-based research: Overview, barriers, and drivers.* AI Magazine. https://doi.org/10.1002/aaai.70002
Cited for: an overview of barriers to reproducibility in ML research, including missing data and code, software versions, hyperparameters and hardware.

## AI-assisted and agent-built analyses

**[5]** Munn PR, Grenier JK. 2026. *From Prompt to Pipeline: A Comparative Evaluation of Large Language Model Coding Agents for Reproducible Bioinformatics Pipeline Construction.* bioRxiv. https://doi.org/10.64898/2026.09.11.751004
Cited for: three coding agents producing credible-looking pipelines and documentation that did not fully match a hand-coded reference, with some errors needing domain knowledge. Read as an abstract and author summary.

**[6]** Siegel ZS, Kapoor S, Nadgir N, Stroebl B, Narayanan A. 2024. *CORE-Bench: Fostering the Credibility of Published Research Through a Computational Reproducibility Agent Benchmark.* Transactions on Machine Learning Research; arXiv:2409.11363. https://arxiv.org/abs/2409.11363
Cited for: a benchmark of 270 reproduction tasks from 90 papers; the best baseline agent reached 21% on the hardest level (GPT-4o).

**[7]** Starace G, Jaffe O, Sherburn D, et al. 2025. *PaperBench: Evaluating AI's Ability to Replicate AI Research.* arXiv:2504.01848. https://arxiv.org/abs/2504.01848
Cited for: agents replicating 20 ICML 2024 papers from scratch; the top agent scored 21.0%, and ML PhD students did better on a subset.

**[8]** Li S, Wei QA, Tang J, et al. 2026. *ReproRepo: Scaling Reproducibility Audits with GitHub Repository Issues.* arXiv:2606.18237. https://arxiv.org/abs/2606.18237
Cited for: the best agent setup surfacing at least one related human-reported blocker for about 90% of 1,149 papers, while possibly falling short at exact localization.

**[9]** Hu C, Zhang L, Lim Y, Wadhwani A, Peters A, Kang D. 2025. *REPRO-Bench: Can Agentic AI Systems Assess the Reproducibility of Social Science Research?* Findings of ACL 2025; arXiv:2507.18901. https://arxiv.org/abs/2507.18901
Cited for: the best of three agents reaching 21.4% accuracy at assessing the reproducibility of social science papers.

**[10]** Mohl J, Gardner-Challis N, Dubois M, et al. 2026. *Automated Transcript Analysis for Detecting Flaws in Agentic Benchmarks.* arXiv:2607.27518. https://arxiv.org/abs/2607.27518
Cited for: agent benchmarks themselves need validity checks; the paper's scanners look for issues such as ground-truth access, tool failure, guessing vulnerability and answer-format ambiguity.

**[11]** Nadgir N, Kapoor S, Liu K, et al. 2026. *Life After Benchmark Saturation: A Case Study of CORE-Bench.* arXiv:2606.26158. https://arxiv.org/abs/2606.26158
Cited for: a small randomized experiment finding a roughly 2x speedup from human-agent collaboration on reproduction tasks, likely underestimated because about one-fifth of human-only attempts hit the time limit.

## Practice guides

**[12]** Kitzes J, Turek D, Deniz F, eds. 2018. *The Practice of Reproducible Research.* University of California Press. https://www.ucpress.edu/book/9780520294752/the-practice-of-reproducible-research
Cited for: practical workflows and case studies in reproducible research. Listed as further reading; not yet read in full.

**[13]** The Turing Way Community. *The Turing Way: Guide for Reproducible Research.* https://book.the-turing-way.org/reproducible-research/reproducible-research/
Cited for: an open, community-written guide to version control, data management and reproducible computational environments. Listed as further reading.
