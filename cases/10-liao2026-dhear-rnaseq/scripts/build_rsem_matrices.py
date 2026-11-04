"""Combine per-library RSEM outputs into gene/isoform count and TPM matrices.
Usage: python3 -I build_rsem_matrices.py runs.txt rsem_dir outdir   (rsem_dir/<run>/<run>.genes.results)"""
import csv, sys
runs=[l.strip() for l in open(sys.argv[1]) if l.strip()]; rd, out = sys.argv[2], sys.argv[3]
for kind, tag in (('genes','gene'),('isoforms','isoform')):
    C={}; T={}
    for r in runs:
        it=csv.reader(open(f'{rd}/{r}/{r}.{kind}.results'), delimiter='\t'); next(it)
        for l in it: C.setdefault(l[0],{})[r]=float(l[4]); T.setdefault(l[0],{})[r]=float(l[5])
    for name,D,f in ((f'{tag}_count_matrix_rsem.csv',C,lambda x:str(round(x))),(f'{tag}_tpm_matrix_rsem.csv',T,lambda x:'%.4f'%x)):
        w=csv.writer(open(f'{out}/{name}','w')); w.writerow(['id']+runs)
        for g in sorted(D): w.writerow([g]+[f(D[g][r]) for r in runs])
