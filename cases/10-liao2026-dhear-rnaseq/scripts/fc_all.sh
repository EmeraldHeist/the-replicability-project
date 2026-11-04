#!/usr/bin/env bash
set -euo pipefail
export PATH=$CONDA_BASE/envs/daphnia_quant/bin:$PATH
RP=$RP
cd "$RP/work/liao2026_quant"
bams=()
while IFS= read -r r; do [ -z "$r" ] && continue
  if [ "$r" = SRR34937006 ]; then bams+=("pilot/$r/$r.unstranded.sorted.bam"); else bams+=("runs/$r/$r.sorted.bam"); fi
done < "$RP/logs/prjna1304005_runs.txt"
featureCounts -p --countReadPairs -B -C -s 0 -T 8 -t exon -g gene_id -a index/genes.tx.gtf -o "$RP/results/liao2026/featurecounts_raw.txt" "${bams[@]}" > "$RP/logs/liao2026_featurecounts.log" 2>&1
echo FC_DONE >> "$RP/logs/liao2026_featurecounts.log"
