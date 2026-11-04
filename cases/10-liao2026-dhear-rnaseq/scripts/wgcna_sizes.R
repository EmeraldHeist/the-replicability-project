suppressMessages(library(WGCNA)); allowWGCNAThreads(4)
rp <- Sys.getenv("RP"); res <- file.path(rp,"results/liao2026")
tp <- read.csv(file.path(res,"gene_tpm_matrix_rsem.csv"), row.names=1, check.names=FALSE)
tb <- read.csv(file.path(res,"per_gene_table_pairwise_rsem.csv"), check.names=FALSE)
deg <- tb$gene_id[tb[["n_groups_DEG_1.5fold"]]>0]
m <- rowMeans(tp); cv <- apply(tp,1,sd)/m
show <- function(lab, genes){ genes <- intersect(genes, rownames(tp)); genes <- genes[m[genes]>=1 & cv[genes]>=0.1 & is.finite(cv[genes])]
  net <- blockwiseModules(t(log2(tp[genes,]+1)), power=20, networkType="signed", TOMType="signed", minModuleSize=30, minKMEtoStay=0.3, mergeCutHeight=0.25, maxBlockSize=20000, numericLabels=TRUE, verbose=0)
  s <- sort(table(net$colors[net$colors!=0]), decreasing=TRUE)
  cat(lab, "| input", length(genes), "| modules", length(s), "| in modules", sum(s), "| grey", sum(net$colors==0), "\n  sizes:", paste(s,collapse=" "), "\n") }
show("pairwise-RSEM DEG union (1.5x)", deg)
show("all genes", rownames(tp))
