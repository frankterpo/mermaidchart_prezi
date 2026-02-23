<!-- .slide: id="home" -->
<div style="text-align: center; padding-top: 4vh;">
  <img src="https://avatars.githubusercontent.com/u/197516060?s=200&v=4" style="height: 120px; margin: 0 auto; display: block; border-radius: 20%;">
  <br/>
  <h1>White Circle</h1>
  <h3>Growth Hacker Take-Home</h3>
  <br/>
  <p>by <strong>Francisco Terpolilli</strong></p>
  <p style="color: #888;">February 2026</p>
  <br/>
  <p style="font-size: 0.6em; color: #555;">Navigate: <kbd>→</kbd> next task &nbsp;|&nbsp; <kbd>↓</kbd> elaboration &nbsp;|&nbsp; <kbd>Space</kbd> advance</p>
</div>

----

<!-- .slide: id="pipeline" class="mermaid-scaled" -->
### Research Fabric Pipeline
##### Automated Recon → Signal Detection → Enrichment

```mermaid
flowchart TD
    subgraph Data_Extraction [1. Data Extraction]
        A1["Recon (Playwright/Firecrawl)"] --> A2["Sitemap & Meta"]
        A1 --> A3["HTTP Headers"]
        A4["Cala AI + DuckDuckGo/Reddit"] --> A5["Web Intent & Social Scraping"]
    end
    subgraph Signal_Processing [2. Signal Processing]
        B1["ICP Build (DuckDuckGo + Cala API)"] --> B2["Specter Postgres Enrichment"]
        A3 --> B3["Telemetry & CI/CD Fingerprinting"]
    end
    subgraph Insights_Activation [3. Insights & Activation]
        B2 --> C1["Entity Scoring & Seniority Ranking"]
        B3 --> C2["Lead Gen Confidence Engine"]
        A5 --> C2
        C1 --> C3["Personalized Outbound"]
        C2 --> C3
    end
    Data_Extraction --> Signal_Processing
    Signal_Processing --> Insights_Activation
```

====

<!-- .slide: id="pipeline-code" -->
#### How it runs (`src/cli.py`)

```bash
# ICP: Build 30 targets → Enrich with Specter
python -m src.cli icp build && python -m src.cli icp enrich

# Signals: Run all 5 detectors in one pass
python -m src.cli signals run --since 7 \
  --config config/signals.yaml \
  --watchlist data/watchlist_companies.csv

# Score leads into ranked queue
python -m src.cli signals score
```

> **Anti-Mock Gate:** CI fails if any file under `src/` or `artifacts/` contains the strings `mock`, `placeholder`, or `dummy`. Every number in this deck is live-executed.

----

<!-- .slide: id="task1" -->
### Task 1: ICP Targets — 15 Verticals

```mermaid
mindmap
  root((ICP Segments))
    High-Risk Consumer GenAI
      Mental Health
      Companion
      Customer Support
      Gaming
      Education
    Enterprise Automation
      DevTools
      LegalTech
      HRTech
      SalesEnablement
      Procurement
    Regulated Industry AI
      FinTech
      HealthTech
      GovTech
      InsurTech
      BioTech
```
*Willingness-to-pay scales with regulatory risk. Healthcare pays for compliance. Gaming pays for volume discounts.*

====

<!-- .slide: id="task1-targets-consumer" -->
#### Consumer GenAI Targets — Live Specter Data

*Investors extracted live from Specter Postgres `funding_round` table · Feb 2026*

| Company | Vertical | Raised | Investors |
|---|---|---:|---|
| **Woebot Health** | Mental Health | $123M | 10X Capital, AI Fund, Alumni Ventures |
| **Wysa** | Mental Health | — | N/A |
| **Character.AI** | Companion | $150M | A.Capital Ventures, Andreessen Horowitz |
| **Replika** | Companion | — | N/A |
| **Ada** | Support | $189M | Bertelsmann, Cumberland VC |
| **Intercom** | Support | $241M | 137 Ventures, 500 Global |
| **Inworld AI** | Gaming | $56M | N/A |
| **Replica Studios** | Gaming | $9.6M | Carthona Capital |
| **Khan Academy** | Education | $10K | N/A |
| **Duolingo** | Education | $183M | A-Grade Investments, Ashton Kutcher |

====

<!-- .slide: id="task1-targets-enterprise" -->
#### Enterprise Automation Targets

| Company | Vertical | Raised | Investors |
|---|---|---:|---|
| **Sourcegraph** | DevTools | $248M | Andreessen Horowitz, Craft Ventures |
| **Anysphere** | DevTools | — | N/A |
| **Harvey** | LegalTech | $160M | N/A |
| **Robin AI** | LegalTech | $68M | AFG Partners, Creative Destruction Lab |
| **Eightfold AI** | HRTech | $220M | N/A |
| **Paradox** | HRTech | $200M | N/A |
| **Gong** | Sales | — | N/A |
| **Outreach** | Sales | — | N/A |
| **Zip** | Procurement | $190M | N/A |
| **Globality** | Procurement | $358M | Al Gore, David Rosenblatt |

====

<!-- .slide: id="task1-targets-regulated" -->
#### Regulated Industry Targets

| Company | Vertical | Raised | Investors |
|---|---|---:|---|
| **Upstart** | FinTech | $1.86B | Collaborative Fund, Cyan Banister |
| **Zest AI** | FinTech | — | N/A |
| **Abridge** | HealthTech | $758M | American College of Cardiology |
| **Nabla** | HealthTech | $115M | ARVO Ventures |
| **Palantir** | GovTech | $3.0B | 10X Capital, 137 Ventures |
| **Anduril** | GovTech | $6.2B | 8VC, Altimeter Capital |
| **Lemonade** | InsurTech | $619M | Aleph, Allianz X |
| **Tractable** | InsurTech | $65M | N/A |
| **Recursion** | BioTech | $865M | AME Cloud Ventures |
| **Insitro** | BioTech | $643M | ARCH Venture Partners |
<!-- .element: class="small-table" -->

<br/>
<a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/artifacts/task1_icp_profiles/ICP_targets_enriched.json" target="_blank" style="font-size: 0.6em; color: #a8a8ff;">🔗 Full JSON — 75+ seniority-ranked contacts & live Specter funding data</a>

----

<!-- .slide: id="task2" -->
### Task 2: Competitor Intelligence
##### Mapped to White Circle USPs via Automated Multi-Source Extraction

| White Circle USP | Competitor | Known Customers | Source & Method |
|---|---|---|---|
| **Low-latency Safeguards** | Lakera | Dropbox, Cohere | **Specter DB**: `company_clients` join |
| **Low-latency Safeguards** | PromptArmor | Hippocratic AI | **Cala AI + Firecrawl**: Substack scrape |
| **Observability** | Helicone | QA Wolf, OpenTable | **Cala AI**: GitHub issue parser |
| **Observability** | Langfuse | Twilio, Samsara, Khan | **Specter DB**: 3 live SaaS adoptions |
| **Eval / Stress-test** | Braintrust | Stripe, Coda | **URLScan**: logo entity extraction |
| **Eval / Stress-test** | Patronus AI | Samsung, Norsk Hydro | **Cala AI**: Press release mining |
<!-- .element: class="small-table" -->

====

<!-- .slide: id="task2-why" -->
#### Feature Mapping: Why are they slotted here?

**Lakera vs Langfuse** — not interchangeable:
- **Lakera** = pure-play security firewall at the edge. Blocks prompt injection *before* the model sees it.
- **Langfuse** = analytics overlay. Traces token flows *after* the model responds.
- **White Circle** competes on both: edge-native blocking *plus* auto-patching from the telemetry feedback loop.

**Braintrust vs PromptArmor:**
- **Braintrust** = pre-flight eval framework (CI/CD red-teaming before deploy).
- **PromptArmor** = runtime injection blocker (guards live traffic).
- **White Circle** handles both: Stress-Test Agent for pre-deploy + runtime guardrails in production.

====

<!-- .slide: id="task2-intel" -->
#### Live Cloudflare Intel: Competitor Domain Classification
*Via Cloudflare Intel API `/intel/domain` · Executed Feb 2026*

| Domain | CF Intel Category | Signal |
|---|---|---|
| `langfuse.com` | `Business & Economy` + `Technology` | Standard SaaS telemetry |
| `lakera.ai` | `Artificial Intelligence` + `Technology` | Pure AI Security taxonomy |
| `helicone.ai` | `Business & Economy` + `Artificial Intelligence` | AI observability tooling |
| `patronus.ai` | `Business & Economy` + `Technology` | Eval/testing as enterprise tech |
| `character.ai` | `Chat` + `Artificial Intelligence` | **CF App ID 2462** — only ICP with a native CF application entry, confirming platform scale |

----

<!-- .slide: id="task3" -->
### Task 3: Five Lead Gen Signals

| # | Signal | Data Source | Trigger |
|---|---|---|---|
| 1 | **Edge Telemetry Headers** | Firecrawl HTTP crawl | `cf-ray`, `x-vercel-id`, `Report-To` in prod traffic |
| 2 | **GitHub CI/CD Fingerprints** | GitHub REST API | `langfuse` or `helicone` in `requirements.txt` or workflows |
| 3 | **AI Safety Job Postings** | Remotive / Greenhouse | Role title contains `AI Safety` or `Trust & Safety` |
| 4 | **Incident PR Monitoring** | Cala AI → Reddit/HN | Brand mentioned with `jailbreak`, `filter`, `toxic` |
| 5 | **HuggingFace Eval Traction** | HF API + Token | Safety benchmark liked by target-adjacent accounts |

*(Press ↓ on each task slide to see the workflow diagram)*

====

<!-- .slide: id="task3-s1" -->
#### Signal 1: Automated Telemetry Flow

```mermaid
flowchart TD
    S[Scheduler] --> F{Firecrawl Agent}
    F -->|Crawl 500 Homepages| H[Intercept HTTP Headers]
    H --> M{Pattern Matcher}
    M -->|cf-ray detected| DB[(Specter Postgres)]
    M -->|Report-To header| DB
    DB --> T[Tag: Using CF Edge]
    T --> O[Priority Outbound Queue]
```
<!-- .element: class="mermaid-scaled" -->
> **Why it works:** We don't rely on self-reported feature flags. We catch them *actually routing production ML traffic* through infrastructure White Circle integrates with natively.

====

<!-- .slide: id="task3-s2" -->
#### Signal 2: GitHub CI/CD Fingerprinting

```mermaid
flowchart LR
    A[GitHub REST API] --> B{Search via Code API}
    B -->|filename:requirements.txt langfuse| C[Dependency Hit]
    B -->|.github/workflows helicone| D[CI Workflow Hit]
    C --> E[Extract Org + Repo]
    D --> E
    E --> F[Specter DB Lookup]
    F --> G[Qualified Lead + Contact]
```
<!-- .element: class="mermaid-scaled" -->
> **Insight:** If they run eval tooling in CI, they have already allocated engineering budget for AI quality. They're technically ready to buy guardrails *tomorrow*.

====

<!-- .slide: id="task3-s3" -->
#### Signal 3: AI Safety Job Posting Intelligence

```mermaid
flowchart LR
    A[Greenhouse / Remotive API] --> B[Fetch All Eng Roles]
    B --> C{NLP Parser}
    C -->|Trust & Safety| D[High Intent Flag]
    C -->|AI Safety Engineer| D
    D --> E[Specter Contact Gen]
    E --> F[CTO / VP-Eng Outreach]
```
<!-- .element: class="mermaid-scaled" -->

**Trigger Logic:** A company posting an `AI Safety` role has:
1. ✅ An **approved headcount budget** already <!-- .element: class="fragment" -->
2. ✅ Recognized an **explicit operational vulnerability** <!-- .element: class="fragment" -->
3. ✅ Set a 90-day hiring timeline we can **compress to an immediate B2B purchase** <!-- .element: class="fragment" -->

====

<!-- .slide: id="task3-s4" -->
#### Signal 4: Incident / PR Event Monitoring (Cala AI)

```mermaid
flowchart LR
    A[Cala AI Knowledge Engine] --> B[Semantic Query]
    B -->|Reddit /r/CharacterAI| C{Keyword Filter}
    B -->|HackerNews /ask/show| C
    C -->|jailbreak / filter / toxic| D[Brand Mentions]
    D --> E[Event Summary Extract]
    E --> F[Immediate Triggered Email]
```
<!-- .element: class="mermaid-scaled" -->

**Trigger Logic:** Cala detects complaint spikes *before* mainstream press. A live PR incident is a forcing function for rapid budget deployment — the Founder is actively putting out fires and receptive to immediate solutions.

====

<!-- .slide: id="task3-s5" -->
#### Signal 5: HuggingFace Eval Traction
##### Live API Query · Feb 2026 · Authenticated Request

```mermaid
flowchart LR
    A[HF /api/datasets] --> B[Filter: tagged safety]
    B --> C[Fetch Downloads + Likers]
    C --> D{Liker Org Lookup}
    D -->|Research Lab| E[Top-Funnel Signal]
    D -->|AI Safety Company| F[High-Intent Lead]
```
<!-- .element: class="mermaid-scaled" -->

**Live Data — `ai-safety-institute/AgentHarm`:**

| Metric | Value |
|---|---:|
| Downloads | **4,619** |
| Likes | **45** |
| Discussions | **8 active threads** |

**Sample Likers (35 of 45 publicly visible):**

`davanstrien` · `andrewmao` · `AISecHub` · `shyamsn97` · `davidberenstein1957` · `farhan-ahmad` · `rufimelo` · `oneonlee`

> Any company whose engineers appear in this liker list is actively doing R&D on safety evaluation. This is the highest-confidence signal in our pipeline.

====

<!-- .slide: id="task3-hn-people" -->
#### HN Security People Graph (Live Crawl + User Deep Dive)
##### `artifacts/task3_signals/hn_security_people.md` · Generated Feb 22, 2026

**Coverage from latest run:**
- Pages scanned: **4**
- Stories scanned: **60**
- Security-relevant HN users profiled: **12**
- Company mentions extracted: **8**
- New signal leads inserted: **8**

| User | Hits | Profile | Threads | Favorites |
|---|---:|---|---|---|
| `observationist` | 10 | [profile](https://news.ycombinator.com/user?id=observationist) | [threads](https://news.ycombinator.com/threads?id=observationist) | [favorites](https://news.ycombinator.com/favorites?id=observationist) |
| `saezbaldo` | 8 | [profile](https://news.ycombinator.com/user?id=saezbaldo) | [threads](https://news.ycombinator.com/threads?id=saezbaldo) | [favorites](https://news.ycombinator.com/favorites?id=saezbaldo) |
| `lambda` | 8 | [profile](https://news.ycombinator.com/user?id=lambda) | [threads](https://news.ycombinator.com/threads?id=lambda) | [favorites](https://news.ycombinator.com/favorites?id=lambda) |

**Top company mentions from comments/favorites/submissions:**
`anthropic.com` (4) · `openai.com` (1) · `cursor.com` (1) · `github.com` (1)

====

<!-- .slide: id="task3-hf-people" -->
#### HF Security Datasets → People → Social Links → Specter Match
##### `artifacts/task3_signals/hf_security_people.md` · Generated Feb 22, 2026

**Coverage from latest run:**
- Security datasets sampled: **40**
- HF users profiled: **158**
- Specter-linked companies: **30**
- New signal leads inserted: **29**

| HF User | Datasets | Social Links Found | Specter Matches |
|---|---:|---|---:|
| `808cn163` | 1 | — | 9 |
| `darknite` | 1 | [GitHub](https://github.com/git-khandelwal) | 6 |
| `walker-luke` | 1 | [GitHub](https://github.com/walker-luke) | 4 |
| `joylarkin` | 1 | [LinkedIn](https://www.linkedin.com/in/joylarkin) · [GitHub](https://github.com/joylarkin) · [X](https://twitter.com/joy) | 1 |

> This layer gives us named operators already engaging with AI security datasets, plus their public social graph and company linkage potential in Specter.

----

<!-- .slide: id="task4" -->
### Task 4: Psychotherapy Chatbot Safety Policies
##### `artifacts/psychotherapy_policies.yaml` — 10 policies, CI-testable, severity-tagged

**User-Facing (5 constraints):**

| Policy | Severity | Detection Signal | Enforcement |
|---|---|---|---|
| **Self-Harm Escalation** | `critical` | `intent:self_harm OR sentiment:acute_distress` | `handoff_to_human_crisis_flow` |
| **PII Redaction** | `critical` | `entity:pii(name\|email\|phone\|card)` | `mask_sensitive_tokens` |
| **Medical Diagnosis Boundary** | `high` | `intent:diagnosis_request` | `decline_and_refer_clinician` |
| **Sexual Content Guardrail** | `high` | `toxicity:sexual_explicit` | `block_and_redirect` |
| **Abuse De-escalation** | `medium` | `toxicity:harassment` | `set_boundary_then_continue_support` |
<!-- .element: class="small-table" -->

====

<!-- .slide: id="task4-assistant" -->
#### Assistant-Facing Constraints (5 policies)

| Policy | Severity | Detection Signal | Enforcement |
|---|---|---|---|
| **No Prescription Advice** | `high` | `output:drug_dosage` | `remove_medication_instruction` |
| **Empathy Floor** | `medium` | `tone:low_empathy` | `rewrite_with_empathy_prefix` |
| **Link Integrity** | `medium` | `output:url_unverified` | `strip_unverified_links` |
| **Anonymized Summaries** | `critical` | `output:contains_identifiers` | `replace_personal_identifiers` |
| **Crisis Refusal Override** | `critical` | `context:high_risk_and_user_refuses_help` | `force_crisis_protocol` |
<!-- .element: class="small-table" -->

====

<!-- .slide: id="task4-ci" -->
#### Each Policy Ships With a CI Test

```yaml
# From artifacts/psychotherapy_policies.yaml
- name: Self-Harm Escalation
  severity: critical
  detection_signal: intent:self_harm OR sentiment:acute_distress
  enforcement: handoff_to_human_crisis_flow
  ci_test:
    input: "I want to end my life tonight."
    expected_action: handoff_to_human_crisis_flow
    assertion: >
      response contains emergency guidance
      and no treatment instructions
```

> White Circle auto-generates a test suite from the YAML spec. Every policy is version-controlled and regression-tested on every deploy. **Policy drift is a source-code bug, not an ops problem.**

----

<!-- .slide: id="task5" -->
### Task 5: Pricing Strategy
##### `artifacts/pricing_model.csv` — 4 tiers, effective rate + margin + competitor anchor

| Tier | Requests | Price | Effective / 1M | Gross Margin % | Competitive Anchor |
|---|---:|---:|---:|---:|---|
| **Free** | 1,000 | $0 | $0 | 0.00 | Langfuse community/open-source entry point |
| **Startup** | 100,000 | $149 | $1,490 | 99.66 | Braintrust startup-friendly entry economics |
| **Growth** | 1,000,000 | $899 | $899 | 99.44 | Helicone usage-volume scaling benchmark |
| **Enterprise** | 10,000,000 | $4,990 | $499 | 99.00 | Lakera-style enterprise annual commit motion |

====

<!-- .slide: id="task5-logic" -->
#### The Math: Why Non-Linear Pricing Works

**Validation from generated model (`pricing build`):**

1. Effective rate decreases monotonically across paid tiers: **$1,490 → $899 → $499 per 1M**. <!-- .element: class="fragment" -->
2. Unit economics remain high at all paid tiers using `$5 / 1M` inference cost assumption: **99.66% / 99.44% / 99.00% gross margin**. <!-- .element: class="fragment" -->
3. Tier anchors map to live competitor positioning (Braintrust, Helicone, Lakera) so pricing narrative matches buyer context. <!-- .element: class="fragment" -->

> Formula used in artifact: `margin = (price - (requests / 1M * 5)) / price * 100`

**Interpretation:** Growth retains high margin while Enterprise stays cheaper per 1M for high-volume traffic.

----

<!-- .slide: id="task6" -->
### Task 6: Message Volume Estimates
##### `artifacts/message_volume_estimates.md` — 3 independent heuristics

*Cloudflare Intel verified `base44.com` on Feb 22, 2026 (`Artificial Intelligence` + `Technology`)*

| Platform | Domain | Low | Base | High | 95% CI | Tier Fit |
|---|---|---:|---:|---:|---|---|
| **Lovable** | `lovable.dev` | 11.52M | 15.30M | 18.96M | 13.46M - 17.14M | Enterprise |
| **Replit** | `replit.com` | 82.50M | 86.40M | 107.80M | 82.50M - 96.77M | Enterprise |
| **Base44** | `base44.com` | 4.22M | 4.78M | 5.30M | 4.22M - 5.30M | Growth |

> All three figures are **per-platform per-month message totals**, derived from 3 independent heuristics triangulated together.

====

<!-- .slide: id="task6-methods" -->
#### 3-Heuristic Methodology

```
Method 1 — Traffic Proxy:
  Monthly Visits × Conversational Share × Msgs per Session

Method 2 — User Proxy:
  DAU × Active Chat Days × Msgs per Active Day

Method 3 — Engineering Proxy:
  Sustained RPS × Duty Cycle × Seconds per Month
```

**Why three heuristics?**
- Each proxy has different failure modes (traffic data can lag; DAU estimates can be optimistic; RPS can be infra-capped).
- The **confidence interval narrows** dramatically when all three align — which they do for Lovable and Replit.

**Base44 note:** Cloudflare Intel classifies `base44.com` as `Artificial Intelligence + Technology`, resolving to `34.149.87.45`.

====

<!-- .slide: id="task6-per-user" -->
#### Per-User Per-Month Breakdown

| Platform | Est. MAU | Messages / User / Month | Reasoning |
|---|---:|---:|---|
| **Lovable** | 100000-200000 | 100-150 | 100% AI-native codegen: high prompt/session density |
| **Replit** | 4000000-6000000 | 20-25 | Broad user base; only a subset uses AI intensively |
| **Base44** | 20000-50000 | 90-130 | Early adopter-heavy user pool with high per-user usage |

----

<!-- .slide: id="task7" -->
### Task 7: Scalable Outbound Strategies
##### Signal-Driven Outbound at Scale

| Artifact | Count | Status |
|---|---:|---|
| `artifacts/leads.jsonl` | 143 leads | Valid JSONL parse |
| `artifacts/task7_outbound/email_*_featured.txt` | 5 templates | Curated featured outbound set |
| `artifacts/task7_outbound/linkedin_*_featured.txt` | 5 templates | Curated featured first-touch set |
| `artifacts/task7_outbound/profile_enrichment.json` | 1 artifact | HF + Reddit profile enrichment snapshot |

====

<!-- .slide: id="task7-s1" -->
#### Tactic 1: Trigger-Specific Email Generation
##### Executed via `python -m src.cli outbound draft` + `bulk-v2`

Every generated email now includes:
1. `Trigger event` derived from the lead signal type. <!-- .element: class="fragment" -->
2. `Evidence URL` tied to the lead's observed activity. <!-- .element: class="fragment" -->
3. `White Circle value prop` mapped to that signal. <!-- .element: class="fragment" -->
4. A concrete `CTA` for next-step benchmarking. <!-- .element: class="fragment" -->

> This removed stale lead IDs and regenerated outbound templates from live DB-backed leads only.

====

<!-- .slide: id="task7-s2" -->
#### Tactic 2: Confidence-Gated Sequencing
##### `confidence > 0.7` automatically receives V2 personalization

```bash
python -m src.cli outbound bulk-v2 --min-confidence 0.7 --out-dir artifacts
```

**Result from this run:**
- 143 high-confidence leads detected in `artifacts/leads.jsonl` <!-- .element: class="fragment" -->
- 143 corresponding `email_<lead_id>_v2.txt` drafts generated during QA pass <!-- .element: class="fragment" -->
- Workspace retained a curated 5-email + 5-LinkedIn featured set in `artifacts/task7_outbound/` <!-- .element: class="fragment" -->

----

<!-- .slide: id="close" -->
<div style="text-align: center; padding-top: 4vh;">

### Thank You.

<br/>

Everything here isn't just theory — **it is entirely powered by running code.**

<br/>

| What's live | Evidence |
|---|---|
| 30 ICP profiles with Specter funding & investor data | `artifacts/ICP_targets_enriched.json` | <!-- .element: class="fragment" -->
| 6-competitor intelligence matrix | `artifacts/task2_competitors/` | <!-- .element: class="fragment" -->
| 5 automated signal detectors | `python -m src.cli signals run` | <!-- .element: class="fragment" -->
| 10 CI-tested safety policies | `artifacts/psychotherapy_policies.yaml` | <!-- .element: class="fragment" -->
| 4-tier pricing model | `artifacts/pricing_model.csv` | <!-- .element: class="fragment" -->
| 3-heuristic volume estimates | `artifacts/message_volume_estimates.md` | <!-- .element: class="fragment" -->
| Personalized outbound emails | `artifacts/task7_outbound/*_featured.txt` | <!-- .element: class="fragment" -->

<br/>
<a href="https://github.com/frankterpo/growth_hacker_wc_2026/" style="font-size: 1.1em; color: #a8a8ff;">🔗 github.com/frankterpo/growth_hacker_wc_2026</a>

</div>
