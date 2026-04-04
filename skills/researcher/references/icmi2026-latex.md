# ICMI 2026 LaTeX Reference

## Conference Details

- **Full name**: 28th ACM International Conference on Multimodal Interaction
- **Dates**: 5--9 October 2026 (main conference 6--8 Oct; workshops 5 or 9 Oct)
- **Location**: Naples (Napoli), Italy
- **Theme**: "Context and Cultural Awareness for Multimodal Interaction"
- **Proceedings**: ACM International Conference Proceedings / Digital Library

## Submission Categories & Page Limits

| Category         | Max pages | Notes                                      |
|------------------|-----------|---------------------------------------------|
| Long paper       | 8         | References do NOT count toward limit        |
| Short paper      | 4         | References do NOT count toward limit        |
| Blue Sky paper   | 4         | References do NOT count toward limit        |
| Late-Breaking    | 4         | Same format, appears in Adjunct Proceedings |

Additional pages beyond the limit may be used ONLY for references.

Up to two supporting files may be submitted (PDF appendix, ZIP with video/code).
Supplementary material is optional --- reviewers assess the main paper primarily.

### What Counts Toward the Page Limit

- All body text, figures, tables: **yes**
- Safe and Responsible Innovation Statement: **yes** (must fit within 8/4 pages)
- References: **no** (unlimited extra pages)
- Supplementary material: **no** (separate files)

Papers exceeding page limits will be rejected.

## Mandatory Content Requirements

### Safe and Responsible Innovation Statement

**Required for ALL submissions.** Approximately 100 words. Must be included within
the page limit (not in addition to it). Address:

- Societal impacts and ethical considerations
- Responsible deployment of the proposed technology
- Data privacy and bias mitigation
- Inclusivity and potential risks or misuse

This is an ICMI-specific requirement beyond the standard ACM ethics expectations.
Place it as a clearly labeled paragraph or short section, typically near the end
of the paper (before or after Conclusion).

### ACM CCS Categories & Keywords

- **At submission**: Encouraged but not mandatory
- **At camera-ready**: Mandatory on first page for ACM Digital Library indexing
- Generate CCS XML from https://dl.acm.org/ccs
- `\keywords{...}` also mandatory on final version

## Submission Process

### Abstract Submission

1. Create a submission entry (no PDF required at this stage)
2. Paper title and author list must not change between abstract and full paper

### Full Paper Submission

1. Upload PDF to the **same** submission entry (do not create a new one)
2. Submission portal linked on the guidelines page: https://icmi.acm.org/2026/guidelines/

## Review Process

- **Double-blind**: No author names, affiliations, or identifying information.
  Program chairs will **desk-reject** non-anonymous papers after review begins.
- **Novelty**: Evaluated on scientific novelty AND/OR technical novelty.
- **Rebuttal period**: After initial reviews are posted, authors may submit a
  short rebuttal addressing major misinterpretations or factual errors. This is
  followed by a reviewer discussion period with Senior Program Committee members
  (not visible to authors). Final decisions follow the discussion.
- **Author list**: Final after submission deadline. No additions, removals, or
  order changes except in exceptional circumstances validated by program and
  publication chairs.

## LaTeX Setup

### Document Class

For submission (anonymous, with line numbers):
```latex
\documentclass[sigconf,anonymous,review]{acmart}
```

For camera-ready (after acceptance):
```latex
\documentclass[sigconf]{acmart}
```

### Template Downloads

| Resource | URL |
|----------|-----|
| LaTeX template (ZIP) | https://portalparts.acm.org/hippo/latex_templates/acmart-primary.zip |
| Overleaf | Search "ACM Conference Proceedings Primary Article Template" |
| Word interim template | https://www.acm.org/binaries/content/assets/publications/word_style/interim-template-style/interim-layout.docx |
| Accepted LaTeX packages | https://authors.acm.org/proceedings/production-information/accepted-latex-packages |

Use the `sample-sigconf.tex` file as your starting point.

### Required Elements

```latex
% Citation style (pick one)
\citestyle{acmauthoryear}  % (Author, Year) style
% or
\citestyle{acmnumeric}     % [1] style

% ACM classification (required for camera-ready, encouraged at submission)
\begin{CCSXML}
% Generate from https://dl.acm.org/ccs
\end{CCSXML}

% Keywords
\keywords{keyword1, keyword2, keyword3}

% Every figure MUST have a \Description{} for accessibility
\begin{figure}
  \includegraphics[width=\columnwidth]{figures/example.pdf}
  \caption{Caption text.}
  \Description{A detailed text description of the figure for accessibility.}
  \label{fig:example}
\end{figure}
```

### Anonymization Checklist

For double-blind submission:
- Remove all author names and affiliations
- Remove acknowledgments section (or leave blank)
- Refer to your own prior work in third person: "Smith et al. [5] showed..."
- Do not include links to your personal website, GitHub, or identifiable resources
- Remove or anonymize institutional details in ethics statements
- Check PDF metadata (some LaTeX setups embed author info in PDF properties)
- **Non-compliance leads to desk rejection** --- program chairs enforce this

### LaTeX Packages: TAPS Whitelist

ACM's production system (TAPS) only processes packages on the approved whitelist.
Full list: https://authors.acm.org/proceedings/production-information/accepted-latex-packages

**For submission/review**: Any packages work. TAPS restrictions only apply at camera-ready.

**Packages built into `acmart`** (do NOT `\usepackage` these --- already loaded):
`booktabs`, `xcolor`, `graphicx`, `hyperref`, `natbib`, `microtype`, `geometry`,
`caption`, `float`, `amsmath`, `fontenc`, `setspace`, `balance`, and others.
Redundant `\usepackage` lines may cause TAPS warnings.

**Safe additional packages** (on the approved list):
- `amsmath`, `amssymb`, `amsthm` --- math
- `algorithm`, `algorithmic`, `algorithm2e` --- pseudocode
- `subcaption`, `subfig`, `subfigure` --- subfigures
- `cleveref` --- smart cross-references
- `multirow` --- table cells spanning rows
- `listings` --- code listings
- `enumitem` --- list customization
- `mathtools` --- math extensions
- `siunitx` --- SI units

**NOT on the approved list** (will fail TAPS at camera-ready):
- `tikz` / `pgf` --- workaround: render to standalone PDF, include with `\includegraphics`
- `tabularx` --- use `tabular` instead
- `tcolorbox`, `mdframed` --- not accepted

### Starter Template

```latex
\documentclass[sigconf,anonymous,review]{acmart}

% Metadata (fill in for camera-ready; leave empty for submission)
\acmConference[ICMI '26]{28th International Conference on Multimodal Interaction}
  {October 5--9, 2026}{Naples, Italy}
\acmYear{2026}
\acmISBN{}
\acmDOI{}

\citestyle{acmauthoryear}

\begin{document}

\title{Your Paper Title Here}

% For camera-ready only:
% \author{First Author}
% \affiliation{%
%   \institution{University Name}
%   \city{City}
%   \country{Country}
% }
% \email{author@example.com}

\begin{abstract}
Your abstract here. 150--250 words. Include the problem, approach, key results,
and implications.
\end{abstract}

\begin{CCSXML}
% Paste CCS XML from https://dl.acm.org/ccs
\end{CCSXML}

\keywords{multimodal interaction, keyword2, keyword3}

\maketitle

\section{Introduction}
\label{sec:intro}

\section{Related Work}
\label{sec:related}

\section{Method}
\label{sec:method}

\section{Experiments}
\label{sec:experiments}

\subsection{Experimental Setup}
\label{sec:setup}

\subsection{Results}
\label{sec:results}

\subsection{Analysis}
\label{sec:analysis}

\section{Discussion}
\label{sec:discussion}

\section{Ethics and Broader Impact}
\label{sec:ethics}

% ~100-word Safe and Responsible Innovation Statement can go here
% or as a separate labeled paragraph.

\section{Conclusion}
\label{sec:conclusion}

\bibliographystyle{ACM-Reference-Format}
\bibliography{references}

\end{document}
```

### BibTeX Template

```bibtex
% references.bib

@inproceedings{author2024title,
  author    = {Last, First and Last, First},
  title     = {Paper Title},
  booktitle = {Proceedings of the 27th International Conference on Multimodal Interaction},
  series    = {ICMI '24},
  year      = {2024},
  pages     = {1--10},
  doi       = {10.1145/xxxxxxx.xxxxxxx},
  publisher = {ACM},
  address   = {New York, NY, USA},
}

@article{author2023journal,
  author  = {Last, First and Last, First},
  title   = {Article Title},
  journal = {ACM Transactions on Interactive Intelligent Systems},
  year    = {2023},
  volume  = {13},
  number  = {2},
  pages   = {1--25},
  doi     = {10.1145/xxxxxxx},
}
```

## ICMI Topics of Interest

Papers should relate to one or more of these areas:
- Affective computing and interaction
- User-adaptive systems
- Cognitive modelling and multimodal interaction
- Context-aware modelling
- Cross-cultural design and evaluation
- Gesture, touch, and haptics
- Healthcare and assistive technologies
- Human communication dynamics
- Human-robot/agent multimodal interaction
- Machine learning for multimodal data
- Multimodal behavior generation
- Multimodal dialogue systems
- Multimodal fusion and representation
- Multimodal datasets and benchmarks
- Speech, language, and natural language processing
- Social signal processing
- Visual and body behavior analysis

## 2026 Theme: Context and Cultural Awareness

The 2026 theme emphasizes:
- How context (environmental, social, emotional) shapes multimodal interaction
- Cultural considerations in interactive technology design and deployment
- Data representation ensuring cultural diversity in training data
- Bias mitigation across cultural and contextual differences
- Ethics and privacy in collecting contextual/cultural data

Papers that connect to this theme may be viewed favorably, though it is not required.

## Post-Acceptance: Camera-Ready & Publication

### Copyright
- Authors of accepted papers must sign an ACM copyright release.
- Updated ACM copyright-permission text will be provided in the acceptance notification.

### Camera-Ready Preparation
- Switch document class to `\documentclass[sigconf]{acmart}` (remove `anonymous,review`).
- Add author names, affiliations, emails, and ORCID IDs.
- Ensure ACM CCS categories and keywords are on the first page.
- Remove redundant `\usepackage` lines for packages built into `acmart`.
- Replace any non-whitelisted packages (e.g., `tikz` -> PDF figures).
- The non-anonymous author block may require more space than the anonymized version ---
  plan for this when near the page limit.
- Word users: extra TAPS validation required; LibreOffice is insufficient for final macros.

### Publication Date
The official publication date is the date proceedings appear in the ACM Digital Library,
which may be **up to two weeks before the conference start date**. This affects patent
filing deadlines. The first conference day remains the official date for conferences
with post-event publication.

## ACM Policy Notes

- **Generative AI**: Use of tools like ChatGPT is permitted, but authors are responsible
  for all content and must disclose use. See ACM authorship policy:
  https://www.acm.org/publications/policies/new-acm-policy-on-authorship
- **Open Access**: Starting 2026, all ACM publications are 100% Open Access. Two options:
  1. **ACM Open** (institutional): 1,800+ participating institutions, no APC required
     (covers 70--75% of conference papers). Check: https://libraries.acm.org/acmopen/open-participants
  2. **APC**: For non-participating institutions. 2026 subsidized rates: $250 (ACM/SIG members) /
     $350 (non-members), a 65% discount. Waivers rare; see APC policy:
     https://www.acm.org/publications/policies/policy-on-geographic-apc-waivers-and-discounts
- **Prior publication**: Papers must not have been previously published (peer-reviewed
  journal, magazine, book, or proceedings --- language irrelevant). Dual submission to
  other venues is not permitted for substantially similar content.
- **Preprints**: arXiv and open repositories are NOT considered dual submission.
  Paid-access repositories (ResearchGate, Academia) are not accepted.
- **Author list**: Final after submission deadline. No additions, removals, or order
  changes except in exceptional circumstances with validation from program and
  publication chairs.
- **ORCID**: Required for all authors at final submission.
