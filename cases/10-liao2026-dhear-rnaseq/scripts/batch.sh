#!/usr/bin/env bash
set -uo pipefail
S=$SCRATCH
RP="$S/rp"; W="$RP/work/liao2026_quant"; LOG="$RP/logs/liao2026_quant_batch.log"
P=GCF_020631705.1_ASM2063170v1.1
SRA="$RP/data/raw/prjna1304005/sra"; ENVQ=$CONDA_BASE/envs/daphnia_quant/bin
GTF="$W/index/genes.gtf"
log(){ echo "$(date -u +%FT%TZ) $*" >> "$LOG"; }
mkdir -p "$W/runs" "$W/stringtie"
# pilot first (clean reads already exist), then the other 23
runs=(); while IFS= read -r x; do [ -n "$x" ] && runs+=("$x"); done < "$RP/logs/prjna1304005_runs.txt"
order=(SRR34937006); for r in "${runs[@]}"; do [ "$r" = SRR34937006 ] || order+=("$r"); done
for r in "${order[@]}"; do
  D="$W/runs/$r"; BAM="$D/$r.sorted.bam"
  if [ "$r" = SRR34937006 ]; then D="$W/pilot/$r"; BAM="$D/$r.unstranded.sorted.bam"; fi
  if [ -s "$W/stringtie/$r/$r.gtf" ]; then log "SKIP $r (done)"; continue; fi
  mkdir -p "$D" "$W/tmp_$r"; log "START $r"
  t0=$(date +%s)
  if [ ! -s "$D/clean_1.fq.gz" ]; then
    fasterq-dump --split-files -e 8 -O "$D" -t "$W/tmp_$r" "$SRA/$r/$r.sra" >> "$LOG" 2>&1 || { log "FAILED $r fasterq-dump"; rm -rf "$W/tmp_$r"; continue; }
    log "$r fasterq-dump done"
    fastp -i "$D/${r}_1.fastq" -I "$D/${r}_2.fastq" -o "$D/clean_1.fq.gz" -O "$D/clean_2.fq.gz" -q 20 -u 10 -n 5 -l 20 --cut_tail --cut_tail_mean_quality 20 --detect_adapter_for_pe -w 8 -h "$D/fastp.html" -j "$D/fastp.json" >> "$LOG" 2>&1 || { log "FAILED $r fastp"; continue; }
    rm -f "$D/${r}_1.fastq" "$D/${r}_2.fastq"; log "$r fastp done"
  fi
  hisat2 -p 8 -x "$W/index/genome" -1 "$D/clean_1.fq.gz" -2 "$D/clean_2.fq.gz" --summary-file "$D/hisat2_summary.txt" 2>> "$LOG" | samtools sort -@ 4 -m 1G -o "$BAM" - 2>> "$LOG"
  if ! samtools quickcheck "$BAM"; then log "FAILED $r hisat2/sort"; continue; fi
  samtools index "$BAM"; log "$r hisat2 done: $(grep 'overall alignment rate' "$D/hisat2_summary.txt")"
  mkdir -p "$W/stringtie/$r"
  "$ENVQ/stringtie" "$BAM" -e -B -p 8 -G "$GTF" -o "$W/stringtie/$r/$r.gtf" -A "$W/stringtie/$r/$r.gene_abund.tab" >> "$LOG" 2>&1 || { log "FAILED $r stringtie"; continue; }
  rm -f "$D/clean_1.fq.gz" "$D/clean_2.fq.gz"; rm -rf "$W/tmp_$r"
  log "OK $r total_min=$(( ($(date +%s)-t0)/60 )) bam=$(stat -f %z "$BAM")"
done
log "BATCH_DONE ok=$(grep -c ' OK SRR' "$LOG") failed=$(grep -c ' FAILED ' "$LOG")"
