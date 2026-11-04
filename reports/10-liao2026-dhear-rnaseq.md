# Case report: Liao et al. 2026, RNA-seq reproduction (D-HEART paper)

> **Draft.** Sections marked **TO SET** or **TO FILL** are still empty. Nothing here has been shared with the authors yet, except the two emails listed at the end. Case plan: [cases/10-liao2026-dhear-rnaseq.md](../cases/10-liao2026-dhear-rnaseq.md). Files: [cases/10-liao2026-dhear-rnaseq/](../cases/10-liao2026-dhear-rnaseq/).

## The paper
Liao et al., "Multidimensional Cardiac Phenotyping of *Daphnia magna* Enables One-Hour Effect-Based Screening of Aquatic Toxicity", *Environ. Sci. Technol.* 2026, doi:10.1021/acs.est.6c09772, PMID 42863106.

The paper builds a heartbeat screening tool for water fleas (*Daphnia magna*). It also sequenced RNA from animals exposed to six chemicals for 1 hour. This case redoes only the RNA part.

- **Record check (2026-11-04):** Crossref lists the paper (issued 2026-10-01) with no correction or retraction records. PubMed lists one record. The Retraction Watch database was not checked.
- **Public data:** the raw RNA reads (BioProject PRJNA1304005, 24 runs).
- **Not public:** the heartbeat measurements (116 values per animal), the videos, the DESeq2 results, the count table and the gene-group (WGCNA module) membership.
- **Authors' code:** https://github.com/LiaoZitong/Heartbeat-of-Daphnia-magna (MIT license). It has video scripts and a small two-record example of the Heartbeat Toxicity Index. It has no RNA-seq code.
- **Why this paper:** I chose to reproduce its RNA-seq part as far as possible from the public data.

## Claims attempted
**TO SET.** I have not yet chosen the claims. These candidates come from the paper's text. I will confirm, replace or drop them:
1. Genes that changed per group: Cd 723, Cr 677, Pb 953, Hg 1,284, imidacloprid 1 h 601, triclosan 1,229, imidacloprid 3 h 1,634 (Fig. S6a).
2. Across the seven groups, 4,605 genes changed in total and 28 changed in all of them.
3. WGCNA finds 11 gene groups linked to treatment (2,164 genes in total, SI Table S5).
4. The gene groups correlate with the heartbeat measurements (Fig. 4c, Table S5).
5. The authors' Heartbeat Toxicity Index example runs and gives its expected results.

## How ready the paper was
No estimate was made before starting, so this one is retrospective: **a lot of groundwork needed.**
- Exact data accession: yes.
- Code available and runnable: partly (heartbeat code only).
- Fits on a laptop: tight (free disk had to be raised from 26 GB).
- Tool versions, cutoffs and steps stated: partly. Tool versions are stated. The cutoff for a "changed gene" is given one way in the text and another in Table S4. The paper does not say which counts went into DESeq2, which annotation version was used, how genes were pre-filtered, which genes went into WGCNA, or how the models were set up.
- Reported numbers recomputable from the supplement alone: no.
- Text and tables agree: no (see below).

Effort: about 5 days elapsed (2026-10-30 to 2026-11-04), mostly computer time. That covered 24 samples through fastp, HISAT2, StringTie, featureCounts and RSEM, and 20 reconstruction-log entries below. Hands-on hours were not recorded.

## Success criteria (to be written and justified before running)
**They were not set before running.** This is the main departure from the protocol. I worked step by step with Claude, an AI assistant. Claude made most of the technical choices as the work went on, and no pass/fail rules were committed first. In particular, Claude picked the fold-change cutoff of 0.585 on the log2 scale (1.5-fold) after the paper's totals had been seen. Committed in: not applicable.

| Tier | Criterion | Justification |
|---|---|---|
| 1 | **TO SET** | |
| 2 | **TO SET** | |
| 3 | not attempted | |

The protocol defaults (counts and IDs match exactly; numbers within 5% or the paper's interval; same ranking; same direction and significance) are starting points, not justifications. With the exact-match default for counts, only the triclosan total matches.

**Changes to the criteria:** none, because there were no original criteria. Any result that depends on the after-the-fact cutoff can be rated "Reproduced with documented differences" at best.

## Results
These are observed values compared with the paper. No pass/fail is applied, because no criteria exist.

"Primary" means: each group compared with the control on its own (3 samples vs 3 samples) in DESeq2, using RSEM gene counts. Genes with fewer than 10 total counts were dropped. A gene counts as changed if FDR < 0.05 and the change is at least 1.5-fold. You can reproduce this with `make demo`.

| Group | Paper | Ours (primary) | Ratio | Ours at the stated 2-fold cutoff |
|---|---|---|---|---|
| Cd | 723 | 707 | 0.98 | 175 |
| Cr | 677 | 676 | 1.00 | 192 |
| Pb | 953 | 983 | 1.03 | 294 |
| Hg | 1,284 | 1,271 | 0.99 | 380 |
| Imidacloprid 1 h | 601 | 577 | 0.96 | 103 |
| Triclosan | 1,229 | 1,229 | 1.00 | 358 |
| Imidacloprid 3 h | 1,634 | 1,617 | 0.99 | 446 |
| All groups combined | 4,605 | 3,805 | 0.83 | 1,159 |
| Changed in all groups | 28 | 29 | | 7 |

Other ways of counting (one model on all 24 samples, 1.5-fold):
- StringTie, per group: 877, 844, 1,172, 1,454, 719, 1,367, 1,827 (combined total not computed).
- featureCounts: 3,922 combined, 29 in all groups.
- RSEM genes: 4,053 combined, 31 in all groups.
- RSEM transcript IDs: 5,680 combined, 55 in all groups.

The settings scans are in `derived/deseq2_settings_scan.csv`. At the stated 2-fold cutoff, every counting method and model gives only about 17 to 44% of the paper's per-group numbers.

| Claim | Tier 1 (same data, same tools) | Tier 2 (different tools) | Tier 3 | Outcome (provisional) |
|---|---|---|---|---|
| 1 Genes changed per group | Within 0 to 4% for all 7 groups at 1.5-fold (largest gaps: Pb +3%, imidacloprid 1 h −4%). About 17 to 44% at the stated 2-fold. | featureCounts and StringTie give lower counts. RSEM gene counts match best. | not attempted | At the stated cutoff: Not yet reproduced: details still needed. At 1.5-fold (chosen after the fact): Reproduced with documented differences, at best. |
| 2 Combined and shared | Combined 3,805 vs 4,605. Shared 29 vs 28. | Combined 3,597 to 4,053 across sources and settings. The two lowest (3,597 and 3,694) come from `padj_test2.R`, whose printed output was not saved. Transcript level gives 5,680. | not attempted | Not yet reproduced: details still needed (combined total). |
| 3 WGCNA: 11 groups | 9 to 32 groups across 14 ways of setting up the input. None gives 11 groups holding 2,164 genes. (The 9-to-12-group results came from inputs of only 1,129 to 1,309 genes, fewer than the paper's 2,164.) | 13 candidate gene subsets tried. None matches. | not attempted | Not yet reproduced: details still needed. |
| 4 Gene groups vs heartbeat | Cannot be computed without the heartbeat averages per condition. | | | Could not attempt: data unavailable. |
| 5 Authors' example | The authors' check script passes in a clean environment. | | | Reproduced. This only shows their software runs on their own two records. It is not a result from the paper. |

**Gene-by-gene check against SI Table S4** (31 results from 12 genes, `derived/tableS4_parsed.csv`):
- With RSEM counts, our size of change matches the paper's for 26 of 31 rows. The average gap is 0.022 (log2 scale) and the correlation is 0.9997.
- The direction (up or down) matches in 29 of 31 rows.
- Five rows from three genes are off by 0.4 to 0.8 (LOC116922180 and LOC116926869 in Hg, and LOC116922174).
- Our significance values (padj) follow the same pattern as the paper's (correlation about 1.000 in the best setup). Ours are smaller by a median of about 0.9 orders of magnitude (about 8 times).

## Reconstruction log
Each row is a detail the paper did not give clearly, and what was done about it. "I" means a decision or action of mine. "Claude" means a choice made by the AI assistant.

| # | Detail needed | Where looked | What was done | Did it change the result? |
|---|---|---|---|---|
| 1 | RNA-seq accession and sample list | Article, NCBI BioProject and BioSample | PRJNA1304005, 24 runs. Run-to-condition list taken from BioSample (`derived/run_sample_map.tsv`). | No |
| 2 | Annotation version | SI Note S4 | The SI names only the genome (ASM2063170v1.1). Claude used the NCBI RefSeq GTF and FASTA for GCF_020631705.1. The Table S4 gene IDs (`gene-LOC...`) fit it. The release number is a gap. | Possibly (3 genes differ) |
| 3 | Cutoff for a changed gene | SI Note S4 vs SI Table S4 | Note S4 says at least 2-fold. Table S4 lists significant genes with changes of only 1.5 to 2-fold. Claude used 1.5-fold, picked after seeing the paper's totals. I asked the authors. | Yes (counts change 3 to 4 times) |
| 4 | Which counts go into DESeq2 | SI (silent; RSEM is named only for TPM) | Compared StringTie, featureCounts and RSEM. RSEM gene counts match the Table S4 changes best. | Yes |
| 5 | One joint model or separate comparisons | Table S4 significance values | Separate comparisons (control vs one group) match the paper's pattern best (correlation about 1.000). | Yes (p-values) |
| 6 | Strand setting | SI vs the data | The SI mentions a stranded setting (`--rna-strandness RF`). Two libraries look unstranded (77.9% and 71.6% of reads assigned as unstranded, vs 37 to 42% as stranded). Claude counted all libraries as unstranded. | Not tested |
| 7 | Gene pre-filter | SI (silent) | Dropped genes with fewer than 10 total counts. Removing the filter, or turning off DESeq2's own filtering, moves the combined total only within 3,722 to 3,953 (featureCounts, joint model). | Little |
| 8 | How the 4,605 combined total was counted | SI | Unresolved. I asked the authors. | n/a |
| 9 | WGCNA input genes, TPM/CV filter, transform | SI Note S11, Table S5 | Unresolved. Claude tried 14 setups and 13 gene subsets. Table S5's 2,164 module genes rule out the full filtered set (which gives about 9,700 genes in modules). | n/a |
| 10 | Tool versions | SI vs the setup used | StringTie 2.2.3 (2.2.1 has no Apple-silicon build). fastp 1.0.1 (SI says 0.23.4; Claude noticed late and did not test it). DESeq2 1.46.0 (SI says 1.42.0). HISAT2 2.2.1 and RSEM 1.3.3 match. | Not tested |
| 11 | StringTie gene file | A run failure | The NCBI `gene` rows have an empty `transcript_id`. Claude removed them. | No (fixed an error) |
| 12 | StringTie gene counts | `prepDE.py` crashed with a KeyError | Claude used its own calculation (coverage × exon length ÷ 150). | Minor (RSEM and featureCounts were used for DESeq2) |
| 13 | HISAT2 failing on a folder name with spaces | A run failure | Used a symlink with no spaces. | No |
| 14 | `mapfile` missing in the Mac's bash 3.2 | A run failure | Used a `while read` loop. | No |
| 15 | Slow runs on battery | Timings | Ran on AC power. RSEM time per sample was measured only while the laptop was awake. | No |
| 16 | Figure S12 vs Table S5 and Fig. S14 | SI images | S12's terms for four gene groups (red, turquoise, brown, black) do not match S5 or S14. Seven groups do match. Claude may have misread a column. Unresolved. | None |
| 17 | Names of the article and SI files | My saved files | The file saved as the SI was the main article. The real SI was a second file. | No |
| 18 | Heartbeat data | Paper, GitHub | Not public, so claim 4 was not attempted. | n/a |
| 19 | What the authors' code covers | GitHub | Video scripts and a heartbeat example only. | n/a |
| 20 | Reference file integrity | NCBI | MD5 checked against `md5checksums.txt`. SRA files checked with `vdb-validate`. GitHub model files checked by LFS pointer ID. | No |

## Where the results differ, and the likely explanation
- **Genes changed per group.** The totals matched the paper's only after Claude used a 1.5-fold cutoff, RSEM counts and separate comparisons. At the 2-fold cutoff in Note S4, the numbers are about 17 to 44% of the paper's. Table S4 suggests the authors used a looser cutoff. This is Claude's inference from the paper's own table, not a confirmed reason. Claude also picked the cutoff after seeing the paper's totals.
- **Combined total (3,805 vs 4,605).** Unexplained. Our per-group counts match, so the paper's per-group lists must overlap less than ours do. Counting transcript IDs overshoots (5,680), so ID counting does not explain it.
- **Three genes in Table S4 do not match.** Possibly a different annotation version, or differences in how reads were assigned.
- **WGCNA.** Claude could not reach 11 groups or 2,164 genes. The paper does not describe which genes it fed in.
- **Significance values.** Ours are about 8 times smaller. Not resolved.

## What Claude checked first
- Three counting tools (StringTie, featureCounts, RSEM) on the same reads, compared on Table S4 values.
- 40 DESeq2 settings (cutoff, DESeq2's own filtering, Cook's cutoff, `lfcThreshold`, raw p-values), scored against the paper's per-group counts and combined total.
- One joint model vs separate comparisons; pre-filter on vs off; multiple-testing correction over all genes.
- Sample sizes, alignment rates (HISAT2 87 to 92% where tabulated; RSEM with bowtie2 81.7% on the pilot sample), and whether replicates cluster together in a PCA.
- 14 WGCNA input setups and 13 gene subsets. Claude also checked whether genes the paper puts in the same group end up together in the reanalysis.
- The heartbeat link was not attempted.

## AI use
- **Model:** I used Claude Sonnet 5.5 (`claude-sonnet-5-5`) in Claude Code. One long session (2026-10-30 to 2026-11-04) with a context reset in the middle. Claude also drafted this report from the session worklog. The full transcript is kept outside the repo because it contains personal data. I can share it on request.
- **My prompts, in short:** find the paper; download the RNA-seq data and the GitHub code and models; check disk space and move a 95 GB annotation file to Google Drive, then delete it locally; find the metadata and check for processed counts; draft and send an email to the authors; read the SI; write a quantification plan; install StringTie and RSEM and run all 24 samples; run DESeq2; run WGCNA; compare with the paper; check the SI again; look up the Majorbio Cloud platform; test the DESeq2 pre-filter and padj; build per-gene tables; extract SI Table S5 and Figures S12 to S14; run the worked example; send a follow-up email; assemble this case.
- **Changes I made by hand:** **TO FILL.**

## Instructions given to Claude
I gave no written instructions first, which departs from the protocol. Claude worked from the paper, the SI and my short prompts. The reconstruction log above lists the gaps. The register below lists every assumption and where it came from.

### Assumptions register
Source codes: **P** = paper text, **SI** = supplement, **R** = authors' repository, **D** = public database record, **A** = an assumption or choice made by Claude during the work (not stated by the authors). "Tested?" says whether Claude checked it against anything.

| # | Assumption | Source | Tested? | What it could affect |
|---|---|---|---|---|
| | **Data and reference** | | | |
| 1 | The 24 runs in PRJNA1304005 are the libraries in the paper (8 conditions × 3 pooled samples), and the BioSample names (for example `Daphnia_Imidacloprid_3h_2`) give the right condition and replicate. | P, D | Partly: 3 samples per condition, and replicates cluster in the PCA | Everything |
| 2 | The authors' reference is NCBI RefSeq GCF_020631705.1 (ASM2063170v1.1), and today's GTF and FASTA from that accession match the version they used. (The SI gives no release.) | SI (genome), A (release) | Partly: Table S4 gene IDs fit; 3 genes disagree | Gene models, 3 outlier genes |
| 3 | Dropping the `gene` rows (empty `transcript_id`) from the GTF changes nothing in the counts. | A | No | StringTie and RSEM counts |
| 4 | Reads converted from SRA with `fasterq-dump` are the same reads the authors analysed. | A | No | Counts |
| | **Trimming and alignment** | | | |
| 5 | The SI's trimming text maps onto these fastp options: `-q 20 -u 10 -n 5 -l 20 --cut_tail --cut_tail_mean_quality 20 --detect_adapter_for_pe`. In particular, "exclude reads with more than 10% N bases" became `-n 5` (a count of 5, not 10%), and adapters were detected automatically. | SI (text), A (options) | No | Reads kept after trimming |
| 6 | fastp 1.0.1 behaves like the stated 0.23.4. | A | No | Trimming |
| 7 | HISAT2 2.2.1 with default settings. Claude left out the strand option because two samples looked unstranded. | SI (defaults), A (strand choice) | Two of 24 samples only | Alignment and counts |
| 8 | The "unstranded" finding from SRR34937006 and SRR34936983 holds for all 24 samples. | A | No (2 of 24) | All counts |
| | **Counting** | | | |
| 9 | DESeq2 was run on RSEM expected counts rounded to whole numbers. | A (inferred from Table S4) | Partly: size of change matches for 26 of 31 Table S4 rows | Which genes count as changed |
| 10 | RSEM was run from the reads with bowtie2 (`--strandedness none`), not from the HISAT2 alignments. The SI does not say which aligner RSEM used. | A | No | RSEM counts and TPM |
| 11 | StringTie 2.2.3 matches 2.2.1. Gene counts are coverage × exon length ÷ 150 (the `prepDE.py` default read length). | A | No | StringTie results only |
| 12 | featureCounts options: `-p --countReadPairs -B -C -s 0`, exon, `gene_id`. | A | Compared with RSEM and StringTie | featureCounts results only |
| | **Differential expression** | | | |
| 13 | DESeq2 compared each group with the control separately (3 vs 3 samples), not in one joint model. | A (inferred from Table S4 padj) | Yes: padj pattern correlates about 1.000 | p-values, counts of changed genes |
| 14 | Default Wald test, median-of-ratios size factors, Benjamini-Hochberg correction, DESeq2's own filtering on, and a pre-filter of at least 10 total counts. | A | The pre-filter and own filtering were varied: little effect on the combined total | Counts of changed genes |
| 15 | A gene counts as changed if FDR < 0.05 and the change is at least 1.5-fold (log2 ≥ 0.585), not the stated 2-fold. | A (after the fact, supported by SI Table S4) | Fitted to the paper's totals | Counts change 3 to 4 times |
| 16 | The only control available is Control 1 h. Imidacloprid 3 h was compared with it, because the paper does not mention a 3 h control. | D, A | No | Imidacloprid 3 h results |
| 17 | The sign of the change is exposure over control, as in Table S4 ("Imi_1h/Control"). | SI | Yes: signs agree in 29 of 31 rows | Direction of change |
| | **WGCNA** | | | |
| 18 | WGCNA ran on TPM (StringTie or RSEM) from all 24 samples, either as log2(TPM+1) or raw, after removing genes with mean TPM below 1 or CV below 0.1. (The SI does not say whether the mean or per-sample values were used, or whether logs were taken.) | SI (filter), A (reading) | 14 setups tried; none gives 11 groups | Number of groups |
| 19 | Signed network and signed TOM, power 20, minModuleSize 30, minKMEtoStay 0.3, mergeCutHeight 0.25, Pearson correlation, no outlier removal. Grey (unassigned) genes are left out of group counts and sizes. | SI (settings), A (the rest) | No | Gene groups |
| 20 | The network input was a subset of genes. It cannot be the whole filtered set, because Table S5's groups hold only 2,164 genes. | SI Table S5, A | 13 subsets tried; none matches | Gene groups |
| | **SI tables and figures** | | | |
| 21 | Table S4 values pulled from the PDF text are correct. (Wrapped numbers and exponents were re-joined by pattern.) | A | Spot-checked | Table S4 comparison |
| 22 | Table S5 and Figures S12 to S14 were typed in from text and images by Claude (not double-checked by a second reader). The group-to-term match in S12 and S13 is by dot column, and the rich factors are approximate. | A | No second reader | Gene-group comparison |
| | **Environment and code** | | | |
| 23 | The conda builds for Apple silicon (osx-arm64) equal the authors' tool builds, and results do not depend on the operating system. | A | No | Everything |
| 24 | The authors' example is safe to run. Its pickle files were loaded in a separate environment after a partial scan, with Python 3.11.18 and the repository's `requirements.txt`. | R, A | Output matched `expected_results.csv` | Software check only |
| | **Process** | | | |
| 25 | The candidate claims and all the number choices above were made by Claude during the work, not set by me beforehand. | n/a | n/a | The whole case |

## AI mode per tier
| Tier | AI-led, paired or by hand | Tool and model | Notes |
|---|---|---|---|
| 1 | AI-led, with my short prompts at checkpoints | Claude Code, Sonnet 5.5 | No criteria or instructions set beforehand |
| 2 | AI-led (exploratory comparison of counting tools) | same | |
| 3 | not attempted | | |

## What the AI did, what I checked, and what was corrected
Claude Code ran every command and wrote all the scripts. Mistakes and fixes:
- The first batch stopped at once (`mapfile` is missing in the Mac's bash 3.2). The first StringTie run failed on the GTF `gene` rows. `prepDE.py` failed. HISAT2 failed on a path with spaces. All were fixed.
- Claude first recorded fastp as 0.23.4 in the manifest, although 1.0.1 was installed. This was found and corrected on 2026-11-04.
- Claude estimated RSEM would take about 4 days after one sample took 413 minutes. Most of that was the laptop sleeping. The real time was about 45 minutes per sample.
- Claude's safety check of the authors' model files was partial (the first 424 opcodes per file). The files match the repository's checksums and were run in a separate environment.
- **What I checked myself:** **TO FILL.**

## Skills used or learned
From the README skills list, this case needed:
1. Environment management (three conda environments; no lockfile or container).
2. Workflow (bash scripts; no workflow manager).
3. Data management (accessions, checksums, manifest).
5. Statistics (joint vs separate DESeq2 models, filters, tolerances).
6. Domain knowledge (strand setting, RSEM vs StringTie, gene-ID schemes).
7. Reading papers closely (Table S4 vs the text, Fig. S12 vs Table S5).
8. Using several tools (R, Python, bash; three counting tools).
9. Checking AI work.
10. Writing and communication (emails to the authors).
11. Awareness of computing limits (disk space, laptop sleep).

Where I was strong and where I had to learn: **TO FILL.**

## Environment
- Environment files: `environment/daphnia_quant.yml`, `daphnia_rsem.yml`, `daphnia_hti.yml`, `base_tools.txt`, `R_sessionInfo.txt`. They record versions only. There is no lockfile or container.
- Randomness: the DESeq2 and WGCNA runs are deterministic.
- Checksums: SRA files checked with `vdb-validate`; reference files by NCBI MD5; GitHub model files by LFS pointer ID; derived tables in `derived/SHA256SUMS`.
- Dates: reads and code downloaded 2026-10-31; counting done 2026-11-02 to 2026-11-04.

## Baseline and refactoring
No git tag yet. The refactoring decision is not made. The scripts are one-off and depend on local paths (see `RUNBOOK.md`), and the protocol says to refactor only after the outcome is recorded. Reference outputs are in `derived/` with `SHA256SUMS`. `expected_demo.csv` is the baseline for the demo.

## What I learned
**TO FILL.** Points from the worklog that I can keep or drop:
- A methods section can state a cutoff that its own tables contradict.
- Matching gene-level values in a table is a sharper test than matching totals.
- A cutoff picked after seeing the target is a fit, not a finding.

## Limitations
- Exploratory pass: no claims, criteria or instructions set beforehand.
- The 1.5-fold cutoff, RSEM counts and separate comparisons are inferences fitted to the paper's numbers.
- Still unresolved: the annotation version, the DESeq2 pre-filter, the WGCNA input genes and how the combined total was counted.
- Claude read Table S5 and Figures S12 to S14 from text and images. Values are approximate, and some group assignments may be off by a column.
- Three tool versions differ from the SI (fastp, StringTie, DESeq2).
- The heartbeat side could not be attempted.

## Contact with the authors
- 2026-10-31: asked for the per-animal heartbeat data (116 values) and the 48 h immobilization targets (Gmail message 1a192786cb79c534).
- 2026-11-04: follow-up with six questions (cutoff, DESeq2 setup, how the combined total was counted, annotation version, WGCNA input genes, strand setting) and a repeat of the data request (message 1a1a788ec840ee3e).
- No reply as of 2026-11-04.
- **Not yet shared:** this report, the Table S4 comparison, and the Figure S12 vs Table S5 question. The protocol says to share notes and invite correction before publishing a difference, where practical.
