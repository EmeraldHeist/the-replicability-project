suppressMessages(library(DESeq2))
rp <- Sys.getenv("RP"); res <- file.path(rp,"results/liao2026")
cm <- read.csv(file.path(res,"gene_count_matrix_rsem.csv"), row.names=1, check.names=FALSE)
mp <- read.delim(file.path(rp,"data/raw/prjna1304005_metadata/run_sample_map.tsv"), stringsAsFactors=FALSE)
mp <- mp[match(colnames(cm), mp$run),]
mp$cond <- gsub("[^A-Za-z0-9]","",sub("_","",sub("_[0-9]$","",sub("^Daphnia_","",mp$sample_name))))
s4 <- read.csv(file.path(res,"tableS4_parsed.csv"))
map <- c(Cd_1h="Cd21h",Cr_1h="Cr61h",Pb_1h="Pb21h",Hg_1h="Hg21h",Imi_1h="Imidacloprid1h",Tri_1h="Triclosan1h",Imi_3h="Imidacloprid3h")
G <- unname(map); paper <- c(723,677,953,1284,601,1229,1634)
bad <- c("LOC116922174","LOC116922180","LOC116926869")
evalres <- function(lab, getr){
  R <- lapply(G, getr); names(R) <- G
  d <- sapply(seq_len(nrow(s4)), function(i){ r <- R[[map[s4$contrast[i]]]]; g <- s4$gene[i]
    if (!g %in% rownames(r) || is.na(r[g,"padj"])) return(c(NA,NA)); c(log10(r[g,"padj"])-log10(s4$padj[i]), r[g,"log2FoldChange"]-s4$log2FC[i]) })
  keep <- !(s4$gene %in% bad)
  cr <- cor(-log10(sapply(seq_len(nrow(s4)),function(i){r<-R[[map[s4$contrast[i]]]];r[s4$gene[i],"padj"]}))[keep], -log10(s4$padj)[keep], use="complete.obs")
  sets <- lapply(G,function(g){r<-R[[g]];rownames(r)[!is.na(r$padj)&r$padj<0.05&abs(r$log2FoldChange)>=0.585]})
  cat(sprintf("%-42s mean dlog10padj %+.2f (median %+.2f) | r(-log10padj) %.3f | DEG %s | union %d\n", lab, mean(d[1,keep],na.rm=TRUE), median(d[1,keep],na.rm=TRUE), cr, paste(sapply(sets,length),collapse="/"), length(unique(unlist(sets)))))
}
mk <- function(m, pre){ d <- DESeqDataSetFromMatrix(as.matrix(cm[,m$run]), data.frame(cond=factor(m$cond),row.names=m$run), ~cond); if(pre>=0) d <- d[rowSums(counts(d))>=pre,]; d }
m0 <- mp; m0$cond <- relevel(factor(m0$cond), ref="Control1h")

for (nfix in c(NA, 26140)) for (pre in c(0,10)) {
  evalres(sprintf("pairwise, pre>=%d, BH n=%s, no indep filt",pre,ifelse(is.na(nfix),"tested",nfix)), function(g){
    m <- mp[mp$cond %in% c("Control1h",g),]; m$cond <- relevel(factor(m$cond),ref="Control1h")
    dds <- suppressMessages(suppressWarnings(DESeq(mk(m,pre), quiet=TRUE)))
    r <- as.data.frame(results(dds,contrast=c("cond",g,"Control1h"),independentFiltering=FALSE,cooksCutoff=FALSE))
    ok <- !is.na(r$pvalue); n <- if(is.na(nfix)) sum(ok) else nfix
    r$padj <- NA_real_; r$padj[ok] <- pmin(1, p.adjust(r$pvalue[ok], "BH", n=max(n,sum(ok)))); r })
}
