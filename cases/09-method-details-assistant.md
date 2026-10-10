# Case 9: Method-details assistant

| | |
|---|---|
| **Paper** | Not a paper reproduction |
| **Field** | Bioinformatics, ML |
| **Status** | Starts after at least three cases 1 to 8 are finished |

> This is a plan. No results have been obtained or claimed.

## What this is

A test of whether a retrieval-based assistant can read a paper's methods and repository and list the details a reproduction would need that the text does not spell out. It is scored against the human reconstruction logs from cases 1 to 8. With few cases, results are reported as counts, not rates.

## Corpus and evaluation data

- Frozen documentation for one released version each of nf-core/rnaseq, Nextflow, MultiQC and selected tools, plus the methods sections of the papers studied where licenses allow. URLs, retrieval dates and versions are stored.
- Gold standard: the human reconstruction logs from finished cases, plus questions about workflow commands and parameters with reference answers and explicit unanswerable cases.

## Tiers

- **Tier 1 (reproduce):** keyword and embedding retrieval baselines, then retrieval-augmented answers with linked citations.
- **Tier 2 (re-implement):** swap one component at a time, such as the reranker, the model or the chunking, and compare.
- **Tier 3 (replicate):** run on a paper not used during development and compare against a newly written human log.

## Checks and validation

- Score recall of true missing details, false alarms, unsupported claims, citation correctness and abstention separately.
- Keep a hidden test set and have a knowledgeable reviewer adjudicate ambiguous cases.
- Test prompt injection in retrieved documents. The system must not execute commands or expose credentials.

## Running it

- `make demo`: the permitted frozen corpus, questions and a local interface. Actions runs retrieval and citation tests without paid services; optional model backends are set through documented environment variables.
- Retrieval is built without an LLM first, and every wrong answer is reviewed and classified.

## Deliverables

Corpus manifest, evaluated retrieval pipeline, citation interface, error taxonomy, security tests, model card and a benchmark report.

## Skills practiced

- Version control and project hygiene
- Reading papers closely
- Verifying AI-assisted work
- Documentation and communication

See [README](../README.md#skills-reproducibility-requires) for the full list. The skill numbers here are a plan, and the case report will record what was actually needed.

## Shared method

Success criteria, outcome categories, logs and reporting language follow [PROTOCOL.md](../PROTOCOL.md).
