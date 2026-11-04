suppressMessages(library(DESeq2))
rp <- Sys.getenv("RP"); res <- file.path(rp,"results/liao2026")
cm <- read.csv(file.path(res,"gene_count_matrix_featurecounts.csv"), row.names=1, check.names=FALSE)
mp <- read.delim(file.path(rp,"data/raw/prjna1304005_metadata/run_sample_map.tsv"), stringsAsFactors=FALSE)
mp <- mp[match(colnames(cm), mp$run),]
mp$cond <- gsub("[^A-Za-z0-9]","",sub("_","",sub("_[0-9]$","",sub("^Daphnia_","",mp$sample_name))))
mp$cond <- relevel(factor(mp$cond), ref="Control1h")
G <- c("Cd21h","Cr61h","Pb21h","Hg21h","Imidacloprid1h","Triclosan1h","Imidacloprid3h")
paper <- c(723,677,953,1284,601,1229,1634)
go <- function(lab, minsum, indep, lfc=0.585){
  dds <- DESeqDataSetFromMatrix(as.matrix(cm), data.frame(cond=mp$cond,row.names=mp$run), ~cond)
  if (minsum>0) dds <- dds[rowSums(counts(dds))>=minsum,]
  dds <- suppressMessages(DESeq(dds)); out <- list(); n <- c()
  for (g in G) { r <- as.data.frame(results(dds, contrast=c("cond",g,"Control1h"), independentFiltering=indep))
    s <- !is.na(r$padj)&r$padj<0.05&abs(r$log2FoldChange)>=lfc; out[[g]] <- rownames(r)[s]; n <- c(n,sum(s)) }
  cat(sprintf("%-34s tested %5d | %s | union %d shared %d\n", lab, nrow(dds), paste(n,collapse=" "), length(unique(unlist(out))), length(Reduce(intersect,out))))
}
cat("paper                              ", paste(paper,collapse=" "), "| union 4605 shared 28\n")
go("prefilter>=10, indep ON (current)", 10, TRUE)
go("no prefilter, indep ON", 0, TRUE)
go("no prefilter, indep OFF", 0, FALSE)
go("prefilter>=10, indep OFF", 10, FALSE)
go("rowSums>0 only, indep ON", 1, TRUE)
