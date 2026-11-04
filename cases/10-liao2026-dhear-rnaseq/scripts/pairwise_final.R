suppressMessages(library(DESeq2))
rp <- Sys.getenv("RP"); res <- file.path(rp,"results/liao2026")
cm <- read.csv(file.path(res,"gene_count_matrix_rsem.csv"), row.names=1, check.names=FALSE)
mp <- read.delim(file.path(rp,"data/raw/prjna1304005_metadata/run_sample_map.tsv"), stringsAsFactors=FALSE)
mp <- mp[match(colnames(cm), mp$run),]
mp$cond <- gsub("[^A-Za-z0-9]","",sub("_","",sub("_[0-9]$","",sub("^Daphnia_","",mp$sample_name))))
for (g in c("Cd21h","Cr61h","Pb21h","Hg21h","Imidacloprid1h","Triclosan1h","Imidacloprid3h")) {
  m <- mp[mp$cond %in% c("Control1h",g),]; m$cond <- relevel(factor(m$cond), ref="Control1h")
  d <- DESeqDataSetFromMatrix(as.matrix(cm[,m$run]), data.frame(cond=m$cond,row.names=m$run), ~cond)
  d <- d[rowSums(counts(d))>=10,]; d <- suppressMessages(suppressWarnings(DESeq(d, quiet=TRUE)))
  r <- as.data.frame(results(d)); r$gene <- rownames(r)
  write.csv(r, file.path(res,paste0("deseq2_pairwise_rsem_",g,"_vs_Control1h.csv")), row.names=FALSE)
}
