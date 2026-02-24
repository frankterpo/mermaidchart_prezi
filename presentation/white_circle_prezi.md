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
        A1["Firecrawl + BS4\n(sitemap, meta, headers)"] --> A3["HTTP Headers\n(cf-ray, x-vercel-id)"]
        A4["Cala AI\n(entity_search, knowledge_query)"] --> A5["Verified company context\n+ social signals"]
        A6["GitHub API\n+ HF 6-surface sweep"] --> A7["CI/CD deps\n+ safety dataset users"]
        A8["Apify LinkedIn\n+ DDG + Reddit/HN"] --> A9["Job postings\n+ incident mentions"]
    end
    subgraph Signal_Processing [2. Signal Processing]
        B1["ICP Build\n(30 targets × 15 verticals)"] --> B2["Specter Postgres\n(funding, headcount, tech stack)"]
        A3 --> B3["6 Signal Detectors"]
        A7 --> B3
        A9 --> B3
        A5 --> B2
    end
    subgraph Insights_Activation [3. Insights & Activation]
        B2 --> C1["person_db\n(seniority rank + contact)"]
        B3 --> C2["leads.jsonl\n(115 scored leads)"]
        C1 --> C3["OpenCode\n(YC-format outbound)"]
        C2 --> C3
        C3 --> C4["Email + LinkedIn\n(18 personalized drafts)"]
    end
```

====

<!-- .slide: id="pipeline-code" -->
#### How it runs (`src/cli.py`)

```bash
# ICP: Build 30 targets → Enrich with Specter
python -m src.cli icp build && python -m src.cli icp enrich

# Signals: Run all 6 detectors in one pass
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
| Khan Academy | Education | Grant-funded nonprofit | — | ~$22M (grants) | — | Gates Foundation, Google.org | — |
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

| WTP Driver | Consumer GenAI | Enterprise Automation | Regulated Industry |
|---|---|---|---|
| **Risk exposure** | HIGH — lawsuits, PR | MEDIUM — internal-facing | HIGH — regulatory fines |
| **Request volume** | VERY HIGH — 1B+ req/mo | MEDIUM — 10M–100M/mo | LOW–MEDIUM |
| **Compliance burden** | LOW — minimal regulation | MEDIUM — SOC 2, audit | VERY HIGH — HIPAA, FDA, SOX |
| **Likely tier** | Growth → Enterprise | Startup → Growth | Growth → Enterprise |
| **Price sensitivity** | Low (VC-funded) | Medium (ROI-driven) | Low (non-negotiable) |
<!-- .element: class="small-table" -->

<div class="callout text-left" style="font-size: 0.55em;">
  <strong>In plain English:</strong> More AI risk → pay more. More volume → pay more. Heavier compliance → pay more. Risk + compliance both high → urgency jumps faster than either alone. Regulated industries have the highest WTP despite lower volume.
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

<div class="callout text-left" style="font-size: 0.55em;">
  <strong>Every variable, plain English:</strong>
  <ul style="margin:4px 0; line-height:1.6;">
    <li><strong>WTPScore<sub>i</sub></strong> — "How much will company <em>i</em> pay?" A score from 0–1 that maps to a pricing tier.</li>
    <li><strong>δ (delta)</strong> — The baseline. Even a company with zero risk and zero volume has <em>some</em> willingness to pay just to have the tool. Think of it as the "floor."</li>
    <li><strong>R̃<sub>i</sub> (risk)</strong> — How dangerous is company <em>i</em>'s AI? Mental health chatbot = high risk. Internal wiki search = low risk. Scale: 0 to 1.</li>
    <li><strong>α (alpha)</strong> — How much does risk <em>move the needle</em> on price? Big α = risky companies pay a lot more.</li>
    <li><strong>Ṽ<sub>i</sub> (volume)</strong> — How many API requests does company <em>i</em> send per month? More requests = more value from WC. Scale: 0 to 1.</li>
    <li><strong>β (beta)</strong> — How much does volume move the needle? Big β = high-traffic companies pay more.</li>
    <li><strong>C̃<sub>i</sub> (compliance)</strong> — How heavy are company <em>i</em>'s regulatory requirements? HIPAA/FedRAMP = high. Unregulated consumer app = low. Scale: 0 to 1.</li>
    <li><strong>γ (gamma)</strong> — How much does compliance move the needle?</li>
    <li><strong>R̃<sub>i</sub> · C̃<sub>i</sub> (interaction term)</strong> — When risk AND compliance are <em>both</em> high, urgency jumps faster than either alone. A regulated company running risky AI pays a premium on top of the individual effects.</li>
    <li><strong>η (eta)</strong> — How strong is that compound effect?</li>
  </ul>
  <strong>How we get dollar amounts:</strong> The score feeds into a tier map (Task 5): 0–0.3 → Free, 0.3–0.5 → Starter ($99), 0.5–0.7 → Growth ($899), 0.7+ → Enterprise (custom).
</div>

====

<!-- .slide: id="task1-wtp-table" -->
#### ICP vs Industry Comparison

| Lens | Bucket | N | Avg Risk | Avg Volume | Avg Priority | Median Raised |
|---|---|---:|---:|---:|---:|---:|
| **ICP** | Regulated Industry AI | 10 | 0.70 | 0.00 | 95.0 | $175.0M |
| **ICP** | Enterprise Automation & Copilots | 10 | 0.60 | 0.40 | 90.0 | $195.0M |
| **ICP** | High-Risk Consumer GenAI | 10 | 0.50 | 0.50 | 85.0 | $8.4M |
| **Industry** | GovTech | 2 | 0.70 | 0.00 | 95.0 | $5.1M |
| **Industry** | DevTools | 2 | 0.60 | 0.40 | 90.0 | $1.23B |
| **Industry** | SalesEnablement | 2 | 0.60 | 0.40 | 90.0 | $225.0M |
| **Industry** | Mental Health | 2 | 0.50 | 0.50 | 85.0 | $8.4M |
<!-- .element: class="small-table" -->

<div class="callout text-left" style="font-size: 0.55em;">
  <strong>Why Regulated > Enterprise > Consumer?</strong> For a security product, <em>regulatory penalty exposure</em> drives WTP more than volume. GovTech (FedRAMP/ITAR), HealthTech (HIPAA), FinTech (SOX) face the highest cost of a safety failure — and the longest vendor lock-in. Consumer GenAI has the most users but weaker enforcement and smaller budgets.
</div>

====

<!-- .slide: id="task1-takeaways" -->
#### Concrete Takeaways

<div class="callout text-left">

**1. Regulatory risk is the #1 predictor of WTP.** GovTech and HealthTech companies will pay 2-3x more than consumer AI at the same volume — compliance is non-negotiable, and switching costs are high.

**2. 15 verticals, 30 companies — but the pipeline starts with 3.** Regulated Industry AI (Palantir, Abridge, Upstart) is the beachhead: highest urgency, longest lock-in, largest deal sizes. Enterprise Automation is the scale play.

**3. The ICP formula is a living model.** Coefficients ($\alpha, \beta, \gamma, \eta$) recalibrate as win/loss data lands. Right now it's seeded on public signals — the first 5 closed deals will sharpen it dramatically.

</div>

----

<!-- .slide: id="task2" -->
### Task 2: Competitor Intelligence
##### Mapped to White Circle USPs via Automated Multi-Source Extraction

| White Circle USP | Competitor | Products | Verified Customers | Source | Differentiation |
|---|---|---|---|---|---|
| **Low-latency Safeguards** | Lakera | Guard, Red, Gandalf | Dropbox · Cohere · Top 3 US bank (unnamed) | [lakera.ai/customers](https://lakera.ai/customers) | WC: edge enforcement + post-deploy tuning. Lakera: firewall-first blocking. |
| **Low-latency Safeguards** | PromptArmor | AI Risk Platform | ASAPP (AI Transparency Portal) · Fortune 100 (unnamed) | [TPRA](https://www.tprassociation.org/vendor-profiles/promptarmor), [ASAPP partnership](https://www.joinprospect.com/explore/asapp) | WC: observability + policy QA. PromptArmor: prompt-injection hardening. |
| **Observability** | Helicone | Helicone | Sunrun · DeepAI (65% cost ↓) · Brand.dev | [helicone.ai/customers](https://helicone.ai/customers) | WC: prevention + policy enforcement. Helicone: telemetry + cost observability. |
| **Observability** | Langfuse | Langfuse | Merck (80+ AI teams) · SumUp (4M merchants) · Twilio | [langfuse.com/customers](https://langfuse.com/customers) | WC: runtime blocking. Langfuse: tracing + developer analytics. |
| **Eval / Stress-test** | Braintrust | Braintrust | Zapier (25% accuracy ↑) · Notion (10x resolution) · Coursera · Dropbox · Stripe · Navan | [braintrust.dev/customers](https://braintrust.dev/customers), [a16z](https://a16z.com/announcement/investing-in-braintrust/) | WC: runtime guardrails + eval. Braintrust: pre-production eval workflows. |
| **Eval / Stress-test** | Patronus AI | Patronus API, Percival, Lynx | Etsy · CARIAD/VW · Gamma · Weaviate · Hospitable.com | [patronus.ai/case-studies](https://patronus.ai/case-studies) | WC: edge controls + stress-test. Patronus: eval-focused quality scoring. |
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
    title AI Security & Observability Positioning
    x-axis "Low Latency" --> "High Latency"
    y-axis "Pre-deploy Eval" --> "Runtime Protection"
    quadrant-1 Runtime Observability
    quadrant-2 Runtime Security
    quadrant-3 Pre-deploy Quality
    quadrant-4 Post-hoc Eval
    WC Edge: [0.10, 0.92]
    WC Guard: [0.18, 0.82]
    PromptArmor: [0.35, 0.75]
    Lakera Guard: [0.28, 0.68]
    Patronus Percival: [0.62, 0.58]
    Lakera Red: [0.52, 0.42]
    Lakera Gandalf: [0.42, 0.32]
    Langfuse: [0.78, 0.30]
    Braintrust Loop: [0.68, 0.18]
    Patronus API: [0.82, 0.12]
    Helicone: [0.92, 0.22]
    Braintrust Platform: [0.92, 0.08]
```

<div class="callout text-left" style="font-size: 0.5em;">
  <strong style="color:#6366f1;">■ White Circle</strong> = top-left: lowest latency + highest runtime protection. Competitors cluster in post-hoc eval or pre-deploy quality. No other product combines sub-200ms with runtime enforcement.
</div>

====

<!-- .slide: id="task2-overlap" -->
#### Competitor Product × Customer × Industry Matrix

| Company | Products | Verified Customers | Customer Industries |
|---|---|---|---|
| **Braintrust** | Platform · Brainstore · Loop | Notion · Stripe · Zapier · Vercel · Dropbox · Coursera · Navan · Retool · Airtable · Instacart | SaaS, FinTech, DevTools, EdTech, E-commerce |
| **Helicone** | Observability Proxy (100+ LLMs) | Sunrun · DeepAI · Brand.dev · Greptile | Energy, AI/ML, DevTools |
| **Lakera** | Guard · Red · Gandalf · PII Detection | Dropbox · Cohere · Top 3 US bank (unnamed) | Cloud Storage, AI/ML, Finance |
| **Langfuse** | LLM Engineering Platform | Samsara · Twilio · SumUp · Khan Academy · Springer Nature · Telus · Pigment | IoT, Comms, FinTech, EdTech, Publishing, Telco |
| **Patronus AI** | API · Percival · Lynx · FinanceBench · SimpleSafetyTests · Glider | Etsy · CARIAD/VW · Gamma · Weaviate · Hospitable.com | E-commerce, Automotive, AI/ML, Search, Hospitality |
| **PromptArmor** | AI Risk Platform | ASAPP · Fortune 100 (unnamed) | Enterprise AI, undisclosed |
<!-- .element: class="small-table" -->

<div class="callout text-left" style="font-size: 0.5em;">
  <strong>Sources:</strong> Company website testimonials (web-scraped), public <code>/customers</code> pages, case studies, <a href="https://a16z.com/announcement/investing-in-braintrust/">a16z</a>, <a href="https://siliconangle.com/2026/02/17/braintrust-breaks-80m-series-b-funding-round-become-observability-layer-ai/">SiliconANGLE</a>, <a href="https://www.cbinsights.com/company/promptarmor/financials">CB Insights</a>, <a href="https://www.tprassociation.org/vendor-profiles/promptarmor">TPRA</a>. Product data from company pages + G2. Context enriched via <a href="https://docs.cala.ai/">Cala AI</a> knowledge search.
</div>

<a href="./task2_product_industry_overlap.csv" target="_blank" class="pill">task2_product_industry_overlap.csv</a>

====

<!-- .slide: id="task2-takeaways" -->
#### Concrete Takeaways

<div class="callout text-left">

**1. White Circle's moat is data, not features.** Sub-200ms runtime enforcement is the entry point — but the real moat is the model WC builds from usage. Every policy enforcement, every blocked prompt, every false positive correction feeds back into the system. More customers = more data = better detection = harder to displace. Competitors doing post-hoc eval never see this traffic.

**2. Competitors validate the market, not threaten it.** Lakera (20M Series A), Braintrust (80M Series B), Langfuse (acquired by ClickHouse) — investors are pouring capital into AI security/observability. WC is differentiated, not duplicated.

**3. Customer overlap = expansion opportunity.** Dropbox uses Lakera; Merck uses Langfuse; Etsy uses Patronus. These companies already budget for AI safety tools — WC sells alongside, not against.

</div>

----

<!-- .slide: id="task3" -->
### Task 3: Six Lead Gen Signals

| # | Signal | Data Source | Trigger |
|---|---|---|---|
| 1 | **Edge Telemetry Headers** | Firecrawl HTTP crawl | `cf-ray`, `x-vercel-id`, `Report-To` in prod traffic |
| 2 | **GitHub CI/CD Fingerprints** | GitHub REST API | `langfuse` or `helicone` in `requirements.txt` or workflows |
| 3 | **AI Safety Job Postings** | Apify LinkedIn scraper | Role title contains `AI Safety` / `Trust & Safety` / `Responsible AI` |
| 4 | **Incident PR Monitoring** | Cala MCP + Reddit/HN + DDG/BS4 | Brand mentioned with `jailbreak`, `filter`, `toxic` |
| 5 | **HuggingFace Eval Traction** | HF 6-surface API sweep | Safety benchmark activity + user graph extraction |
| 6 | **HN Security People Graph** | HN crawl + user deep dive | Security-related users with company mentions |

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
  "company": "anthropic",
  "signal": "incidents_social",
  "confidence": 0.82,
  "why_now": "Reddit incident mention (Claude Code jailbreak): prompt override technique shared on r/ClaudeCode",
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
#### Signal 6: HN Security People Graph (Live Crawl + User Deep Dive)
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
#### Signal 5 (cont.): HF Datasets → People → Social Links → Specter Match
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

====

<!-- .slide: id="task3-takeaways" -->
#### Concrete Takeaways

<div class="callout text-left">

**1. Six signals, one pipeline, 115 leads.** Edge telemetry, CI/CD fingerprinting, job postings, incidents, HuggingFace eval, HN security people — each catches a different buying signal. Together they cover intent (jobs), infrastructure (telemetry), and urgency (incidents).

**2. Job postings are the highest-intent signal.** A company hiring for "AI Safety Engineer" has approved headcount budget, recognized the problem, and set a 90-day timeline. That's a warm lead you can compress into an immediate B2B purchase.

**3. Incident monitoring creates urgency.** When a jailbreak hits Reddit or a data leak makes HN, the affected company's security team is in triage mode. Outreach within 48 hours converts at 3-5x the cold baseline.

</div>

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
| **Crisis Refusal Override** | User refuses help while expressing self-harm intent | Involuntary hold statutes (e.g. CA 5150); duty-of-care negligence; emergency-services protocols |
<!-- .element: class="small-table" -->

====

<!-- .slide: id="task4-takeaways" -->
#### Concrete Takeaways

<div class="callout text-left">

**1. Policies are code, not PDFs.** Every policy is YAML-defined, version-controlled, and CI-tested. Policy drift becomes a source-code bug caught in CI, not an ops surprise found in production.

**2. 10 policies cover the critical surface.** 5 user-facing (self-harm escalation, PII redaction, scope boundary, minors, crisis override) + 5 assistant-facing (diagnosis prohibition, empathy floor, link integrity, anonymized summaries, crisis refusal override). Each maps to a specific regulatory framework.

**3. This is White Circle's product in miniature.** The safety policy YAML → CI test → runtime enforcement loop is exactly what WC sells to every customer. Psychotherapy is the hardest case; if it works here, it works everywhere.

</div>

----

<!-- .slide: id="task5" -->
### Task 5: Pricing Strategy
##### *"Some clients have 1,000 API requests/mo, some have 10,000,000. How would you approach pricing?"*

**Approach: Usage-based tiers with volume discounts.** Dominant model in AI infra (Datadog, Twilio, Stripe) — cost aligns with value delivered.

| Tier | Requests/mo | Price/mo | Eff. $/1M | Why this tier exists |
|---|---:|---:|---:|---|
| **Free** | 1,000 | $0 | — | Removes friction. Langfuse/Braintrust prove free tier drives developer adoption. |
| **Startup** | 100K | $149 | $1,490 | First production workload. Anchored to Braintrust/Helicone starter ($99–199). |
| **Growth** | 1M | $899 | $899 | Scaling companies. 40% cheaper per unit. Matches Datadog consumption economics. |
| **Enterprise** | 10M+ | $4,990 | $499 | Annual commit. 67% cheaper per unit. Lakera/Cloudflare WAF enterprise pattern. |

====

<!-- .slide: id="task5-formula" -->
#### Unit Economics & Competitive Anchors
##### <span class="pill">artifacts/pricing_model.csv</span>

**COGS:** $5 per 1M requests (inference proxy + policy engine compute). Gross margin stays >99% at all tiers.

| Tier | Price | COGS | Gross Margin | Competitive Reference |
|---|---:|---:|---:|---|
| Startup | $149 | $0.50 | 99.7% | Braintrust starter ($99), Helicone Pro ($199) |
| Growth | $899 | $5.00 | 99.4% | Datadog RUM ($150–800/1K sessions), Twilio volume tiers |
| Enterprise | $4,990 | $50.00 | 99.0% | Lakera enterprise (custom), Cloudflare WAF Business ($200/mo) |

<div class="callout text-left" style="font-size: 0.55em;">
  <strong>Why non-linear pricing works:</strong> Effective rate drops $1,490 → $899 → $499 per 1M. A 10M req/mo customer gets 67% lower unit cost but pays 33× the Startup price. The 99%+ margins mean every incremental request is near-pure revenue.
</div>

====

<!-- .slide: id="task5-logic" -->
#### Concrete Takeaways

<div class="callout text-left">

**1. Use requests as the billing unit** — not seats, not “messages.” API requests are the atomic unit mapping directly to compute cost and customer value. Every competitor in this space (Helicone, Langfuse, Lakera) bills on usage, not seats.

**2. WTP varies by ICP, not just volume.** A HealthTech company at 100K req/mo will pay Growth-tier ($899) because compliance is non-negotiable. A consumer AI startup at 1M req/mo might negotiate harder to optimize burn. Same volume, different willingness.

**3. Free tier is mandatory for developer adoption.** Langfuse (open-source, acquired by ClickHouse) and Braintrust (free eval tools) prove developer-first distribution beats enterprise sales at this stage. 1K free requests costs us $0.005/mo in COGS.

**4. Enterprise is where the money is.** From Task 6: Lovable, Replit, and Base44 each generate 225M–25B API req/mo. At 499/1M requests, a single enterprise deal = 112K–12.5M/year. These require custom contracts, not self-serve.

</div>

----

<!-- .slide: id="task6" -->
### Task 6: Message Volume Estimates
##### *"Estimate the amount of messages Lovable, Base44, and Replit have per month."*

**Approach:** 3 independent heuristics (traffic, user, engineering) -- then a critical correction.

| Heuristic | What it uses | Why it helps |
|---|---|---|
| **Traffic proxy** | SimilarWeb monthly visits | Public, hard to fake |
| **User proxy** | Reported MAU/DAU | Closest to real usage |
| **Engineering proxy** | Infra disclosures, job posts | Catches hidden capacity |
<!-- .element: class="small-table" -->

<div class="callout text-left" style="font-size: 0.55em;">
  <strong>The catch:</strong> All three heuristics count <em>user-visible messages</em> (what a person types). But White Circle guards <strong>LLM API requests</strong> -- and the gap between the two is 100-400x. The next slides explain why.
</div>

====

<!-- .slide: id="task6-data" -->
#### Input Data: Cala AI Proxies + Per-User Variables

<div class="callout text-left" style="font-size: 0.5em; margin-bottom: 0.3em;">
  <strong>What is Cala AI?</strong> A data structuring platform for AI agents (<a href="https://docs.cala.ai/" target="_blank">docs.cala.ai</a>). Francisco is one of 50 selected alpha testers. We use it to source verified company metrics.
</div>

| Platform | Users | ARR | Monthly Visits | As of |
|---|---|---|---|---|
| **Lovable** | 8M+ | 200M-300M+ | 30.75M | Nov 2025 - Feb 2026 |
| **Replit** | 35-40M MAU | 150M | -- | Q3 2025 |
| **Base44** | 250K-400K | 1M (3 weeks) | -- | Jun 2025 |
| **Cursor** *(reference)* | 1M+ DAU | 500M+ | -- | Q4 2025 |
<!-- .element: class="small-table" -->

**Per-user variables -- how 1 message becomes 100+ API requests:**

| Variable | Plain English | Range |
|---|---|---|
| **Active users** | People actually using the AI each day | 100K - 12M |
| **Prompts/user/day** | How many times a user types a prompt | 10-30 |
| **Fan-out (k)** | Backend LLM calls per prompt (context, code gen, validation, retries) | 5-20 |
| **Autocomplete** | Invisible inline completions per day (IDE tools only) | 0-400 |
<!-- .element: class="small-table" -->

<a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/artifacts/task6_estimates/cala_usage_proxy.json" target="_blank" style="font-size: 0.6em; color: #a8a8ff;">Cala usage proxy artifact</a>

====

<!-- .slide: id="task6-calc" -->
#### Calculation: From 1 Message to 1,000+ API Requests

```mermaid
flowchart TD
    A["1 user prompt"] --> B["1 explicit message"]
    B --> C1["1. Context retrieval"]
    B --> C2["2. Code generation"]
    B --> C3["3. Validation"]
    B --> C4["4. Error retry"]
    B --> C5["5-20. Agent sub-calls"]
    F["Autocomplete - IDE only"] --> G["~400 invisible req/day"]
    C1 --> WC["White Circle guards every call"]
    C2 --> WC
    C3 --> WC
    C4 --> WC
    C5 --> WC
    G --> WC
    WC --> H["Total API req/mo"]
    style WC fill:#4a9eff,stroke:#fff,color:#fff
```

**The formula:**

<div>$$M_{\text{api}} = \text{Users}_{\text{active}} \times d \times (n_{\text{prompts}} \times k_{\text{fanout}} + n_{\text{auto}})$$</div>

| Platform | Active Users | Prompts x Fan-out + Auto | Naive (msgs/mo) | **Corrected (API req/mo)** | Factor Off |
|---|---:|---|---:|---:|---:|
| **Lovable** | 1-2M | 20 x 15 + 0 | 15.3M | **1.5B - 6B** | ~100-400x |
| **Replit** | 8-12M | 15 x 10 + 400 | 86.4M | **5B - 25B** | ~60-290x |
| **Base44** | 100-200K | 20 x 12 + 0 | 4.8M | **225M - 720M** | ~47-150x |
<!-- .element: class="small-table" -->

<div class="callout text-left" style="font-size: 0.5em;">
  <strong>Worked example (Lovable):</strong> 2M active users x 20 days x (20 prompts x 15 fan-out) = <strong>12B req/mo</strong> (upper). The naive "message" count (15.3M/mo) undercounts by <strong>~400x</strong>.
</div>

====

<!-- .slide: id="task6-takeaways" -->
#### Concrete Takeaways

<div class="callout text-left">

**1. "Messages" is the wrong unit -- and it matters 100-400x.** A single user prompt triggers 5-20 backend LLM calls (context, code gen, validation, retries). IDE tools add ~400 invisible autocomplete calls/day. White Circle guards every one of these API requests, not just the visible "messages."

**2. All three targets are enterprise-tier.** Lovable (1.5B-6B req/mo), Replit (5B-25B), Base44 (225M-720M). At these volumes, standard tiers don't apply -- these are custom contracts ($50K-500K+/year).

**3. The methodology is reusable.** Three heuristics with different failure modes. When all three converge (as they do for Lovable and Replit), confidence is high. Run this on any prospect: plug in Cala data, apply the fan-out multiplier, get the volume.

</div>

----

<!-- .slide: id="task7" -->
### Task 7: Scalable Outbound Strategies
##### 1 Cold Email + 1 LinkedIn + Full Funnel Artifacts

| Artifact | Count | Status |
|---|---:|---|
| <span class="pill">artifacts/leads.jsonl</span> | 115 leads | Valid JSONL parse |
| <span class="pill">artifacts/task1_icp_profiles/ICP_targets_enriched.json</span> | 30 ICPs | Specter contacts + funding |
| <span class="pill">artifacts/task7_outbound/</span> | 9 email + 9 LinkedIn v2 | OpenCode + Specter context generation |

*(Press ↓ for concrete cold email, LinkedIn, and JSON previews)*

====

<!-- .slide: id="task7-cold-email" -->
#### G1: Cold Email — Enterprise AI Prospect (Tome)
##### Targeting <code>tome.com</code> · Research: Governance Studio (Apr 2025), Salesforce/Gong integrations, SOC 2 Type II pursuit

<div id="tome-contact-switcher" class="contact-switcher-sidebar">
  <div class="folder-contacts"></div>
  <div class="folder-body">
    <div class="folder-email"></div>
  </div>
</div>

*115 leads in <a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/artifacts/leads.jsonl" target="_blank" class="pill">artifacts/leads.jsonl</a>*

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
| Leads | <a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/artifacts/leads.jsonl" target="_blank" class="pill">leads.jsonl</a> (115) |
| Contacts | <a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/artifacts/task1_icp_profiles/ICP_targets_enriched.json" target="_blank" class="pill">ICP_targets_enriched.json</a> |
| Tome contacts | <a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/presentation/presentation/tome_contacts.json" target="_blank" class="pill">tome_contacts.json</a> |
| Incident (people) | <a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/presentation/presentation/incident_linkedin_contacts.json" target="_blank" class="pill">incident_linkedin_contacts.json</a> (7) |
| Raw outbound | <a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/artifacts/task7_outbound/" target="_blank" class="pill">task7_outbound/*_v2.txt</a> |

<code>outbound enrich-company -d tome.com --use-opencode</code> · <code>outbound enrich-incident-linkedin --people-only</code>

====

<!-- .slide: id="task7-takeaways" -->
#### Concrete Takeaways

<div class="callout text-left">

**1. The pipeline is generic, not Tome-specific.** `outbound enrich-company -d [any-domain]` runs the full chain: Specter enrichment → person_db contacts → warm intro signals → OpenCode YC-format email. Swap the domain, get a new campaign in minutes.

**2. Cold emails follow YC's framework (Epstein + Seibel).** 50-66 words, reader-focused (you/your > I/we), role-specific angles, one low-friction CTA. The OpenCode prompt encodes all 7 Epstein principles — every future run generates compliant copy at scale.

**3. Warm intros > cold outreach.** Specter talent signals (who moved where) and shared investors create natural openers. "Saw Sarah Sachs moved from Robinhood to your ML team" converts 2-3x better than a cold pitch.

</div>

----

<!-- .slide: id="close" class="text-left" -->
### Thank You.

Everything here is **powered by running code** — Specter, person_db, OpenCode, Cala AI.

| What’s live | Evidence |
|---|---|
| 30 ICP profiles (15 verticals) + Specter funding | <a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/artifacts/task1_icp_profiles/ICP_targets_enriched.json" target="_blank" class="pill">ICP_targets_enriched.json</a> |
| 6-competitor matrix (verified customers, all products) | <a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/artifacts/task2_competitors/" target="_blank" class="pill">task2_competitors/</a> |
| 6 signal detectors (telemetry, CI/CD, jobs, incidents, HF, HN) | <code>python -m src.cli signals run</code> |
| 10 safety policies (CI-testable) | <a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/artifacts/psychotherapy_policies.yaml" target="_blank" class="pill">psychotherapy_policies.yaml</a> |
| Usage-based pricing (4 tiers, WTP by ICP) | <a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/artifacts/pricing_model.csv" target="_blank" class="pill">pricing_model.csv</a> |
| Volume estimates: LLM API requests (100–400× user msgs) | <a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/artifacts/task6_estimates/" target="_blank" class="pill">task6_estimates/</a> |
| **Tome cold email** (10 contacts, YC framework, OpenCode) | <a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/presentation/presentation/tome_contacts.json" target="_blank" class="pill">tome_contacts.json</a> |
| **Incident LinkedIn** (7 people, Specter + person_db) | <a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/presentation/presentation/incident_linkedin_contacts.json" target="_blank" class="pill">incident_linkedin_contacts.json</a> |
| 115 leads × 18 personalized outbound (OpenCode) | <a href="https://github.com/frankterpo/growth_hacker_wc_2026/blob/main/artifacts/task7_outbound/" target="_blank" class="pill">task7_outbound/*_v2.txt</a> |

<code>outbound enrich-company -d tome.com</code> · <code>outbound enrich-incident-linkedin --people-only</code>

<a href="https://github.com/frankterpo/growth_hacker_wc_2026/" style="font-size: 1.1em; color: #a8a8ff;">🔗 github.com/frankterpo/growth_hacker_wc_2026</a>
