#!/usr/bin/env bash
set -euo pipefail
B="$HOME/Desktop/replicability projects"
REF="$B/data/raw/GCF_020631705.1_ASM2063170v1.1"; W="$B/work/liao2026_quant"; LOG="$B/logs/liao2026_quant_pilot.log"
RUN=SRR34937006
log(){ echo "$(date -u +%FT%TZ) $*" | tee -a "$LOG"; }
mkdir -p "$REF" "$W/index" "$W/pilot/$RUN" "$W/pilot/tmp"
U=https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/020/631/705/GCF_020631705.1_ASM2063170v1.1
P=GCF_020631705.1_ASM2063170v1.1
files=(md5checksums.txt ${P}_genomic.fna.gz ${P}_genomic.gtf.gz ${P}_rna.fna.gz ${P}_assembly_report.txt)
log "REF download"
for f in "${files[@]}"; do [ -s "$REF/$f" ] || curl -fsSL "$U/$f" -o "$REF/$f"; [ -s "$REF/$f" ] || { log "EMPTY $f"; exit 1; }; done
for f in "${files[@]:1:3}"; do
  want=$(grep " ./$f\$" "$REF/md5checksums.txt" | cut -d' ' -f1); got=$(md5 -q "$REF/$f")
  [ "$want" = "$got" ] && log "MD5 OK $f $got" || { log "MD5 MISMATCH $f"; exit 1; }
done
( cd "$REF" && shasum -a 256 *.gz *.txt > SHA256SUMS.local )
log "INDEX build"
[ -s "$W/index/genome.1.ht2" ] || { gzip -dc "$REF/${P}_genomic.fna.gz" > "$W/index/genome.fa"; hisat2-build -p 8 "$W/index/genome.fa" "$W/index/genome" > "$W/index/build.log" 2>&1; }
log "INDEX done"
log "PILOT $RUN fasterq-dump"
fasterq-dump --split-files -e 8 -O "$W/pilot/$RUN" -t "$W/pilot/tmp" "$B/data/raw/prjna1304005/sra/$RUN/$RUN.sra" >> "$LOG" 2>&1
ls -l "$W/pilot/$RUN" >> "$LOG"
log "PILOT fastp"
fastp -i "$W/pilot/$RUN/${RUN}_1.fastq" -I "$W/pilot/$RUN/${RUN}_2.fastq" -o "$W/pilot/$RUN/clean_1.fq.gz" -O "$W/pilot/$RUN/clean_2.fq.gz" \
  -q 20 -u 10 -n 5 -l 20 --cut_tail --cut_tail_mean_quality 20 --detect_adapter_for_pe -w 8 \
  -h "$W/pilot/$RUN/fastp.html" -j "$W/pilot/$RUN/fastp.json" >> "$LOG" 2>&1
log "PILOT hisat2"
hisat2 -p 8 --rna-strandness RF -x "$W/index/genome" -1 "$W/pilot/$RUN/clean_1.fq.gz" -2 "$W/pilot/$RUN/clean_2.fq.gz" \
  --summary-file "$W/pilot/$RUN/hisat2_summary.txt" 2>> "$LOG" | samtools sort -@ 4 -o "$W/pilot/$RUN/$RUN.sorted.bam" -
samtools index "$W/pilot/$RUN/$RUN.sorted.bam"
log "PILOT align done"; cat "$W/pilot/$RUN/hisat2_summary.txt" | tee -a "$LOG"
rm -f "$W/pilot/$RUN/${RUN}_1.fastq" "$W/pilot/$RUN/${RUN}_2.fastq"
log "PILOT_DONE bam=$(stat -f %z "$W/pilot/$RUN/$RUN.sorted.bam")"
