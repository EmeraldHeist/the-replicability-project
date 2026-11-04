suppressMessages(library(WGCNA)); allowWGCNAThreads(6)
rp <- Sys.getenv("RP"); res <- file.path(rp,"results/liao2026")
tp <- read.csv(file.path(res,"gene_tpm_matrix_rsem.csv"), row.names=1, check.names=FALSE)
tb <- read.csv(file.path(res,"per_gene_table_pairwise_rsem.csv"), check.names=FALSE, row.names=1)
m <- rowMeans(tp); cv <- apply(tp,1,sd)/m; base <- names(m)[m>=1 & cv>=0.1 & is.finite(cv)]
pm <- c(LOC116922180="yellow",LOC116924503="red",LOC116918745="greenyellow",LOC116915419="blue",LOC116919481="black",LOC116925137="black",
 LOC116932965="turquoise",LOC116926869="turquoise",LOC123471412="turquoise",LOC116920215="turquoise",LOC116926166="turquoise",LOC116922174="turquoise")
n15 <- tb[["n_groups_DEG_1.5fold"]]; names(n15) <- rownames(tb)
sets <- list("DEG1.5x union"=names(n15)[n15>=1], "top2500 CV"=names(sort(cv[base],decreasing=TRUE))[1:2500], "all filtered genes"=base)
for (nm in names(sets)) {
  g <- intersect(sets[[nm]], rownames(tp)); g <- g[m[g]>=1 & cv[g]>=0.1 & is.finite(cv[g])]
  net <- blockwiseModules(t(log2(tp[g,]+1)), power=20, networkType="signed", TOMType="signed", minModuleSize=30, minKMEtoStay=0.3, mergeCutHeight=0.25, maxBlockSize=20000, numericLabels=TRUE, verbose=0)
  mine <- setNames(net$colors, g)[names(pm)]
  cat("\n==", nm, "(", length(g), "genes,", length(setdiff(unique(net$colors),0)), "modules )\n")
  print(data.frame(gene=names(pm), paper=unname(pm), mine=ifelse(is.na(mine),"not in input",paste0("M",mine))), row.names=FALSE)
  tq <- names(pm)[pm=="turquoise"]; mt <- mine[tq]
  pairs <- combn(tq,2); same <- apply(pairs,2,function(p) !is.na(mine[p[1]]) && !is.na(mine[p[2]]) && mine[p[1]]==mine[p[2]] && mine[p[1]]!=0)
  cat(sprintf("turquoise pairs in same module: %d/%d | black pair together: %s\n", sum(same), ncol(pairs), as.character(identical(unname(mine["LOC116919481"]),unname(mine["LOC116925137"])) && !is.na(mine["LOC116919481"]) && mine["LOC116919481"]!=0)))
  all <- combn(names(pm),2); cross <- apply(all,2,function(p) pm[p[1]]!=pm[p[2]]); same2 <- apply(all,2,function(p) !is.na(mine[p[1]]) && !is.na(mine[p[2]]) && mine[p[1]]==mine[p[2]] && mine[p[1]]!=0)
  cat(sprintf("different-paper-module pairs wrongly together: %d/%d\n", sum(same2&cross), sum(cross)))
}
