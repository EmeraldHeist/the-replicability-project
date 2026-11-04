# Three figures for the Case 10 report. Run from the case folder: python3 scripts/make_figures.py
# Inputs are all in derived/. Paper totals are from Fig. S6a / SI text (Liao et al. 2026).
import pandas as pd, numpy as np, matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

INK, MUTED, GRID, SURF = "#0b0b0b", "#52514e", "#e1e0d9", "#fcfcfb"
BLUE, ORANGE, AQUA = "#2a78d6", "#eb6834", "#1baf7a"
plt.rcParams.update({"font.family": "DejaVu Sans", "font.size": 10, "axes.edgecolor": MUTED,
    "axes.labelcolor": INK, "text.color": INK, "xtick.color": MUTED, "ytick.color": MUTED,
    "axes.facecolor": SURF, "figure.facecolor": SURF, "axes.spines.top": False, "axes.spines.right": False})

def clean(ax):
    ax.grid(axis="y", color=GRID, lw=0.8); ax.set_axisbelow(True)

# ---- Figure 1: changed genes per group, paper vs ours at 1.5-fold and at the stated 2-fold
pg = pd.read_csv("derived/per_gene_table_pairwise_rsem.csv")
groups = ["Cd_1h", "Cr_1h", "Pb_1h", "Hg_1h", "Imi_1h", "Tri_1h", "Imi_3h"]
labels = ["Cd", "Cr", "Pb", "Hg", "Imidacloprid\n1 h", "Triclosan", "Imidacloprid\n3 h"]
paper = [723, 677, 953, 1284, 601, 1229, 1634]
ours15 = [int(pg[f"{g}_DEG_1.5fold"].sum()) for g in groups]
ours2 = [int(pg[f"{g}_DEG_2fold"].sum()) for g in groups]
x = np.arange(len(groups)); w = 0.27
fig, ax = plt.subplots(figsize=(9, 4.6)); clean(ax)
for off, vals, col, lab in ((-w, paper, BLUE, "Paper (Fig. S6a)"),
                            (0, ours15, ORANGE, "Ours, 1.5-fold cutoff (chosen after the fact)"),
                            (w, ours2, AQUA, "Ours, stated 2-fold cutoff")):
    ax.bar(x + off, vals, w - 0.03, color=col, label=lab)
ax.set_xticks(x); ax.set_xticklabels(labels); ax.set_ylabel("Genes changed (FDR < 0.05)")
ax.legend(frameon=False, loc="upper left", fontsize=9)
ax.set_title("Changed genes per exposure group: paper vs reanalysis", loc="left", fontsize=11, fontweight="bold")
fig.tight_layout(); fig.savefig("figures/fig1_deg_counts.png", dpi=150); plt.close(fig)

# ---- Figure 2: SI Table S4 log2FC, paper vs ours (31 gene-contrast rows)
s4 = pd.read_csv("derived/tableS4_parsed.csv")
ours = []
for _, r in s4.iterrows():
    ours.append(pg.loc[pg.gene_id == r.gene, f"{r.contrast}_log2FC"].iloc[0] if (pg.gene_id == r.gene).any() else np.nan)
s4["ours"] = ours
s4["diff"] = (s4.ours - s4.log2FC).abs()
s4["close"] = s4["diff"] < 0.1
fig, ax = plt.subplots(figsize=(5.8, 5.6)); ax.grid(color=GRID, lw=0.8); ax.set_axisbelow(True)
lim = (-1.5, 1.5); ax.plot(lim, lim, color=MUTED, lw=1, ls="--"); ax.set_xlim(lim); ax.set_ylim(lim)
c = s4[s4.close]; d = s4[~s4.close]
ax.scatter(c.log2FC, c.ours, s=48, color=BLUE, edgecolor=SURF, lw=1.2, label=f"Agrees within 0.1 ({len(c)} rows)")
ax.scatter(d.log2FC, d.ours, s=60, marker="D", color=ORANGE, edgecolor=SURF, lw=1.2, label=f"Differs by 0.1 or more ({len(d)} rows)")
for _, r in d.iterrows():
    ax.annotate(r.gene.replace("gene-", "") + " (" + r.contrast + ")", (r.log2FC, r.ours), xytext=(6, -3), textcoords="offset points", fontsize=7.5, color=MUTED)
ax.set_xlabel("log2 fold change, paper (SI Table S4)"); ax.set_ylabel("log2 fold change, ours (RSEM, pairwise DESeq2)")
ax.legend(frameon=False, loc="upper left", fontsize=8.5)
ax.set_title("Gene-level check against SI Table S4", loc="left", fontsize=11, fontweight="bold")
fig.tight_layout(); fig.savefig("figures/fig2_tableS4_log2FC.png", dpi=150); plt.close(fig)
s4[["gene", "contrast", "log2FC", "ours", "diff"]].round(4).to_csv("derived/tableS4_vs_ours_log2FC.csv", index=False)

# ---- Figure 3: PCA of the 24 libraries, one panel per condition
pc = pd.read_csv("derived/pca_rsem.csv"); v1, v2 = pc.var_PC1[0], pc.var_PC2[0]
conds = [("Control1h", "Control 1 h"), ("Cd21h", "Cd 1 h"), ("Cr61h", "Cr 1 h"), ("Pb21h", "Pb 1 h"),
         ("Hg21h", "Hg 1 h"), ("Imidacloprid1h", "Imidacloprid 1 h"), ("Triclosan1h", "Triclosan 1 h"), ("Imidacloprid3h", "Imidacloprid 3 h")]
fig, axs = plt.subplots(2, 4, figsize=(11, 5.6), sharex=True, sharey=True)
for ax, (key, name) in zip(axs.flat, conds):
    ax.grid(color=GRID, lw=0.8); ax.set_axisbelow(True)
    ax.scatter(pc.PC1, pc.PC2, s=26, color="#c9c8c0", edgecolor=SURF, lw=0.8)
    ctl = pc[pc.cond == "Control1h"]; ax.scatter(ctl.PC1, ctl.PC2, s=34, color=INK, edgecolor=SURF, lw=0.8)
    if key != "Control1h":
        g = pc[pc.cond == key]; ax.scatter(g.PC1, g.PC2, s=44, color=BLUE, edgecolor=SURF, lw=1)
    ax.set_title(name, fontsize=9.5, loc="left")
for ax in axs[1]: ax.set_xlabel(f"PC1 ({v1}%)")
for ax in axs[:, 0]: ax.set_ylabel(f"PC2 ({v2}%)")
fig.suptitle("PCA of 24 libraries (variance-stabilised RSEM counts, top 500 genes). Blue: the panel's group. Black: control. Grey: the rest.", x=0.01, ha="left", fontsize=10, fontweight="bold")
fig.tight_layout(rect=(0, 0, 1, 0.94)); fig.savefig("figures/fig3_pca.png", dpi=150); plt.close(fig)
print(dict(zip(labels, zip(paper, ours15, ours2)))); print("S4 close:", int(s4.close.sum()), "of", len(s4))
