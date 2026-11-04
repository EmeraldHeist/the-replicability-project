suppressMessages(library(DESeq2))
rp <- Sys.getenv("RP"); res <- file.path(rp,"results/liao2026")
cm <- read.csv(file.path(res,"gene_count_matrix_featurecounts.csv"), row.names=1, check.names=FALSE)
mp <- read.delim(file.path(rp,"data/raw/prjna1304005_metadata/run_sample_map.tsv"), stringsAsFactors=FALSE)
mp <- mp[match(colnames(cm), mp$run),]
mp$cond <- sub("_[0-9]$","",sub("^Daphnia_","",mp$sample_name))
mp$cond <- gsub("[^A-Za-z0-9]","",sub("_","",mp$cond))
cat(table(mp$cond),"\n"); print(unique(mp$cond))
mp$cond <- relevel(factor(mp$cond), ref="Control1h")
dds <- DESeqDataSetFromMatrix(as.matrix(cm), data.frame(cond=mp$cond,row.names=mp$run), ~cond)
dds <- dds[rowSums(counts(dds))>=10,]
dds <- DESeq(dds)
cat("genes tested:", nrow(dds), "\n")
out <- list()
for (lv in setdiff(levels(mp$cond),"Control1h")) {
  r <- results(dds, contrast=c("cond",lv,"Control1h")); r <- as.data.frame(r); r$gene <- rownames(r)
  write.csv(r, file.path(res,paste0("deseq2_fc_",lv,"_vs_Control1h.csv")), row.names=FALSE)
  sig <- !is.na(r$padj) & r$padj<0.05 & abs(r$log2FoldChange)>=1
  out[[lv]] <- r$gene[sig]; cat(lv, sum(sig), "(up", sum(sig&r$log2FoldChange>0), "down", sum(sig&r$log2FoldChange<0), ")\n")
}
u <- unique(unlist(out)); cat("union:", length(u), "\n")
cat("shared by all", length(Reduce(intersect,out)), "\n")
saveRDS(vst(dds,blind=TRUE), file.path(res,"vst_fc.rds"))
v <- assay(vst(dds,blind=TRUE)); p <- prcomp(t(v[order(-apply(v,1,var))[1:500],])); 
write.csv(data.frame(run=mp$run,cond=mp$cond,PC1=p$x[,1],PC2=p$x[,2]), file.path(res,"pca_fc.csv"), row.names=FALSE)
