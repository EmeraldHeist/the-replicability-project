# Readiness checklist (v0)

Used before a case starts, to estimate how much groundwork it will need. It describes how much a replicator must work out, not how good a paper is. Items are yes, no or not assessable.

## Access
- Are the data available, with an exact accession or release version?
- Is code available, and can I run it?
- Are the compute and storage needs within what I have?

## Detail in the description
- Are software versions, random seeds, filters, thresholds and preprocessing steps stated?
- Are the train, validation and test splits described (and grouped by donor, culture, time or similar where that matters)?
- Are the evaluation metrics and baselines described?

## Checks on my own understanding
- Can I recompute reported numbers (statistics, counts, percentages) from the reported inputs? A mismatch means I should first re-read the method.
- Do tables and text agree in the way I understand them?

## Things to watch in my own re-implementation
- Could the same sample, molecule or patient end up on both sides of a split?
- Is any feature derived from the outcome?
- Am I reporting variability across seeds, folds or resamples?

## Estimate
Count what is missing or unclear and choose: **straightforward**, **some groundwork**, or **substantial groundwork**. Record the estimate before starting, and the actual effort (hours, number of reconstruction log entries) afterward.
