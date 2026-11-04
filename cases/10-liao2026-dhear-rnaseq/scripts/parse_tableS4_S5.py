"""Extract SI Table S4 (gene-level rows) from the SI PDF text. Table S5 was transcribed by hand (derived/tableS5_parsed.csv).
Usage: python3 -I parse_tableS4_S5.py liao2026_SI.pdf derived/tableS4_parsed.csv   (needs pdftotext)"""
import subprocess, re, csv, sys
pdf, out = sys.argv[1], sys.argv[2]
t = subprocess.run(['pdftotext','-raw','-f','50','-l','55',pdf,'-'], capture_output=True, text=True).stdout
parts = re.split(r'gene-\s*(LOC\d+)', t); rows = []
for i in range(1, len(parts), 2):
    g, body = parts[i], parts[i+1]
    m = re.search(r'((?:Imi|Pb|Tri|Cd|Cr|Hg)_\dh)/Control\s*(-?)\s*(\d\.\d+)\s+(\d\.\d+)E([-+]?)\s*(\d+)\s+(up|down)', body)
    if not m: print('UNPARSED', g); continue
    c, sg, lf, man, es, ex, d = m.groups()
    mod = re.search(r'\n(yellow|red|blue|black|turquoise|brown|pink|green|magenta|purple|greenyellow)\s', body)
    rows.append((g, c, float(lf)*(-1 if sg=='-' else 1), float(man)*10**(int(ex)*(-1 if es in('-','') else 1)), d, mod.group(1) if mod else ''))
w = csv.writer(open(out,'w')); w.writerow(['gene','contrast','log2FC','padj','direction','module']); w.writerows(rows); print(len(rows),'rows')
