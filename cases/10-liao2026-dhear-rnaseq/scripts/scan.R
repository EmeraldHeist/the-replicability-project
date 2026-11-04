suppressMessages(library(DESeq2))
rp <- Sys.getenv("RP"); res <- file.path(rp,"results/liao2026")
mp <- read.delim(file.path(rp,"data/raw/prjna1304005_metadata/run_sample_map.tsv"), stringsAsFactors=FALSE)
G <- c("Cd21h","Cr61h","Pb21h","Hg21h","Imidacloprid1h","Triclosan1h","Imidacloprid3h")
paper <- c(723,677,953,1284,601,1229,1634); pu <- 4605; ps <- 28
score <- function(n,u,s) round(sqrt(mean(c(log(n/paper), log(u/pu))^2)),3)
rows <- list()
add <- function(src,lab,sets){ n <- sapply(sets,length); u <- length(unique(unlist(sets))); s <- length(Reduce(intersect,sets))
  rows[[length(rows)+1]] <<- data.frame(src=src,setting=lab,perGroup=paste(n,collapse="/"),union=u,shared=s,rmslogerr=score(n,u,s)) }
for (src in c("featurecounts","rsem")) {
  f <- if (src=="rsem") "gene_count_matrix_rsem.csv" else "gene_count_matrix_featurecounts.csv"
  cm <- read.csv(file.path(res,f), row.names=1, check.names=FALSE)
  m <- mp[match(colnames(cm), mp$run),]
  m$cond <- relevel(factor(gsub("[^A-Za-z0-9]","",sub("_","",sub("_[0-9]$","",sub("^Daphnia_","",m$sample_name))))), ref="Control1h")
  dds <- DESeqDataSetFromMatrix(as.matrix(cm), data.frame(cond=m$cond,row.names=m$run), ~cond)
  dds <- dds[rowSums(counts(dds))>=10,]; dds <- suppressMessages(DESeq(dds))
  for (l in c(0.5,0.585,0.6,0.7,0.8,1)) {
    add(src,paste0("filter |LFC|>=",l), lapply(G,function(g){r<-results(dds,contrast=c("cond",g,"Control1h"));rownames(r)[!is.na(r$padj)&r$padj<0.05&abs(r$log2FoldChange)>=l]}))
    if (l %in% c(0.585,1)) add(src,paste0("lfcThreshold=",l," (greaterAbs test)"), lapply(G,function(g){r<-results(dds,contrast=c("cond",g,"Control1h"),lfcThreshold=l,altHypothesis="greaterAbs");rownames(r)[!is.na(r$padj)&r$padj<0.05]}))
    add(src,paste0("filter |LFC|>=",l," + cooksCutoff off"), lapply(G,function(g){r<-results(dds,contrast=c("cond",g,"Control1h"),cooksCutoff=FALSE);rownames(r)[!is.na(r$padj)&r$padj<0.05&abs(r$log2FoldChange)>=l]}))
    add(src,paste0("filter |LFC|>=",l," + p<0.05 (raw, no FDR)"), lapply(G,function(g){r<-results(dds,contrast=c("cond",g,"Control1h"));rownames(r)[!is.na(r$pvalue)&r$pvalue<0.05&abs(r$log2FoldChange)>=l]}))
  }
}
o <- do.call(rbind,rows); o <- o[order(o$rmslogerr),]; write.csv(o,file.path(res,"deseq2_settings_scan.csv"),row.names=FALSE)
print(head(o,12),row.names=FALSE)
