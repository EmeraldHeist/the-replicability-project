suppressMessages(library(WGCNA)); allowWGCNAThreads(8)
rp <- Sys.getenv("RP"); res <- file.path(rp,"results/liao2026")
tp <- read.csv(file.path(res,"gene_tpm_matrix_rsem.csv"), row.names=1, check.names=FALSE)
m <- rowMeans(tp); cv <- apply(tp,1,sd)/m
run <- function(lab, keep, tf){
  dat <- t(tf(tp[keep,]))
  net <- blockwiseModules(dat, power=20, networkType="signed", TOMType="signed", minModuleSize=30,
    minKMEtoStay=0.3, mergeCutHeight=0.25, maxBlockSize=20000, numericLabels=TRUE, verbose=0)
  cat(lab, "| genes", ncol(dat), "| modules", length(setdiff(unique(net$colors),0)), "| grey", sum(net$colors==0), "\n")
}
run("mean>=1,cv>=.1, log2", m>=1&cv>=0.1, function(x) log2(x+1))
run("mean>=1,cv>=.1, raw TPM", m>=1&cv>=0.1, function(x) x)
run("all samples>=1,cv>=.1, log2", apply(tp,1,min)>=1&cv>=0.1, function(x) log2(x+1))
run("all samples>=1,cv>=.1, raw", apply(tp,1,min)>=1&cv>=0.1, function(x) x)
