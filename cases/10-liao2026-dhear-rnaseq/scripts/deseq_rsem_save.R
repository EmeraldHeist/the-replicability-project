suppressMessages(library(DESeq2))
rp <- Sys.getenv("RP"); res <- file.path(rp,"results/liao2026")
cm <- read.csv(file.path(res,"gene_count_matrix_rsem.csv"), row.names=1, check.names=FALSE)
mp <- read.delim(file.path(rp,"data/raw/prjna1304005_metadata/run_sample_map.tsv"), stringsAsFactors=FALSE)
mp <- mp[match(colnames(cm), mp$run),]
mp$cond <- relevel(factor(gsub("[^A-Za-z0-9]","",sub("_","",sub("_[0-9]$","",sub("^Daphnia_","",mp$sample_name))))), ref="Control1h")
dds <- DESeqDataSetFromMatrix(as.matrix(cm), data.frame(cond=mp$cond,row.names=mp$run), ~cond)
dds <- dds[rowSums(counts(dds))>=10,]; dds <- suppressMessages(DESeq(dds))
for (g in setdiff(levels(mp$cond),"Control1h")) { r <- as.data.frame(results(dds,contrast=c("cond",g,"Control1h"))); r$gene <- rownames(r)
  write.csv(r, file.path(res,paste0("deseq2_rsem_",g,"_vs_Control1h.csv")), row.names=FALSE) }
