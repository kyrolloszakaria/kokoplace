# ICMI 2026 Reviewer Criteria: What Reviewers Look For

This reference translates the official ICMI 2026 reviewer guidelines into actionable
writing advice. Understanding how reviewers are trained to evaluate papers tells you
exactly what to emphasize, what to defend, and what to avoid.

Source: https://icmi.acm.org/2026/reviewer-guidelines/

## What Reviewers Are Told to Prioritize

Reviewers are explicitly instructed to focus on:

1. **The main unique contribution and its potential for impact.**
   - *Writing implication*: State the contribution early, clearly, and specifically.
     Don't bury it. The abstract, introduction, and conclusion should all articulate
     the same core contribution in consistent terms. A reviewer skimming should find
     it within 30 seconds.

2. **New ideas, strong new directions, risk-taking with adequate rationale.**
   - *Writing implication*: Frame the work as opening a new direction, not as an
     incremental improvement. "We are the first to integrate X into Y" is stronger
     than "We improve Y by 2%." If the approach is unconventional, justify *why*
     the risk is worth taking --- don't apologize for novelty.

3. **Multidisciplinarity.**
   - *Writing implication*: ICMI welcomes social science, systems, ethnography,
     interviews, ML/deep learning, ethics/policy, and medical perspectives. If your
     work bridges disciplines (e.g., ML + HCI, affective computing + ethics), make
     that bridging explicit --- it's a strength, not a weakness.

4. **Technical soundness without major flaws, and clear writing.**
   - *Writing implication*: Every methodological choice needs justification. Every
     claim needs evidence. Transparency about methodology is non-negotiable ---
     reviewers are told that papers lacking transparency "may be challenged on
     soundness." Show your work.

## What Reviewers Are Told NOT to Reject For

This is equally important --- it tells you what you don't need to worry about:

- **Unimodal focus within multimodal context.** If part of your evaluation is
  unimodal (e.g., ablation with text only), that's fine. Reviewers are explicitly
  told not to penalize this.

- **Any methodology type.** Empirical studies, system papers, ethnographies,
  interview studies, ML papers --- all are welcome. Don't feel pressure to be
  a pure ML paper if your contribution is elsewhere.

- **Minor flaws.** Reviewers are told these "can be corrected post-review."
  Don't obsess over perfection at the cost of substance. A paper with a strong
  contribution and a typo in Table 3 beats a polished paper with no contribution.

- **ArXiv preprints.** Explicitly stated: not an anonymity violation. You can
  have your paper on arXiv during review.

## What Triggers Mandatory Rejection

- **Prior publication** without substantial expansion (>25% new content).
- **Simultaneous submission** to another venue.
- (Not stated in reviewer guidelines but from author guidelines: **exceeding
  page limits**, **non-anonymous submission**.)

## How to Write Defensively Against Weak Reviews

Reviewers are held to quality standards. Their reviews must be:
- At minimum 2--3 paragraphs to a full page, with **specific evidence** for critiques.
- They cannot claim ideas are "well known" without citing sources.
- They cannot claim "major technical flaws" without describing the specific problems.
- Meta-reviewers can override or discard reviews that lack substantiation.

**What this means for your writing:**

1. **Preempt "well known" dismissals.** If your approach builds on established
   techniques, acknowledge this explicitly and explain what is *new* about your
   application or combination. "Cross-modal attention is well-established
   (Author, Year); our contribution is its extension to three modalities with
   a trainable FER encoder in the fusion loop, which has not been explored."

2. **Make the contribution undeniable.** State it so clearly that a reviewer
   cannot write "the contribution is unclear" without contradicting the text.
   The contribution should appear in the abstract, introduction (contribution
   paragraph), and conclusion.

3. **Close off "obvious baseline" attacks.** Include relevant baselines and
   ablations. If you don't compare against an obvious method, a reviewer will
   ask why. Preemptively address this in the experimental setup: "We do not
   compare against X because [reason]."

4. **Be transparent about limitations.** Reviewers are told to value honesty.
   A paper that acknowledges its limitations reads as mature and self-aware.
   A paper that ignores obvious weaknesses invites the reviewer to list them
   as fatal flaws.

5. **Provide concrete examples.** Award-quality reviews (which are shown to
   reviewers as models) identify "unstated assumptions and vague concepts."
   Counter this by being specific: use concrete examples from your data,
   state assumptions explicitly, define all terms.

## Evaluation Dimensions (Implicit from Guidelines)

Based on what reviewers are told to assess, ensure your paper is strong on:

| Dimension | What reviewers look for | How to satisfy it |
|-----------|------------------------|-------------------|
| Novelty | New ideas, new directions, not just replication | Frame as opening a direction, not incremental |
| Impact | Potential to influence the field | Connect to real problems, not just benchmarks |
| Technical soundness | No major methodological flaws | Justify every choice, show complete pipeline |
| Transparency | Full methodology disclosure | Reproducible detail in Method + Experiments |
| Writing quality | Clear, well-structured prose | Varied tone per section, no AI-sounding filler |
| Ethical awareness | Safe and Responsible Innovation Statement | ~100 words, specific to your work, not generic |
| Positioning | Fair treatment of related work | Don't straw-man baselines, acknowledge limitations |

## Blue Sky Papers (Different Criteria)

If submitting a Blue Sky paper, reviewers evaluate differently:
- **Breadth of knowledge** across fields
- **Creativity and novelty** of ideas
- **Provocativeness** --- challenging existing assumptions is valued
- **Depth of reflection** and **soundness of arguments**
- **Visionary quality** --- where is the field going?

Unconventional ideas and ideas conflicting with existing beliefs are explicitly
protected from dismissal. High-risk novel papers are encouraged.

## Reviewer Confidentiality (Awareness)

Reviewers are told:
- They cannot upload submission content to third-party systems (including LLMs)
  unless confidentiality is guaranteed.
- Submissions are not public disclosures; authors consider work proprietary.
- Reviewers must destroy copies after review completion.

This means your paper will be read carefully by humans, not processed through
automated tools. Write for a human reader.
