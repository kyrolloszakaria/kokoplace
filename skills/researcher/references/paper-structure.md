# Paper Structure: Section-by-Section Writing Guide

This reference covers how to write each section of an ICMI-style research paper.
The guidance here is opinionated — it reflects what experienced reviewers look for
and what separates accepted papers from rejected ones.

## Abstract (150–250 words)

The abstract is a standalone mini-paper. It should contain:

1. **The problem** (1-2 sentences): What specific problem are you solving? Be concrete.
2. **Why it's hard or important** (1 sentence): What makes this non-trivial?
3. **Your approach** (2-3 sentences): What did you do? Name your method/system.
4. **Key results** (2-3 sentences): Numbers. "We achieve X on Y, outperforming Z by W%."
5. **Implication** (1 sentence): Why should the reader care about this result?

Common mistakes:
- Being too vague ("we propose a novel approach" — novel how?)
- No quantitative results in the abstract
- Starting with "In recent years..." (boring, wastes space)
- Trying to cover everything — pick the most important result

## Introduction (1–1.5 pages for a long paper)

The introduction tells a *story* that ends with your contribution. A reliable structure:

**Opening paragraph**: Introduce the specific problem in concrete terms. Don't start with
the history of AI or multimodal interaction. Start with the thing that's broken or missing.
"When users interact with conversational agents, they frequently express emotions through
combinations of speech prosody and facial expression that are missed by unimodal systems."

**Problem paragraph**: Explain why existing solutions fall short. Be specific about their
limitations — cite them. "Prior work on multimodal emotion recognition (Author, Year;
Author, Year) has primarily focused on acted datasets, leaving a gap in understanding
spontaneous emotional expressions in real interactions."

**Insight/approach paragraph**: Introduce your key idea. What is your angle? Why is your
approach different? "We observe that temporal alignment between modalities carries
discriminative information that existing fusion methods discard..."

**Contribution paragraph**: Clearly state what you deliver. Be precise:
- "We introduce [method name], a [brief description]"
- "We evaluate on [dataset] and demonstrate [specific improvement]"
- "We release [dataset/code/model] to support future research"

Keep contribution claims factual and verifiable. A reviewer should be able to check each one
against the paper's content.

**Paper outline** (optional, 1 sentence): "Section 2 reviews related work, Section 3..." —
Some venues expect this; at ICMI it's optional. If included, keep it to one sentence.

## Related Work (1–1.5 pages)

Related work is NOT a literature survey. It's an argument for why your paper needs to exist.

**Organize thematically, not chronologically.** Group related work into 2-4 themes relevant
to your paper. For example:
- "Multimodal fusion approaches" (if your contribution is a new fusion method)
- "Emotion recognition in conversation" (if that's your application domain)
- "Temporal modeling of multimodal signals" (if that's your technical angle)

**For each group:**
1. Summarize the general approach of this research thread (2-3 sentences)
2. Cite the most important works and briefly explain what each contributes
3. Identify the gap that your work fills

**Positioning matters more than coverage.** You don't need to cite every paper on the topic.
You need to cite the papers that a reviewer would expect to see, and explain how yours
differs from or builds on them.

**End with a transition** that makes clear what's missing in the landscape and how your
paper fills it. This should connect directly to your contribution statement from the intro.

**Writing style for related work:**
- Don't just list papers: "X did A. Y did B. Z did C." Instead, synthesize and compare:
  "While X and Y both address fusion at the feature level, Z showed that decision-level
  fusion can be more robust to missing modalities."
- Use consistent citation style (first author or short label)
- Be fair to prior work — don't straw-man to make your approach look better

## Method / Approach (2–3 pages for a long paper)

This section should enable a competent researcher to reimplement your approach.

**Start with an overview.** Before diving into details, give a 1-paragraph or figure-based
overview of your approach. What are the major components? How do they fit together? A system
diagram (as a figure) is worth a thousand words here.

**Structure by component, not by chronology.** Don't describe things in the order you built
them. Describe them in the order that's easiest to understand. Usually: input representation →
core method → training/optimization → inference.

**Be precise about:**
- Input representation (what does the model see?)
- Architecture details (layers, dimensions, attention heads — but only the important ones)
- Loss functions (write them out mathematically)
- Training procedure (optimizer, learning rate, schedule, epochs, batch size)
- Any preprocessing or data augmentation

**Use math when it helps, prose when it doesn't.** Don't add equations just to look
technical. An equation should clarify something that's hard to explain in words. Always
define your notation before or immediately after using it.

**Name your method.** Give it a memorable, descriptive name. This helps reviewers and future
researchers refer to it. Avoid overly clever acronyms that don't actually describe anything.

## Experiments / Evaluation (2–3 pages)

### Experimental Setup
- **Dataset(s)**: Name, size, modalities, splits, any preprocessing
- **Baselines**: What you're comparing against and why those were chosen
- **Metrics**: What you're measuring and why those metrics are appropriate
- **Implementation details**: Hardware, frameworks, hyperparameters, training time

### Results
- Present main results in a clear table
- **Highlight the important comparisons** — don't expect the reader to scan a 20-row table
  to find the takeaway
- Report appropriate statistics (mean ± std over multiple runs, significance tests where
  warranted)
- If results are mixed (yours wins on some metrics, loses on others), be honest about it
  and explain why

### Analysis (ablations, error analysis, qualitative examples)

This is where good papers separate from average ones:

- **Ablation study**: Remove components one at a time to show each one matters
- **Error analysis**: Look at failure cases. What goes wrong and why? This shows deep
  understanding and gives future researchers direction.
- **Qualitative examples**: Show specific instances where your method succeeds or fails.
  For ICMI, this might mean showing specific multimodal interaction moments.
- **Parameter sensitivity**: If applicable, show how performance varies with key hyperparameters

## Discussion (0.5–1 page)

The discussion is your chance to think out loud about what the results mean.

- **Interpret the findings**: Why does your approach work? What's the mechanism?
- **Connect to related work**: Do your findings confirm or contradict prior work?
- **Broader implications**: What does this mean for the field? (Be measured, not grandiose)
- **Limitations**: Be honest. Reviewers respect papers that acknowledge their own weaknesses.
  Common limitations to address: dataset size/diversity, generalizability, computational cost,
  specific failure modes.
- **Future work**: Brief, specific, actionable. Not "we plan to explore more modalities"
  but "extending to the audio-visual-physiological setting would test whether our fusion
  approach generalizes beyond two modalities."

## Conclusion (0.25–0.5 page)

Short and direct. Restate the core contribution and main finding. Do NOT just copy the
abstract. The conclusion can afford to be slightly more reflective than the abstract.

Don't introduce new information in the conclusion. Don't over-promise future work.

## References

- Use consistent formatting (BibTeX handles this, but check for errors)
- Include all papers cited in the text (and only those)
- Prefer published versions over arXiv preprints when both exist
- Include DOIs when available (ACM appreciates this)
- Check for common BibTeX issues: inconsistent author names, missing years, wrong venue names
