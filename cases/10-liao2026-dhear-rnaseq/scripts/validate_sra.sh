#!/usr/bin/env bash
set -uo pipefail
B="$HOME/Desktop/replicability projects"; OUT="$B/data/raw/prjna1304005/sra"; V="$B/logs/prjna1304005_validate.log"
: > "$V"
while read -r r; do
  f="$OUT/$r/$r.sra"
  res=$(vdb-validate "$f" 2>&1 | tail -3 | tr '\n' ' ')
  sha=$(shasum -a 256 "$f" | cut -d' ' -f1)
  echo "$r|$(stat -f %z "$f")|$sha|$res" >> "$V"
done < "$B/logs/prjna1304005_runs.txt"
echo "VALIDATE_DONE $(date -u +%FT%TZ)" >> "$V"
