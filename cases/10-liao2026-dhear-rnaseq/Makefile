# Case 10: Liao et al. 2026 RNA-seq reproduction (Tier 1, exploratory pass)
.PHONY: demo full clean
demo:   ## runs in seconds-minutes; needs R >= 4.4 with DESeq2 1.46.0
	Rscript scripts/demo_deseq2.R

full:   ## NOT automated yet: see RUNBOOK.md (about 1.2 days of compute, ~45 GB SRA download and ~100 GB scratch)
	@echo "make full is not automated for this case. Follow RUNBOOK.md step by step." ; exit 1

clean:
	rm -rf demo_out
