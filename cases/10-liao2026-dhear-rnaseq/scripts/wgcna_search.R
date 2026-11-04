suppressMessages(library(WGCNA)); allowWGCNAThreads(6)
rp <- Sys.getenv("RP"); res <- file.path(rp,"results/liao2026")
tp <- read.csv(file.path(res,"gene_tpm_matrix_rsem.csv"), row.names=1, check.names=FALSE)
tb <- read.csv(file.path(res,"per_gene_table_pairwise_rsem.csv"), check.names=FALSE, row.names=1)
m <- rowMeans(tp); cv <- apply(tp,1,sd)/m; mn <- apply(tp,1,min)
base <- names(m)[m>=1 & cv>=0.1 & is.finite(cv)]
n15 <- tb[["n_groups_DEG_1.5fold"]]; n2 <- tb[["n_groups_DEG_2fold"]]; names(n15) <- names(n2) <- rownames(tb)
cands <- list(
 "DEG1.5x >=1 grp"  = names(n15)[n15>=1],
 "DEG1.5x >=2 grps" = names(n15)[n15>=2],
 "DEG1.5x >=3 grps" = names(n15)[n15>=3],
 "DEG2x >=1 grp"    = names(n2)[n2>=1],
 "DEG2x >=2 grps"   = names(n2)[n2>=2],
 "DEG1.5x & cv>=0.3"= intersect(names(n15)[n15>=1], names(cv)[cv>=0.3 & is.finite(cv)]),
 "DEG1.5x & all-samples TPM>=1" = intersect(names(n15)[n15>=1], names(mn)[mn>=1]),
 "DEG1.5x & mean TPM>=5" = intersect(names(n15)[n15>=1], names(m)[m>=5]),
 "top2500 CV"  = names(sort(cv[base],decreasing=TRUE))[1:2500],
 "top3500 CV"  = names(sort(cv[base],decreasing=TRUE))[1:3500],
 "top5000 CV"  = names(sort(cv[base],decreasing=TRUE))[1:5000],
 "top3500 var(log2)" = {v <- apply(log2(tp[base,]+1),1,var); names(sort(v,decreasing=TRUE))[1:3500]},
 "top5000 var(log2)" = {v <- apply(log2(tp[base,]+1),1,var); names(sort(v,decreasing=TRUE))[1:5000]}
)
tgt <- c(596,247,228,218,193,179,152,115,107,99,30); out <- list()
for (nm in names(cands)) {
  g <- intersect(cands[[nm]], rownames(tp)); g <- g[m[g]>=1 & cv[g]>=0.1 & is.finite(cv[g])]
  net <- blockwiseModules(t(log2(tp[g,]+1)), power=20, networkType="signed", TOMType="signed", minModuleSize=30, minKMEtoStay=0.3, mergeCutHeight=0.25, maxBlockSize=20000, numericLabels=TRUE, verbose=0)
  s <- sort(as.numeric(table(net$colors[net$colors!=0])), decreasing=TRUE)
  cat(sprintf("%-30s input %5d | modules %2d | in modules %5d | top sizes %s\n", nm, length(g), length(s), sum(s), paste(head(s,6),collapse=" ")))
  out[[nm]] <- data.frame(subset=nm,input=length(g),modules=length(s),in_modules=sum(s),sizes=paste(s,collapse=" "))
}
write.csv(do.call(rbind,out), file.path(res,"wgcna_subset_search.csv"), row.names=FALSE)
cat("TARGET (paper): modules 11 | in modules 2164 | sizes", paste(tgt,collapse=" "), "\n")
