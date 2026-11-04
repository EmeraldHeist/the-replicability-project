#!/usr/bin/env bash
set -uo pipefail
export PATH=$CONDA_BASE/envs/daphnia_quant/bin:$PATH
W="$HOME/Desktop/replicability projects/work/liao2026_quant"
LOG="$HOME/Desktop/replicability projects/logs/liao2026_stringtie.log"
run_one() {
  r="$1"; W="$2"; LOG="$3"
  bam="$W/runs/$r/$r.sorted.bam"; out="$W/stringtie/$r"
  [ -s "$out/$r.gene_abund.tab" ] && { echo "$(date -u +%FT%TZ) SKIP $r" >> "$LOG"; exit 0; }
  mkdir -p "$out"
  if stringtie "$bam" -e -B -p 1 -G "$W/index/genes.tx.gtf" -o "$out/$r.gtf" -A "$out/$r.gene_abund.tab" >> "$out/stringtie.log" 2>&1; then
    echo "$(date -u +%FT%TZ) OK $r" >> "$LOG"
  else echo "$(date -u +%FT%TZ) FAILED $r" >> "$LOG"; fi
}
export -f run_one
grep -v '^$' "$HOME/Desktop/replicability projects/logs/prjna1304005_runs.txt" | xargs -P 4 -I{} bash -c 'run_one {} "$0" "$1"' "$W" "$LOG"
echo "$(date -u +%FT%TZ) ST_DONE" >> "$LOG"
