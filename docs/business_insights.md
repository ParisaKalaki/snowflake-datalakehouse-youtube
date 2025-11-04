# Business Questions & Insights

**Project:** Data Lakehouse with Snowflake  
**Author:** Parisa

---

## How this document is organised

- Each business question (Q1–Q5 and final business question) includes:
  - The objective / SQL approach (file reference in `SQL_queries/`)
  - A short results summary
  - Key insights and recommended action
  - A link or embedded figure (screenshot or chart) located in `docs/images/`

---

## Q1 — Top 3 most-viewed Gaming videos per country on 2024-04-01

**SQL:** `SQL_queries/part_3.sql` (Q1 section)  
**Objective:** For each of the 10 countries, return the top 3 Gaming videos on `trending_date = '2024-04-01'`, ordered by country and rank.  
**Approach:** Filter category = 'Gaming', filter date, compute ROW_NUMBER() partitioned by country ordered by viewcount, QUALIFY rank ≤ 3.

**Result (summary):**

- Global dominance by certain titles (e.g., _Clash Royale — "Dagger Duchess"_) across multiple countries.
- Local stars (e.g., Techno Gamerz in India, キヨ。 in Japan) top their domestic charts.
- Highest single-video count observed: Fernanfloo (Mexico) ≈ 7.2M views.

**Key insights & implications:**

- Titles with cross-market appeal (English or visual gameplay) perform across many countries.
- Localized creators retain strong market share — useful for geo-targeted ad strategies.

**Figures:**

- Table sample: `images/q1_table_sample.png`
- Heat grid of top 3 view counts: `images/q1_top3_heatmap.png`

---

## Q2 — Count of distinct videos with "BTS" in title by country

**SQL:** `SQL_queries/part_3.sql` (Q2 section)  
**Objective:** For each country, count distinct videos with titles containing "BTS" (case-insensitive).  
**Approach:** `LOWER(title) LIKE '%bts%'` then `COUNT(DISTINCT video_id)` grouped by country.

**Result (summary):**

- Korea leads (468 distinct BTS-related videos), followed by India and the US. Western countries (CA, DE, UK) also show notable counts; France and Brazil have lower counts on the sampled day.

**Key insights:**

- BTS content has strong local and global presence — useful when planning music/culture related campaigns.
- High counts in India and US suggest active fan communities producing content (reaction videos, fan edits, covers).

**Figure:**

- Table sample: `images/q2_table_sample.png`
- bar chart: `images/q2_bts_count_chart.png`

---

## Q3 — Monthly top-viewed video & likes_ratio for 2024

**SQL:** `SQL_queries/part_3.sql` (Q3 section)  
**Objective:** For each country, year_month (YYYY-MM), and year 2024 only, return the most viewed video and its `likes_ratio = (likes / NULLIF(viewcount,0)) * 100` truncated to 2 decimals.

**Result (summary):**

- Some channels (e.g., MrBeast) repeatedly top many country-month pairs.
- Viral outlier: "Discord Loot Boxes" (April 2024) → ~1.4B views with likes_ratio ≈ 0.01% (huge reach but little interaction).
- Likes_ratio varies widely (0.01% – 6.73%).

**Key insights:**

- Very high view counts do not guarantee engagement — content with high views and high likes_ratio is more valuable for sustained monetization.
- Use likes_ratio as a filter when choosing partners or creators to promote brands.

**Figure:**

- Table sample: `images/q3_table_sample.png`
- chart: `images/q3_monthly_top_table.png`

---

## Q4 — Top category by distinct videos per country (since 2022)

**SQL:** `SQL_queries/part_3.sql` (Q4 section)  
**Objective:** For each country, find the category with the most distinct videos and its percentage of the country’s distinct videos (two decimals). Data window: 2022 onwards.

**Result (summary):**

- **Entertainment** dominates most countries (20%–42% of distinct videos).
- **Gaming** leads in Canada and the US (~21–22%).
- Country exceptions: IN & KR — _People & Blogs_ leads; GB & DE — _Sports_ leads.

**Key insight:**

- Content strategy should default to Gaming for North America, but adopt People & Blogs for IN/KR and Sports for GB/DE.

**Figure:**

- Table sample: `images/q4_table_sample.png`
- chart: `images/q4_bar_chart.png`

---

## Q5 — Channel with most distinct videos

**SQL:** `SQL_queries/part_3.sql` (Q5 section)  
**Objective:** Find which `channelTitle` uploaded the most distinct videos (COUNT(DISTINCT video_id)) and return that number.

**Result:**

- **Vijay Television** — 2,049 distinct videos (highest in the dataset).

**Key insight:**

- High-volume publishers (TV networks, serial channels) maintain consistency and audience retention — great for sponsorship and episodic advertising.

**Figure:**

- Table sample: `images/q5_table_sample.png`

---

## Final Business Question — Best category to launch a channel (excl. Music & Entertainment)

**SQL:** `SQL_queries/part_4.sql` (business question section)  
**Summary result:**

- **Gaming** is the strongest overall when excluding Music & Entertainment: highest total views, highest trending counts, and strong engagement.
- Country nuances: IN & KR favor People & Blogs; DE & GB favor Sports.

**Recommendation:**

- Launch a Gaming channel for broad reach, but localize or blend with People & Blogs (IN/KR) or Sports themes (DE/GB).
- Emphasise visuals, regular schedule, and engagement prompts to increase likes_ratio.

**Figure:**

- Overview: `images/q6_business_strategy_overview.png` (optional)
- Total views: `images/q6_total_views.png`
- Trending Count: `images/q6_btrending_count.png`

---

## Appendix

- **SQL files:** See `SQL_queries/` — each question’s query is included and commented.
- **Raw results screenshots:** `docs/images/` contains the result tables and charts.
- **Notes & data cleaning:** Refer to `README.md` and `SQL_queries/part3_cleaning.sql` for deduplication logic and fixes (e.g., `ROW_NUMBER()` approach).

---
