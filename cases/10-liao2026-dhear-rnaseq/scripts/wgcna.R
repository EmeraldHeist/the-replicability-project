suppressMessages(library(WGCNA)); allowWGCNAThreads(8)
rp <- Sys.getenv("RP"); res <- file.path(rp,"results/liao2026")
tp <- read.csv(file.path(res,"gene_tpm_matrix.csv"), row.names=1, check.names=FALSE)
mp <- read.delim(file.path(rp,"data/raw/prjna1304005_metadata/run_sample_map.tsv"), stringsAsFactors=FALSE)
mp <- mp[match(colnames(tp), mp$run),]
mp$cond <- gsub("[^A-Za-z0-9]","",sub("_","",sub("_[0-9]$","",sub("^Daphnia_","",mp$sample_name))))
m <- rowMeans(tp); cv <- apply(tp,1,sd)/m
keep <- m>=1 & cv>=0.1 & is.finite(cv)
cat("genes total", nrow(tp), "kept", sum(keep), "\n")
dat <- t(log2(tp[keep,]+1))
net <- blockwiseModules(dat, power=20, networkType="signed", TOMType="signed", minModuleSize=30,
  minKMEtoStay=0.3, mergeCutHeight=0.25, maxBlockSize=20000, numericLabels=TRUE, pamRespectsDendro=FALSE,
  saveTOMs=FALSE, verbose=0)
tb <- table(net$colors); print(tb)
cat("modules (excluding grey/0):", sum(names(tb)!="0"), "\n")
write.csv(data.frame(gene=colnames(dat), module=net$colors), file.path(res,"wgcna_modules.csv"), row.names=FALSE)
ME <- net$MEs; ec <- aggregate(ME, by=list(cond=mp$cond), FUN=mean)
write.csv(ec, file.path(res,"wgcna_eigengenes_by_condition.csv"), row.names=FALSE)
