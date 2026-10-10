# Screening checklist (v0)

Scored before any rerun and not changed after outcomes are known. Each item is yes, no or not assessable. This version is a starting draft and will be versioned if it changes.

## Internal consistency
- Do reported test statistics, p-values, means, SDs and sample sizes agree when recomputed?
- Are there counts or percentages that cannot arise from the stated sample size?
- Do reported tables and text agree?

## Reporting completeness
- Are software versions, random seeds, filters, thresholds and preprocessing steps stated?
- Are data accessions or release versions stated exactly?
- Is code available, and does it run?

## Split and leakage risk
- Is the train, validation and test split described, and is it grouped appropriately (by donor, culture, scaffold, time)?
- Could the same sample, molecule, patient or related item appear on both sides?
- Is any feature derived from the outcome?

## Baselines and uncertainty
- Are simple baselines reported?
- Are variability across seeds, folds or resamples, and confidence intervals reported?
- Is a single benchmark or a single split the sole evidence?

## Scoring
Count flags, record which items were not assessable, and assign low, medium or high. A flag is a reason to look closer, not a conclusion.
