import re,sys,collections,csv
rp=sys.argv[1]; res=rp+'/results/liao2026'
runs=[l.strip() for l in open(rp+'/logs/prjna1304005_runs.txt') if l.strip()]
cnt=collections.defaultdict(dict); tpm=collections.defaultdict(dict)
for r in runs:
    tx={}; ln=collections.Counter()
    for l in open(f'{rp}/work/liao2026_quant/stringtie/{r}/{r}.gtf'):
        if l[0]=='#': continue
        f=l.rstrip('\n').split('\t'); a=f[8]
        tid=re.search(r'transcript_id "([^"]+)"',a).group(1)
        if f[2]=='transcript':
            tx[tid]=(re.search(r'gene_id "([^"]+)"',a).group(1),float(re.search(r'cov "([^"]+)"',a).group(1)),float(re.search(r'TPM "([^"]+)"',a).group(1)))
        elif f[2]=='exon': ln[tid]+=int(f[4])-int(f[3])+1
    for t,(g,cov,tp) in tx.items():
        cnt[g][r]=cnt[g].get(r,0)+cov*ln[t]/150
        tpm[g][r]=tpm[g].get(r,0)+tp
genes=sorted(cnt)
for name,d,fmt in (('gene_count_matrix.csv',cnt,lambda x:str(int(round(x)))),('gene_tpm_matrix.csv',tpm,lambda x:'%.4f'%x)):
    w=csv.writer(open(f'{res}/{name}','w')); w.writerow(['gene_id']+runs)
    for g in genes: w.writerow([g]+[fmt(d[g].get(r,0)) for r in runs])
print(len(genes),'genes')
for r in runs: print(r,sum(int(round(cnt[g].get(r,0))) for g in genes))
