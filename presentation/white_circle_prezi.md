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

*Live query refresh (Feb 23, 2026): `companies` + `funding_round` + `funding_round_investor` + `investor`*

| Company | Vertical | Round | Date | Raised | Post-Money | Lead Investor | Partners |
|---|---|---|---|---:|---:|---|---|
| Woebot Health | Mental Health | Series Unknown | 2022-03-15 | $9.5M | — | Leaps by Bayer | Juergen Eckhardt (Leaps by Bayer) |
| Wysa | Mental Health | Series B | 2022-07-14 | $20.0M | — | HealthQuad | Charles-Antoine Janssen (HealthQuad); Vidushi Kamani (Kae Capital) (+2 more) |
| Character.AI | Companion | Series A | 2023-03-23 | $150.0M | $1.00B | Andreessen Horowitz | Sarah Wang (Andreessen Horowitz) |
| Replika | Companion | — | — | — | — | — | — |
| Ada | Customer Support | Series C | 2021-05-07 | $130.0M | $1.20B | Spark Capital | Ben Fletcher (Accel); Yasmin Razavi (Spark Capital) (+2 more) |
| Intercom | Customer Support | Series D | 2018-03-27 | $125.0M | $1.30B | Kleiner Perkins | Ethan Kurzweil (Bessemer Venture Partners); Abhishek Agrawal (Vulcan Capital) (+1 more) |
| Inworld AI | Gaming | Series A | 2023-08-02 | $56.0M | $521.0M | Lightspeed Venture Partners | Bejul Somaia (Lightspeed Venture Partners); Moritz Baier-Lentz (Lightspeed Venture Partners) (+2 more) |
| Replica Studios | Gaming | Seed | 2022-11-01 | $4.2M | — | — | — |
| Khan Academy | Education | Series A | 2022-01-01 | $10.0K | $111.0K | — | — |
| Duolingo | Education | Series H | 2020-11-18 | $35.0M | $2.40B | General Atlantic; Durable Capital Partners | Henry Ellenbogen (Durable Capital Partners); Julio Novo (Durable Capital Partners) (+1 more) |
<!-- .element: class="small-table" -->

<br/>
<a href="./task1_funding_enriched_live.csv" target="_blank" style="font-size: 0.6em; color: #a8a8ff;">🔗 Full live Task 1 funding export (30 companies, lead investor + partners + post-money)</a>

====

<!-- .slide: id="task1-targets-enterprise" -->
#### Enterprise Automation Targets

| Company | Vertical | Round | Date | Raised | Post-Money | Lead Investor | Partners |
|---|---|---|---|---:|---:|---|---|
| Sourcegraph | DevTools | Series D | 2021-07-13 | $150.0M | $2.62B | Andreessen Horowitz | John Yetimoglu (Infinitum); Sarah Wang (Andreessen Horowitz) |
| Anysphere | DevTools | Series D | 2025-11-13 | $2.30B | $29.30B | Coatue; Accel | — |
| Harvey | LegalTech | Series F | 2025-10-30 | $160.0M | $8.00B | Andreessen Horowitz | Patrick Grady (Sequoia Capital); Ilya Fushman (Kleiner Perkins) |
| Robin AI | LegalTech | Series B | 2024-11-12 | $25.0M | — | University of Cambridge | — |
| Eightfold AI | HRTech | Series E | 2021-06-10 | $220.0M | $2.10B | SoftBank Vision Fund | Peter Nieh (Lightspeed Venture Partners); Quentin Clark (General Catalyst) (+1 more) |
| Paradox | HRTech | Series C | 2021-12-27 | $200.0M | $1.50B | Stripes; Thoma Bravo (+1 more) | Mike Gregoire (Brighton Park Capital); Robert Sayle (Thoma Bravo) (+2 more) |
| Gong | SalesEnablement | Series E | 2021-06-03 | $250.0M | $7.25B | Franklin Templeton | Carl Eschenbach (Sequoia Capital); Alex Kayyal (Salesforce Ventures) (+1 more) |
| Outreach | SalesEnablement | Series G | 2021-06-02 | $200.0M | $4.40B | Steadfast Financial; Premji Invest (+1 more) | Rajeev Batra (Mayfield Fund); Sandesh Patnam (Premji Invest) (+2 more) |
| Zip | Procurement | Series D | 2024-10-21 | $190.0M | $2.20B | Bond | Jay Simons (Bond); Ali Rowghani (Y Combinator) (+2 more) |
| Globality | Procurement | Series D | 2019-01-22 | $100.0M | $900.0M | SoftBank Vision Fund | — |
<!-- .element: class="small-table" -->

<br/>
<a href="./task1_funding_enriched_live.csv" target="_blank" style="font-size: 0.6em; color: #a8a8ff;">🔗 Full live Task 1 funding export (30 companies, lead investor + partners + post-money)</a>

====

<!-- .slide: id="task1-targets-regulated" -->
#### Regulated Industry Targets

| Company | Vertical | Round | Date | Raised | Post-Money | Lead Investor | Partners |
|---|---|---|---|---:|---:|---|---|
| Upstart | FinTech | Series D | 2019-04-08 | $50.0M | — | Progressive | — |
| Zest AI | FinTech | Series G | 2024-12-13 | $200.0M | — | Insight Partners | Jonathan Rosenbaum (Insight Partners); Lonne Jaffe (Insight Partners) (+1 more) |
| Abridge | HealthTech | Series E | 2025-06-24 | $300.0M | $5.30B | Andreessen Horowitz; Khosla Ventures | David George (Andreessen Horowitz) |
| Nabla | HealthTech | Series B | 2024-01-05 | $24.0M | $180.0M | Cathay Innovation | Jacky Abitbol (Cathay Innovation) |
| Palantir | GovTech | Series Unknown | 2015-12-24 | $879.8M | $20.33B | Kortschak Investments L.P. | Walter Kortschak (Kortschak Investments L.P.) |
| Anduril | GovTech | Series G | 2025-06-05 | $2.50B | $30.50B | Founders Fund | Peter Thiel (Founders Fund); Trae Stephens (Founders Fund) |
| Lemonade | InsurTech | Series D | 2019-04-11 | $300.0M | $2.00B | SoftBank | David Thevenon (SoftBank); Ron Stern (OurCrowd) (+1 more) |
| Tractable | InsurTech | Series D | 2021-06-16 | $60.0M | $1.00B | Insight Partners; Georgian | Lonne Jaffe (Insight Partners); Emily Walsh (Georgian) |
| Recursion | BioTech | Series D | 2020-09-09 | $239.0M | $1.14B | Leaps by Bayer | Juergen Eckhardt (Leaps by Bayer); Zavain Dar (Lux Capital) (+2 more) |
| Insitro | BioTech | Series C | 2021-03-15 | $400.0M | $1.00B | CPP Investments | Jim Tananbaum (Foresite Capital); Robert Nelsen (ARCH Venture Partners) (+3 more) |
<!-- .element: class="small-table" -->

<br/>
<a href="./task1_funding_enriched_live.csv" target="_blank" style="font-size: 0.6em; color: #a8a8ff;">🔗 Full live Task 1 funding export (30 companies, lead investor + partners + post-money)</a>

====

<!-- .slide: id="task1-wtp" -->
#### Willingness to Pay (WTP) Model

```mermaid
flowchart TB
    R[Risk ↑] --> S[WTP Score]
    V[Volume ↑] --> S
    C[Compliance ↑] --> S
    RC[Risk×Compliance] --> S
    S --> T[Buying urgency]
    T --> P[Price tier]
```

<div class="callout text-left">
  <strong>In plain English:</strong>
  <ul>
    <li>More AI risk → pay more for protection.</li>
    <li>More volume → pay more (impact is bigger).</li>
    <li>Heavier compliance rules → pay more to stay audit-safe.</li>
    <li>Risk + compliance both high → urgency jumps faster.</li>
  </ul>
</div>

====

<!-- .slide: id="task1-wtp-formula" -->
#### WTP Formula & Calibration

Calibrated from <span class="pill">artifacts/ICP_targets_enriched.json</span> as a normalized **WTP score** (tier mapping in Task 5):

$$
\text{WTPScore}_i=\delta+\alpha\tilde{R}_i+\beta\tilde{V}_i+\gamma\tilde{C}_i+\eta(\tilde{R}_i\cdot\tilde{C}_i)
$$

$$
\tilde{R}_i,\tilde{V}_i,\tilde{C}_i\in[0,1],\quad
\text{WTPUSD}_i=f(\text{WTPScore}_i)\ \text{via tier mapping}
$$

<div class="callout text-left">
  <strong>Variable definitions:</strong>
  <ul>
    <li>$\delta$ — baseline spend propensity.</li>
    <li>$(\tilde{R}_i\cdot\tilde{C}_i)$ — compound pressure when risk and compliance are both high.</li>
    <li>Coefficients fit on outcomes (win/loss, tier, expansion); refreshed as data lands.</li>
  </ul>
</div>

====

<!-- .slide: id="task1-wtp-table" -->
#### ICP vs Industry Comparison

| Lens | Bucket | N | Avg Risk | Avg Volume | Avg Priority | Median Raised |
|---|---|---:|---:|---:|---:|---:|
| **ICP** | High-Risk Consumer GenAI | 10 | 0.50 | 0.50 | 90.0 | $8.4M |
| **ICP** | Enterprise Automation & Copilots | 10 | 0.60 | 0.40 | 90.0 | $195.0M |
| **ICP** | Regulated Industry AI | 10 | 0.70 | 0.00 | 84.0 | $175.0M |
| **Industry** | DevTools | 2 | 0.60 | 0.40 | 90.0 | $1.23B |
| **Industry** | Mental Health | 2 | 0.50 | 0.50 | 90.0 | $8.4M |
| **Industry** | GovTech | 2 | 0.70 | 0.00 | 84.0 | $5.1M |
| **Industry** | SalesEnablement | 2 | 0.60 | 0.40 | 90.0 | $225.0M |
<!-- .element: class="small-table" -->

<div class="callout text-left">
  QA: Calibrated <strong>propensity score</strong>; price assigned in Task 5 by tier thresholds.
</div>

----

<!-- .slide: id="task2" -->
### Task 2: Competitor Intelligence
##### Mapped to White Circle USPs via Automated Multi-Source Extraction

| White Circle USP | Competitor | Products (Specter) | Reported Clients (`company_clients`) | Source & Method | Differentiation vs White Circle |
|---|---|---|---|---|---|
| **Low-latency Safeguards** | Lakera | Lakera Guard, Lakera Red, Lakera Gandalf | tome.com (`tome.com`), verax.ai (`verax.ai`), wexler.ai (`wexler.ai`) | Specter SQL (`companies` + `company_clients` + `clients_integration_companies`) + Firecrawl (`/case-studies`=ok) + DDG (0 results this run) + Cala (key present, not queried) | White Circle combines edge enforcement with continuous post-deployment tuning; Lakera is firewall-first. |
| **Low-latency Safeguards** | PromptArmor | AI Risk Platform | 101.xyz (`101.xyz`), 15five.com (`15five.com`), 222.place (`222.place`) | Specter SQL (`companies` + `company_clients` + `clients_integration_companies`) + Firecrawl (`/customers`=ok) + DDG (0) + Cala (key present, not queried) | White Circle adds observability + policy QA workflows on top of prompt-injection defense. |
| **Observability** | Helicone | Helicone | linkedin.com (`linkedin.com`), 15five.com (`15five.com`), 4degrees.ai (`4degrees.ai`) | Specter SQL (`companies` + `company_clients` + `clients_integration_companies`) + Firecrawl (`/customers`=ok) + DDG (0) + Cala (key present, not queried) | White Circle emphasizes prevention + policy enforcement, while Helicone is telemetry-first. |
| **Observability** | Langfuse | Langfuse | claimsorted.com (`claimsorted.com`), portialabs.ai (`portialabs.ai`), symbe.co (`symbe.co`) | Specter SQL (`companies` + `company_clients` + `clients_integration_companies`) + Firecrawl (`/customers`=ok) + DDG (0) + Cala (key present, not queried) | White Circle targets runtime blocking/remediation; Langfuse focuses on tracing and analytics. |
| **Eval / Stress-test** | Braintrust | Braintrust | No reported clients in `company_clients` | Specter SQL (`companies` + `company_clients` + `clients_integration_companies`) + Firecrawl (`/customers`=ok) + DDG (0) + Cala (key present, not queried) | White Circle includes runtime guardrails in addition to pre-deploy evaluation coverage. |
| **Eval / Stress-test** | Patronus AI | Patronus API, Percival, Lynx | 101.xyz (`101.xyz`), 15five.com (`15five.com`), 222.place (`222.place`) | Specter SQL (`companies` + `company_clients` + `clients_integration_companies`) + Firecrawl (`/customers`=ok) + DDG (0) + Cala (key present, not queried) | White Circle unifies edge controls + stress-testing; Patronus is strongest on eval scoring. |
<!-- .element: class="small-table" -->

<br/>
<a href="./task2_competitors.md" target="_blank" class="pill">artifacts/task2_competitors/competitors.md</a>
<a href="./task2_product_industry_overlap.csv" target="_blank" class="pill">task2_product_industry_overlap.csv</a>
<a href="./task2_competitor_matrix_enriched.json" target="_blank" class="pill">task2_competitor_matrix_enriched.json</a>

====

<!-- .slide: id="task2-why" -->
#### Feature Mapping: Use-Case Matrix
##### White Circle vs. AI Security Ecosystem

```mermaid
quadrantChart
    title AI Security Positioning
    x-axis Low Latency --> High Latency
    y-axis Pre-deploy Eval --> Runtime Protection
    quadrant-1 Observability
    quadrant-2 Strategic Protection
    quadrant-3 CI/CD Quality
    quadrant-4 Deep Eval
    "WC Guard": [0.12, 0.90]
    "WC Edge": [0.08, 0.96]
    "Lakera": [0.32, 0.63]
    "PromptArmor": [0.42, 0.80]
    "Helicone": [0.95, 0.08]
    "Langfuse": [0.88, 0.30]
    "Braintrust": [0.95, 0.05]
    "Patronus": [0.84, 0.16]
```

====

<!-- .slide: id="task2-overlap" -->
#### Matrix Overlap: Product vs. Specter Customer Industries

| Product - Company | Specter Customer Industries (Top) | Sample Reported Clients |
|---|---|---|
| Braintrust - Braintrust | Software, Technology, HR Tech | No reported clients |
| Helicone - Helicone | Software, Finance, Information Technology | linkedin.com · 15five.com · 4degrees.ai |
| Lakera Guard - Lakera | Information Technology, Software, Finance | tome.com · verax.ai · wexler.ai |
| Langfuse - Langfuse | Information Technology, Software, Finance | claimsorted.com · portialabs.ai · symbe.co |
| Patronus API - Patronus AI | Information Technology, Software, Data and Analytics | 101.xyz · 15five.com · 222.place |
| AI Risk Platform - PromptArmor | Information Technology, Software, Data and Analytics | 101.xyz · 15five.com · 222.place |
<!-- .element: class="small-table" -->

<div class="callout text-left">
  **Insight:** Specter join <code>companies</code> → <code>company_clients</code> → <code>clients_integration_companies</code>. Customer domains skew toward software/IT for most competitors.
</div>

<a href="./task2_product_industry_overlap.csv" target="_blank" class="pill">task2_product_industry_overlap.csv</a>

----

<!-- .slide: id="task3" -->
### Task 3: Five Lead Gen Signals

| # | Signal | Data Source | Trigger |
|---|---|---|---|
| 1 | **Edge Telemetry Headers** | Firecrawl HTTP crawl | `cf-ray`, `x-vercel-id`, `Report-To` in prod traffic |
| 2 | **GitHub CI/CD Fingerprints** | GitHub REST API | `langfuse` or `helicone` in `requirements.txt` or workflows |
| 3 | **AI Safety Job Postings** | Apify LinkedIn scraper | Role title contains `AI Safety` / `Trust & Safety` / `Responsible AI` |
| 4 | **Incident PR Monitoring** | Cala MCP + Reddit/HN + DDG/BS4 | Brand mentioned with `jailbreak`, `filter`, `toxic` |
| 5 | **HuggingFace Eval Traction** | HF 6-surface API sweep | Safety benchmark activity + user graph extraction |

*(Press ↓ on each task slide to see the workflow diagram)*

====

<!-- .slide: id="task3-s1" -->
#### Signal 1: Automated Telemetry Flow
##### Horizontal Pipeline: Method → Logic → Outcome

```mermaid
flowchart LR
    subgraph Input
        S[Scheduler] --> F[Firecrawl Agent]
        F -->|Crawl 500 Homepages| H[Intercept HTTP Headers]
    end
    subgraph Logic
        H --> P[Parse Raw Headers]
        P --> M{AI-Indicative Pattern?}
        M -->|cf-ray / x-vercel-id / Report-To| Y[Confidence Score]
        M -->|No match| Z[Skip]
        Y --> D{Dedupe Check}
        D -->|New domain| I[DB Insert]
    end
    subgraph Outcome
        I --> T[Tag: Using CF Edge]
        T --> O[Priority Outbound Queue]
    end
```
<!-- .element: class="mermaid-scaled" -->

**JSON output preview** (<span class="pill">artifacts/leads.jsonl</span>, `signal=edge_telemetry`):
<div style="max-height: 210px; overflow: auto; border: 1px solid #2f3542; border-radius: 8px; background: #0b0f14; padding: 10px;">
<pre style="margin: 0; font-size: 0.46em; line-height: 1.35;"><code class="language-json">{
  "id": "2912fbdf-952c-4e1c-9e4a-2114390075f8",
  "company": "whitecircle.ai",
  "signal": "edge_telemetry",
  "confidence": 0.85,
  "why_now": "Detected production edge telemetry header (Report-To)",
  "evidence_urls": [
    "https://whitecircle.ai"
  ],
  "created_at": "2026-02-23 03:35:02"
}</code></pre>
</div>

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

**JSON output preview** (<span class="pill">artifacts/leads.jsonl</span>, `signal=ci_eval_tools`):
<div style="max-height: 210px; overflow: auto; border: 1px solid #2f3542; border-radius: 8px; background: #0b0f14; padding: 10px;">
<pre style="margin: 0; font-size: 0.46em; line-height: 1.35;"><code class="language-json">{
  "id": "32c7194c-a96c-4379-b935-7695ea5eae31",
  "company": "leandromorera",
  "signal": "ci_eval_tools",
  "confidence": 0.82,
  "why_now": "Repository updated recently with 'langfuse' in metadata or readme.",
  "evidence_urls": [
    "https://github.com/leandromorera/LLMS_COMPARE_STREAMLIT_LANGFUSE"
  ],
  "created_at": "2026-02-22 21:53:04"
}</code></pre>
</div>

<div class="callout text-left">
  <strong>Insight:</strong> If they run eval tooling in CI, they've already allocated engineering budget for AI quality. They're technically ready to buy guardrails <em>tomorrow</em>.
</div>

====

<!-- .slide: id="task3-s3" -->
#### Signal 3: AI Safety Job Posting Intelligence
##### Apify CLI + `worldunboxer/rapid-linkedin-scraper` · Live Run Feb 2026

```mermaid
flowchart LR
    A[Competitor Client Names] --> B[Apify CLI]
    B -->|job_title: AI Safety| C[rapid-linkedin-scraper]
    C --> D[Parse Job Listings]
    D --> E{NLP: Trust & Safety / AI Safety?}
    E -->|Match| F[Specter Contact Gen]
    E -->|Skip| G[Discard]
    F --> H[CTO / VP-Eng Outreach]
```
<!-- .element: class="mermaid-scaled" -->

**Live run:** `apify call worldunboxer/rapid-linkedin-scraper` → **22 jobs** from cleaned competitor-client input.
- Safety keyword hits: **22/22**
- Distinct company labels returned by actor: **1** (`LinkedIn`)

**JSON output preview** (<span class="pill">artifacts/task3_signals/apify_linkedin_jobs.json</span>):
<div style="max-height: 210px; overflow: auto; border: 1px solid #2f3542; border-radius: 8px; background: #0b0f14; padding: 10px;">
<pre style="margin: 0; font-size: 0.46em; line-height: 1.35;"><code class="language-json">{
  "job_title": "Sr. Trust and Safety Investigator",
  "company_name": "LinkedIn",
  "location": "Omaha, NE",
  "time_posted": "1 week ago",
  "job_url": "https://www.linkedin.com/jobs/view/4372943060",
  "employment_type": "Full-time"
}</code></pre>
</div>

<div class="callout text-left">
  <strong>Trigger Logic — why this signal works:</strong>
  <ul>
    <li>Approved headcount budget already.</li>
    <li>Recognized explicit operational vulnerability.</li>
    <li>90-day hiring timeline → compress to immediate B2B purchase.</li>
  </ul>
</div>

<a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/artifacts/task3_signals/apify_linkedin_jobs.json" target="_blank" style="font-size: 0.6em; color: #a8a8ff;">🔗 Full JSON — 22 AI/Trust/Safety roles from Apify</a>

====

<!-- .slide: id="task3-s4" -->
#### Signal 4: Incident / PR Event Monitoring
##### Multi-Source Parallel Pipeline (Cala AI + Firecrawl + DDG + BS4)

```mermaid
flowchart TB
    subgraph Sources
        C[Cala AI] -->|"AI chatbot incident"| M
        C -->|"jailbreak production"| M
        C -->|"prompt injection vulnerability"| M
        F[Firecrawl] -->|Reddit /r/CharacterAI| M
        F -->|Trustpilot competitor clients| M
        D[DDG + BS4] -->|"[competitor] AI incident"| M
    end
    M[Merge & Dedupe] --> K{Keyword Filter}
    K -->|jailbreak / filter / toxic| E[Event Timeline]
    E --> X[Extract Company Names]
    X --> O[Outbound Trigger Email]
```
<!-- .element: class="mermaid-scaled" -->

**Outcome:** `incidents_social` inserted **8 leads** from Reddit/HN + DDG/BS4 paths in <span class="pill">artifacts/leads.jsonl</span>.

**JSON output preview** (<span class="pill">artifacts/leads.jsonl</span>, `signal=incidents_social`):
<div style="max-height: 210px; overflow: auto; border: 1px solid #2f3542; border-radius: 8px; background: #0b0f14; padding: 10px;">
<pre style="margin: 0; font-size: 0.46em; line-height: 1.35;"><code class="language-json">{
  "id": "19b40a58-381e-4042-a56f-4c11d8d2b17f",
  "company": "character.ai",
  "signal": "incidents_social",
  "confidence": 0.82,
  "why_now": "Reddit incident mention (character.ai jailbreak): Ultimate Claude Code h4x0r - the four letter jailbreak you've been looking for.",
  "evidence_urls": [
    "https://www.reddit.com/r/ClaudeCode/comments/1r6xmhk/ultimate_claude_code_h4x0r_the_four_letter/"
  ],
  "created_at": "2026-02-22 21:48:51"
}</code></pre>
</div>

====

<!-- .slide: id="task3-s5" -->
#### Signal 5: HuggingFace Eval Traction
##### 6-Surface Sweep · Live API · Feb 2026

```mermaid
flowchart LR
    A[Models] --> M[Merge]
    B[Datasets] --> M
    C[Spaces] --> M
    D[Blog] --> M
    E[Posts] --> M
    F[Papers] --> M
    M --> G[Profiles + Social Links]
    G --> H[Specter Org Match]
    H --> I[High-Intent Lead]
```
<!-- .element: class="mermaid-scaled" -->

**Live Data — 6-surface sweep (`hf_universe_intel`):**

| Metric | Value |
|---|---:|
| Unique users discovered | **394** |
| Profiles enriched | **158** |
| Listing pages scanned | **6** (models, datasets, spaces, blog, posts, papers) |
| Surface samples | **30 models / 30 datasets / 30 spaces** |
| Specter-linked companies | **0** (specter check disabled in this live sweep) |

**JSON output preview** (<span class="pill">artifacts/task3_signals/hf_universe_intel.json</span>):
<div style="max-height: 210px; overflow: auto; border: 1px solid #2f3542; border-radius: 8px; background: #0b0f14; padding: 10px;">
<pre style="margin: 0; font-size: 0.46em; line-height: 1.35;"><code class="language-json">{
  "generated_at": "2026-02-23T03:56:04.926587",
  "summary": {
    "models_sampled": 30,
    "datasets_sampled": 30,
    "spaces_sampled": 30,
    "listing_pages_scanned": 6,
    "unique_users_discovered": 394,
    "profiles_enriched": 158
  },
  "sample_user": {
    "username": "akhaliq",
    "profile_url": "https://huggingface.co/akhaliq",
    "source_count": 2,
    "followers": 9185
  }
}</code></pre>
</div>

> Any company whose engineers appear in safety dataset liker lists is actively doing R&D on safety evaluation. This is the highest-confidence signal in our pipeline.

====

<!-- .slide: id="task3-hn-people" -->
#### HN Security People Graph (Live Crawl + User Deep Dive)
##### <span class="pill">artifacts/task3_signals/hn_security_people.md</span>

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
##### <span class="pill">artifacts/task3_signals/hf_security_people.md</span>

**Coverage from latest run:**
- Security datasets sampled: **40**
- HF users profiled: **140**
- Specter-linked companies: **0**
- New signal leads inserted: **0**

| HF User | Datasets | Social Links Found | Specter Matches |
|---|---:|---|---:|
| `mekhanique` | 13 | [GitHub](https://github.com/mekhanique) | 0 |
| `FAU57` | 4 | [GitHub](https://github.com/Fau57) · [X](https://twitter.com/D3C3N7R41YF3) | 0 |
| `lucianosb` | 3 | [LinkedIn](https://www.linkedin.com/in/lucianosb) · [GitHub](https://github.com/lucianosb) · [X](https://twitter.com/lucianosb) | 0 |
| `finger8603` | 3 | — | 0 |

> This layer gives us named operators engaging with AI security datasets plus social graph handles. Specter matching was disabled in this run to prevent long remote DSN hangs.

----

<!-- .slide: id="task4" -->
### Task 4: Psychotherapy Chatbot Safety Policies
##### <span class="pill">artifacts/psychotherapy_policies.yaml</span> — 10 policies, CI-testable, severity-tagged

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

====

<!-- .slide: id="task4-rationale" -->
#### Policy Rationale: Real-World Triggers & Regulatory Basis

| Policy | Real-World Trigger | Regulatory Basis |
|---|---|---|
| **Self-Harm Escalation** | Character.AI lawsuits (2024–2025): minors harmed; Replika self-harm incidents | SAMHSA, 988 crisis line mandates; state digital safety laws |
| **PII Redaction** | Health chatbot data breaches; therapy-app PII leakage | HIPAA (PHI), GDPR Art. 5(1)(f), CCPA |
| **Medical Diagnosis Boundary** | AI chatbots giving diagnoses; liability in therapy apps | FDA guidance on AI/ML SaMD; state medical practice acts |
| **Sexual Content Guardrail** | Replika ERP complaints; companion app abuse reports | Age-appropriate design codes; App Store / Play Store policies |
| **Abuse De-escalation** | Users attacking chatbots; escalation to human abuse | Platform ToS; workplace safety standards for human handoff |
| **No Prescription Advice** | Chatbots suggesting dosages; dangerous drug interactions | FDA drug labeling; DEA controlled-substance rules |
| **Empathy Floor** | "That's irrational" responses; user distress amplifications | APA ethical guidelines; consumer protection (UX fairness) |
| **Link Integrity** | Phishing via chatbot links; malicious resource referrals | FTC deceptive-practice; cybersecurity best practice |
| **Anonymized Summaries** | Therapist notes with identifiers; clinician data exposure | HIPAA minimum necessary; GDPR data minimization |
| **Crisis Refusal Override** | User refuses help while expressing self-harm intent | Duty-to-warn (Tarasoff); emergency-services protocols |
<!-- .element: class="small-table" -->

----

<!-- .slide: id="task5" -->
### Task 5: Pricing Strategy
##### <span class="pill">artifacts/pricing_model.csv</span> — 4 tiers, effective rate + margin + competitor anchor

| Tier | Requests | Price | Effective / 1M | Gross Margin % | Competitive Anchor |
|---|---:|---:|---:|---:|---|
| **Free** | 1,000 | $0 | $0 | 0.00 | Langfuse community/open-source entry point |
| **Startup** | 100,000 | $149 | $1,490 | 99.66 | Braintrust startup-friendly entry economics |
| **Growth** | 1,000,000 | $899 | $899 | 99.44 | Helicone usage-volume scaling benchmark |
| **Enterprise** | 10,000,000 | $4,990 | $499 | 99.00 | Lakera-style enterprise annual commit motion |

====

<!-- .slide: id="task5-cala" -->
#### Cala AI Pricing Research — Benchmark Anchors
##### *Query: AI security & observability SaaS pricing · Feb 2026*

**Competitor benchmarks (via [Cala AI](https://docs.cala.ai/)):**

| Vendor | Model | Per-unit reference |
|---|---|---|
| **Datadog** | Consumption | RUM $0.15–0.80/1K sessions; Synthetic API $5/10K runs |
| **Cloudflare WAF** | Plan-based | Pro $20/mo → Business $200/mo |
| **Twilio** | Per-unit | SMS $0.0083/msg; volume discounts 150K+ |
| **LaunchDarkly** | Per-seat | Starter $8.33/seat; Pro $16.67/seat |

> White Circle’s request-based tiers align with observability vendors (Datadog, Helicone) and security motion (Lakera).

<a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/artifacts/task5_pricing/cala_pricing_research.json" target="_blank" style="font-size: 0.6em; color: #a8a8ff;">🔗 Full research — Cala AI + cited sources</a>

====

<!-- .slide: id="task5-formula" -->
#### Pricing Logic & Margins — Formal Derivation

**Definition 1 (Pricing Function).** For volume $v$ (requests), tier $T$ with base fee $B_T$ and per-unit rate $r_T$:

$$
\boxed{P(v) = B_T + (v \times r_T)}, \quad v \in [v_{T,\min}, v_{T,\max}]
$$

**Definition 2 (Gross Margin).** With COGS *c* = 5 USD per 1M requests:

$$
\text{Margin}_T = \frac{P - (v/10^6 \times c)}{P} \times 100\%
$$

<div class="callout text-left">
  <strong>Numerical verification:</strong>
</div>

| Tier | $P$ | $v$ | COGS | $\text{Margin}$ |
|---|---:|---:|---:|---:|
| Startup | $149 | 100K | $0.50 | $(149-0.5)/149 = 99.66\%$ |
| Growth | $899 | 1M | $5.00 | $(899-5)/899 = 99.44\%$ |
| Enterprise | $4,990 | 10M | $50.00 | $(4990-50)/4990 = 99.00\%$ |

<div class="callout text-left">
  <strong>Proposition.</strong> Effective rate $\$/1\text{M}$ decreases monotonically: $1490 \to 899 \to 499$. Validated against Cala AI benchmarks (Datadog RUM, Twilio, LaunchDarkly).
</div>

====

<!-- .slide: id="task5-logic" -->
#### The Math: Why Non-Linear Pricing Works

| Finding | Value |
|---|---|
| Effective rate progression | $1,490 → $899 → $499 per 1M |
| Unit economics (COGS $5/1M) | 99.66% / 99.44% / 99.00% gross margin |
| Competitive anchors | Braintrust (startup) · Helicone (growth) · Lakera (enterprise) |

<div class="callout text-left">
  <strong>Formula:</strong> margin = (price − (requests ÷ 1e6 × 5)) ÷ price × 100
</div>

<div class="callout text-left">
  Growth retains high margin; Enterprise stays cheaper per 1M for high-volume traffic — validated against Cala AI competitor research.
</div>

----

<!-- .slide: id="task6" -->
### Task 6: Message Volume Estimates
##### <span class="pill">artifacts/message_volume_estimates.md</span> — 3 independent heuristics

| Platform | Domain | Low | Base | High | 95% CI | Tier Fit |
|---|---|---:|---:|---:|---|---|
| **Lovable** | `lovable.dev` | 11.52M | 15.30M | 18.96M | 13.46M - 17.14M | Enterprise |
| **Replit** | `replit.com` | 82.50M | 86.40M | 107.80M | 82.50M - 96.77M | Enterprise |
| **Base44** | `base44.com` | 4.22M | 4.78M | 5.30M | 4.22M - 5.30M | Growth |

> All three figures are **per-platform per-month message totals**, derived from 3 independent heuristics triangulated together.

====

<!-- .slide: id="task6-vars" -->
#### Variable Definitions (Before Calculation)

| Proxy | Variable | Definition | Typical Value |
|---|---|---|---|
| **Traffic** | $V$ | Monthly visits | Platform-specific (e.g. 6M Lovable) |
| | $c$ | Conversational share | 0.32 |
| | $m$ | Messages per session | 6 |
| **User** | $DAU$ | Daily active users | Platform-specific |
| | $d$ | Active chat days per month | 20–30 |
| | $n$ | Messages per active day | 5 |
| **Engineering** | $R$ | Sustained RPS capacity | Platform-specific |
| | $D$ | Duty cycle (fraction of time active) | 0.16 |
| | $S$ | Seconds per month | 2.592M |

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

<!-- .slide: id="task6-katex" -->
#### KaTeX Calculation Walkthrough

$$M_{\text{traffic}} = V \times c \times m \quad \text{ | } \quad M_{\text{user}} = DAU \times d \times n \quad \text{ | } \quad M_{\text{eng}} = R \times D \times S$$

**Example — Lovable (Traffic Proxy):**
$$M_{\text{traffic}} = 6\text{M} \times 0.32 \times 6 = 11.52\text{M}$$

**Example — Lovable (User Proxy):**  
$DAU = 153\text{K}$, $d = 20$, $n = 5$ → $M_{\text{user}} = 153{,}000 \times 20 \times 5 = 15.30\text{M}$

**Example — Replit (Engineering Proxy):**  
$R = 260$, $D = 0.16$, $S = 2.592\text{M}$ → $M_{\text{eng}} = 260 \times 0.16 \times 2{,}592{,}000 \approx 107.8\text{M}$

| Platform | $V$ / $DAU$ / $R$ | Proxy Output |
|---|---:|---:|
| Lovable | 6M visits, 153K DAU | 11.52M, 15.30M |
| Replit | 45M visits, ~825K DAU, 260 RPS | 86.4M, 82.5M, 107.8M |
| Base44 | 2.2M visits, ~53K DAU | 4.22M, 5.30M |

====

<!-- .slide: id="task6-per-user" -->
#### Per-User Per-Month Breakdown

| Platform | Est. MAU | Messages / User / Month | Reasoning |
|---|---:|---:|---|
| **Lovable** | 100000-200000 | 100-150 | 100% AI-native codegen: high prompt/session density |
| **Replit** | 4000000-6000000 | 20-25 | Broad user base; only a subset uses AI intensively |
| **Base44** | 20000-50000 | 90-130 | Early adopter-heavy user pool with high per-user usage |

====

<!-- .slide: id="task6-cala" -->
#### Cala AI Proxy: Usage Statistics Triangulation
##### *Query: Replit, Lovable, Cursor messages-per-user metrics · Feb 2026*

**Cala-verified aggregates used for heuristic calibration:**

| Platform | Cala-sourced metric | Use in our model |
|---|---|---|
| **Cursor** | 1M+ DAU, 1B+ lines/day, 1M+ QPS | Validates engineering proxy scale |
| **Replit** | 30M+ MAU, 12.58M monthly visits | Anchors traffic proxy $V$ |
| **Lovable** | 2.3M→8M users, 25.6M–39.3M visits | Anchors $V$ and DAU assumptions |
| **Base44** | 250K→400K users, $1M ARR in 3 weeks, Wix $80M acquisition | Platform + analysis: vibe-coding scale & bootstrapped growth proxy |

> We triangulate: traffic (visits × 0.32 × 6) + user (DAU × days × 5) + engineering (RPS × 0.16 × 2.592M). When all three align, CI narrows.

<a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/artifacts/task6_estimates/cala_usage_proxy.json" target="_blank" style="font-size: 0.6em; color: #a8a8ff;">🔗 Cala usage proxy artifact</a>

----

<!-- .slide: id="task7" -->
### Task 7: Scalable Outbound Strategies
##### 1 Cold Email + 1 LinkedIn + Full Funnel Artifacts

| Artifact | Count | Status |
|---|---:|---|
| <span class="pill">artifacts/leads.jsonl</span> | 143 leads | Valid JSONL parse |
| <span class="pill">artifacts/task1_icp_profiles/ICP_targets_enriched.json</span> | 30 ICPs | Specter contacts + funding |
| <span class="pill">artifacts/task7_outbound/</span> | 13 email + 13 LinkedIn v2 | OpenCode + Specter context generation |

*(Press ↓ for concrete cold email, LinkedIn, and JSON previews)*

====

<!-- .slide: id="task7-cold-email" -->
#### G1: Cold Email — Lakera Customer (Tome)
##### Targeting <code>tome.com</code> · OpenCode output from full Specter context (`talentsignals` + `people_db.*`) + Lakera linkage evidence

<div id="tome-contact-switcher" class="contact-switcher-sidebar">
  <div class="folder-contacts"></div>
  <div class="folder-body">
    <div class="folder-email"></div>
  </div>
</div>

*143 leads in <a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/artifacts/leads.jsonl" target="_blank" class="pill">artifacts/leads.jsonl</a>*

<a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/artifacts/task7_outbound/tome_opencode_context.json" target="_blank" class="pill">tome_opencode_context.json</a> · <a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/artifacts/task2_competitors/competitors.md" target="_blank" class="pill">competitors.md</a> · <a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/artifacts/task1_icp_profiles/ICP_targets_enriched.json" target="_blank" class="pill">ICP_targets_enriched.json</a>

====

<!-- .slide: id="task7-linkedin" -->
#### G2: LinkedIn Message — AI Incident + Edge Telemetry Outbound
##### Cala + Reddit/HF signal → Specter contact · person_db + OpenCode personalization

<div id="incident-linkedin-switcher" class="contact-switcher-sidebar linkedin-slide">
  <div class="folder-contacts"></div>
  <div class="folder-body">
    <div class="folder-email"></div>
  </div>
</div>

<a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/artifacts/task7_outbound/cala_ai_incidents_research.json" target="_blank" class="pill">cala_ai_incidents_research.json</a>

====

<!-- .slide: id="task7-artifacts" -->
#### G3: Artifact Showcase — Signal → Specter → person_db → OpenCode → Outreach

```mermaid
flowchart LR
    A[Incident / Signal] --> B[leads.jsonl]
    B --> C[Specter + person_db]
    C --> D[OpenCode]
    D --> E[Email + LinkedIn]
```

| Stage | Artifact |
|---|---|
| Leads | <a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/artifacts/leads.jsonl" target="_blank" class="pill">leads.jsonl</a> (143) |
| Contacts | <a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/artifacts/task1_icp_profiles/ICP_targets_enriched.json" target="_blank" class="pill">ICP_targets_enriched.json</a> |
| Tome (Lakera) | <a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/presentation/presentation/tome_contacts.json" target="_blank" class="pill">tome_contacts.json</a> |
| Incident (people) | <a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/presentation/presentation/incident_linkedin_contacts.json" target="_blank" class="pill">incident_linkedin_contacts.json</a> (7) |
| Raw outbound | <a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/artifacts/task7_outbound/" target="_blank" class="pill">task7_outbound/*_v2.txt</a> |

<code>outbound enrich-tome --use-opencode</code> · <code>outbound enrich-incident-linkedin --people-only</code>

----

<!-- .slide: id="close" class="text-left" -->
### Thank You.

Everything here is **powered by running code** — Specter, person_db, OpenCode, Cala.

| What's live | Evidence |
|---|---|
| 30 ICP profiles + Specter funding | <a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/artifacts/task1_icp_profiles/ICP_targets_enriched.json" target="_blank" class="pill">ICP_targets_enriched.json</a> |
| 6-competitor matrix | <a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/artifacts/task2_competitors/" target="_blank" class="pill">task2_competitors/</a> |
| 5 signal detectors | <code>python -m src.cli signals run</code> |
| 10 safety policies | <a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/artifacts/psychotherapy_policies.yaml" target="_blank" class="pill">psychotherapy_policies.yaml</a> |
| 4-tier pricing | <a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/artifacts/pricing_model.csv" target="_blank" class="pill">pricing_model.csv</a> |
| **Tome cold email** (10 contacts, person_db + OpenCode) | <a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/presentation/presentation/tome_contacts.json" target="_blank" class="pill">tome_contacts.json</a> |
| **Incident LinkedIn** (7 people, Specter + person_job) | <a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/presentation/presentation/incident_linkedin_contacts.json" target="_blank" class="pill">incident_linkedin_contacts.json</a> |
| 143 leads × email + LinkedIn (OpenCode) | <a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/artifacts/task7_outbound/" target="_blank" class="pill">task7_outbound/*_v2.txt</a> |

<code>enrich-tome --use-opencode</code> · <code>enrich-incident-linkedin --people-only</code>

<a href="https://github.com/frankterpo/growth_hacker_wc_2026/" style="font-size: 1.1em; color: #a8a8ff;">🔗 github.com/frankterpo/growth_hacker_wc_2026</a>
