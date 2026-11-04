suppressMessages(library(WGCNA)); allowWGCNAThreads(4)
rp <- Sys.getenv("RP"); res <- file.path(rp,"results/liao2026")
tp <- read.csv(file.path(res,"gene_tpm_matrix.csv"), row.names=1, check.names=FALSE)
G <- c("Cd21h","Cr61h","Pb21h","Hg21h","Imidacloprid1h","Triclosan1h","Imidacloprid3h")
deg <- list()
for (thr in c(0.585,1)) {
  u <- c()
  for (g in G) { r <- read.csv(file.path(res,paste0("deseq2_fc_",g,"_vs_Control1h.csv")))
    u <- union(u, r$gene[!is.na(r$padj) & r$padj<0.05 & abs(r$log2FoldChange)>=thr]) }
  deg[[as.character(thr)]] <- u }
m <- rowMeans(tp); cv <- apply(tp,1,sd)/m
run <- function(lab, genes, tf){
  genes <- intersect(genes, rownames(tp)); dat <- t(tf(tp[genes,]))
  net <- blockwiseModules(dat, power=20, networkType="signed", TOMType="signed", minModuleSize=30,
    minKMEtoStay=0.3, mergeCutHeight=0.25, maxBlockSize=20000, numericLabels=TRUE, verbose=0)
  cat(lab, "| genes", ncol(dat), "| modules", length(setdiff(unique(net$colors),0)), "| grey", sum(net$colors==0), "\n")
}
for (thr in names(deg)) {
  d <- deg[[thr]]; ok <- d[m[d]>=1 & cv[d]>=0.1 & is.finite(cv[d])]
  run(paste0("DEG(lfc",thr,") + mean>=1,cv>=.1, log2"), ok, function(x) log2(x+1))
  run(paste0("DEG(lfc",thr,") + mean>=1,cv>=.1, raw"), ok, function(x) x)
  run(paste0("DEG(lfc",thr,") no TPM/CV filter, log2"), d, function(x) log2(x+1))
}
