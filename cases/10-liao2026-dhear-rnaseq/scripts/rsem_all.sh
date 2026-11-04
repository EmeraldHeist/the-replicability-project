#!/usr/bin/env bash
set -uo pipefail
S=$SCRATCH
RP="$S/rp"; W="$RP/work/liao2026_quant"; LOG="$RP/logs/liao2026_rsem.log"
SRA="$RP/data/raw/prjna1304005/sra"; E=$CONDA_BASE/envs/daphnia_rsem/bin
Q=$CONDA_BASE/envs/daphnia_quant/bin
export PATH="$E:$PATH"
log(){ echo "$(date -u +%FT%TZ) $*" >> "$LOG"; }
mkdir -p "$W/rsem/ref"
if [ ! -s "$W/rsem/ref/dm.n2g.idx.fa" ]; then
  rsem-prepare-reference --gtf "$W/index/genes.tx.gtf" --bowtie2 --bowtie2-path "$E" -p 8 "$W/index/genome.fa" "$W/rsem/ref/dm" >> "$LOG" 2>&1 || { log "FAILED prepare-reference"; exit 1; }
  log "reference done"
fi
runs=(); while IFS= read -r x; do [ -n "$x" ] && runs+=("$x"); done < "$RP/logs/prjna1304005_runs.txt"
for r in "${runs[@]}"; do
  O="$W/rsem/$r"; T="$W/rsem_tmp_$r"
  [ -s "$O/$r.genes.results" ] && { log "SKIP $r"; continue; }
  mkdir -p "$O" "$T"; log "START $r"; t0=$(date +%s)
  "$Q/fasterq-dump" --split-files -e 8 -O "$T" -t "$T" "$SRA/$r/$r.sra" >> "$LOG" 2>&1 || { fasterq-dump --split-files -e 8 -O "$T" -t "$T" "$SRA/$r/$r.sra" >> "$LOG" 2>&1 || { log "FAILED $r fasterq-dump"; rm -rf "$T"; continue; }; }
  fastp -i "$T/${r}_1.fastq" -I "$T/${r}_2.fastq" -o "$T/c1.fq.gz" -O "$T/c2.fq.gz" -q 20 -u 10 -n 5 -l 20 --cut_tail --cut_tail_mean_quality 20 --detect_adapter_for_pe -w 8 -h "$O/fastp.html" -j "$O/fastp.json" >> "$LOG" 2>&1 || { log "FAILED $r fastp"; rm -rf "$T"; continue; }
  rm -f "$T/${r}_1.fastq" "$T/${r}_2.fastq"
  gzip -dc "$T/c1.fq.gz" > "$T/c1.fq"; gzip -dc "$T/c2.fq.gz" > "$T/c2.fq"; rm -f "$T"/c?.fq.gz
  rsem-calculate-expression --paired-end --bowtie2 --bowtie2-path "$E" --strandedness none -p 8 --no-bam-output "$T/c1.fq" "$T/c2.fq" "$W/rsem/ref/dm" "$O/$r" >> "$O/rsem.log" 2>&1 || { log "FAILED $r rsem"; rm -rf "$T"; continue; }
  rm -rf "$T"; rm -rf "$O/$r.stat"/*.tmp 2>/dev/null
  log "OK $r min=$(( ($(date +%s)-t0)/60 ))"
done
log "RSEM_DONE ok=$(grep -c ' OK SRR' "$LOG") failed=$(grep -c ' FAILED ' "$LOG")"
