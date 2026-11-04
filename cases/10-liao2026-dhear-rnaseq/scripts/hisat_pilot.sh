#!/usr/bin/env bash
set -euo pipefail
S=$SCRATCH
RP="$S/rp"; W="$RP/work/liao2026_quant"; RUN=SRR34937006; LOG="$RP/logs/liao2026_quant_pilot.log"
log(){ echo "$(date -u +%FT%TZ) $*" | tee -a "$LOG"; }
log "HISAT2 retry (space-free path via symlink)"
hisat2 -p 8 --rna-strandness RF -x "$W/index/genome" -1 "$W/pilot/$RUN/clean_1.fq.gz" -2 "$W/pilot/$RUN/clean_2.fq.gz" \
  --summary-file "$W/pilot/$RUN/hisat2_summary.txt" | samtools sort -@ 4 -o "$W/pilot/$RUN/$RUN.sorted.bam" -
samtools index "$W/pilot/$RUN/$RUN.sorted.bam"
log "HISAT2 done"; cat "$W/pilot/$RUN/hisat2_summary.txt" | tee -a "$LOG"
rm -f "$W/pilot/$RUN/${RUN}_1.fastq" "$W/pilot/$RUN/${RUN}_2.fastq"
log "PILOT_DONE bam=$(stat -f %z "$W/pilot/$RUN/$RUN.sorted.bam")"
