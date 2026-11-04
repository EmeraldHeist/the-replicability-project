# make demo: pairwise DESeq2 on the committed RSEM gene counts (24 public libraries, PRJNA1304005).
# Compares per-group DEG counts, union and shared against expected_demo.csv (identifiers/counts must match exactly).
suppressMessages(library(DESeq2))
cm <- read.csv("derived/gene_count_matrix_rsem.csv", row.names=1, check.names=FALSE)
mp <- read.delim("derived/run_sample_map.tsv", stringsAsFactors=FALSE)
mp <- mp[match(colnames(cm), mp$run),]
mp$cond <- gsub("[^A-Za-z0-9]","",sub("_","",sub("_[0-9]$","",sub("^Daphnia_","",mp$sample_name))))
groups <- c(Cd="Cd21h",Cr="Cr61h",Pb="Pb21h",Hg="Hg21h",Imi_1h="Imidacloprid1h",Tri="Triclosan1h",Imi_3h="Imidacloprid3h")
sets <- list()
for (nm in names(groups)) {
  g <- groups[[nm]]; m <- mp[mp$cond %in% c("Control1h", g),]; m$cond <- relevel(factor(m$cond), ref="Control1h")
  d <- DESeqDataSetFromMatrix(as.matrix(cm[,m$run]), data.frame(cond=m$cond, row.names=m$run), ~cond)
  d <- d[rowSums(counts(d))>=10,]; d <- suppressMessages(suppressWarnings(DESeq(d, quiet=TRUE)))
  r <- as.data.frame(results(d)); sets[[nm]] <- rownames(r)[!is.na(r$padj) & r$padj<0.05 & abs(r$log2FoldChange)>=0.585]
}
out <- data.frame(item=c(names(groups),"union","shared_by_all"),
  count=c(sapply(sets,length), length(unique(unlist(sets))), length(Reduce(intersect,sets))))
dir.create("demo_out", showWarnings=FALSE); write.csv(out, "demo_out/deg_counts.csv", row.names=FALSE)
exp <- read.csv("expected_demo.csv")
cmp <- merge(out, exp, by="item", suffixes=c("_mine","_expected")); print(cmp, row.names=FALSE)
if (!all(cmp$count_mine == cmp$count_expected)) { cat("DEMO FAIL\n"); quit(status=1) }
cat("DEMO PASS: DEG counts match the saved reference outputs exactly.\n")
