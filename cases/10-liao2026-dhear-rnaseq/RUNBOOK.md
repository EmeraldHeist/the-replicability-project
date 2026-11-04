# Runbook: Case 10 (documented manual sequence, `make full` is not automated)

Scripts in `scripts/` were run interactively from a scratch directory. They use environment variables instead of paths:
`RP` (project folder with `data/`, `logs/`, `work/`, `results/`), `SCRATCH` (scripts and temp files), `PROJECT`, `CONDA_BASE`. They were saved as run, so paths must be adapted before reuse. Only `scripts/demo_deseq2.R` was re-run from this folder.

Environments (versions in `environment/`): `daphnia_quant` (StringTie 2.2.3, subread 2.1.1), `daphnia_rsem` (RSEM 1.3.3, bowtie2 2.5.5), base tools (fastp 1.0.1, HISAT2 2.2.1, samtools), R 4.4.2 with DESeq2 1.46.0 and WGCNA 1.74.

1. **Reads.** `prefetch` the 24 runs listed in `logs/prjna1304005_runs.txt`; check with `vdb-validate` (`scripts/validate_sra.sh`).
2. **Reference.** From NCBI RefSeq GCF_020631705.1 download genomic.fna.gz, genomic.gtf.gz, rna.fna.gz and md5checksums.txt; verify MD5. Make the StringTie/RSEM GTF by dropping rows whose feature is `gene` (they carry an empty `transcript_id`): `awk -F'\t' '/^#/ || $3!="gene"'`.
3. **Index.** `hisat2-build` on the genomic FASTA (use a path without spaces; the HISAT2 wrapper breaks on spaces).
4. **Align.** `scripts/batch.sh`: `fasterq-dump`, fastp (`-q 20 -u 10 -n 5 -l 20 --cut_tail --cut_tail_mean_quality 20 --detect_adapter_for_pe`), HISAT2 with no strand flag, `samtools sort`. (The StringTie step inside it failed on the original GTF; use step 5.)
5. **StringTie.** `scripts/st_all.sh` with the filtered GTF (`-e -B`).
6. **featureCounts.** `scripts/fc_all.sh` (`-p --countReadPairs -B -C -s 0 -t exon -g gene_id`).
7. **RSEM.** `scripts/rsem_all.sh` (rsem-prepare-reference with bowtie2, then per library fasterq-dump, fastp, `rsem-calculate-expression --paired-end --bowtie2 --strandedness none`). About 40 to 55 minutes per library when the machine stays awake.
8. **Matrices.** `scripts/build_rsem_matrices.py`; for StringTie counts `scripts/agg.py` (cov x exon length / 150; `prepDE.py` failed with a KeyError).
9. **DESeq2.** Primary: `scripts/pairwise_final.R` (pairwise, prefilter rowSums >= 10). Alternatives and scans: `deseq.R`, `deseq_fc.R`, `deseq_pf.R`, `scan.R`, `padj_test.R`, `padj_test2.R`.
10. **WGCNA.** `wgcna.R`, `wgcna_var.R`, `wgcna_rsem.R`, `wgcna_deg.R`, `wgcna_sizes.R`, `wgcna_search.R`, `member.R`.
11. **SI tables.** `scripts/parse_tableS4_S5.py` for Table S4; Table S5 and Figures S12 to S14 were transcribed by hand (`derived/`).
12. **Figures.** `Rscript scripts/pca_rsem.R` then `python3 -I scripts/make_figures.py` (from the case folder; needs matplotlib and pandas). Writes `figures/*.png` and `derived/pca_rsem.csv`, `derived/tableS4_vs_ours_log2FC.csv`.
