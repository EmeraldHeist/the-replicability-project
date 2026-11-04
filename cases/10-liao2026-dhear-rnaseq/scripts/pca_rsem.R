# PCA of the 24 libraries: variance-stabilised RSEM gene counts, top 500 most variable genes.
# Run from the case folder. Writes derived/pca_rsem.csv (run, cond, PC1, PC2, and percent variance in the header comment of the figure script).
suppressMessages(library(DESeq2))
cm <- read.csv("derived/gene_count_matrix_rsem.csv", row.names=1, check.names=FALSE)
mp <- read.delim("derived/run_sample_map.tsv", stringsAsFactors=FALSE)
mp <- mp[match(colnames(cm), mp$run),]
mp$cond <- gsub("[^A-Za-z0-9]","",sub("_","",sub("_[0-9]$","",sub("^Daphnia_","",mp$sample_name))))
d <- DESeqDataSetFromMatrix(as.matrix(cm), data.frame(cond=factor(mp$cond), row.names=mp$run), ~cond)
d <- d[rowSums(counts(d))>=10,]
v <- vst(d, blind=TRUE)
p <- prcomp(t(assay(v)[order(apply(assay(v),1,var), decreasing=TRUE)[1:500],]))
pv <- round(100*p$sdev^2/sum(p$sdev^2),1)
out <- data.frame(run=colnames(v), cond=mp$cond, PC1=p$x[,1], PC2=p$x[,2], var_PC1=pv[1], var_PC2=pv[2])
write.csv(out, "derived/pca_rsem.csv", row.names=FALSE)
print(table(out$cond)); print(pv[1:2])
