# YouTube Trends Lakehouse

## Overview

This project implements a **Data Lakehouse architecture using Snowflake** to analyze multi-format YouTube trending video data.  
It focuses on cloud-based ingestion, transformation, and analytical querying of data stored in Snowflake.

## Objectives

- Ingest YouTube trend and category data (CSV & JSON) from Azure Storage.
- Clean and transform datasets within Snowflake.
- Deliver insights on trending videos, categories, and engagement metrics across countries.
- Answer data-driven business questions to support **content and marketing strategy decisions**.

## Technologies Used

- **Snowflake** — Data Lakehouse and SQL analytics
- **Azure Storage** — Cloud data source for ingestion
- **SQL** — Core transformation and analytics

## Repository Structure

```
youtube-trends-lakehouse/
│
├── README.md
├── .gitignore
├── SQL_queries/
│ ├── part1_ingestion.sql
│ ├── part2_transformation.sql
│ ├── part3_cleaning.sql
│ ├── part4_analysis.sql
│
├── data/
│ ├── youtube_trending/
│ ├── youtube-category/
│
├── docs/business_insights.md
└── reports/
└── youtube_trends_report.pdf
```

## 📊 Business Insights

Detailed questions and insights are documented [here](docs/business_insights.md).

## 🧩 SQL Breakdown by Part

| Part                                    | File         | Description                                                                                                                                                                                                                                                                                                                                                                               |
| --------------------------------------- | ------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Part 1 – Data Ingestion**             | `part_1.sql` | Handles **loading multi-format YouTube data (CSV + JSON)** from **Azure Storage** into **Snowflake**. Creates the database, stage, and external tables, and loads data into permanent tables for analysis.                                                                                                                                                                                |
| **Part 2 – Data Cleaning**              | `part_2.sql` | Performs data quality checks and transformations — removing duplicates, fixing missing category titles, cleaning invalid records (`video_id = '#NAME'`), and standardizing columns.                                                                                                                                                                                                       |
| **Part 3 – Business Questions**         | `part_3.sql` | Contains **five analytical SQL queries** exploring performance, engagement, and category patterns:<br> 1️⃣ Top 3 most-viewed Gaming videos per country (2024-04-01)<br> 2️⃣ Distinct “BTS”-related videos by country<br> 3️⃣ Monthly top video and engagement ratio (2024)<br> 4️⃣ Most common category by distinct videos per country (since 2022)<br> 5️⃣ Channel with most distinct uploads |
| **Part 4 – Business Strategy Question** | `part_4.sql` | Answers the strategic question:<br> **“If you were to launch a new YouTube channel tomorrow, which category (excluding ‘Music’ and ‘Entertainment’) would you create to appear in the top trends of YouTube? Will this strategy work in every country?”**<br><br>Analyzes category-level trends and engagement metrics to recommend an optimal content strategy by region.                |

---

## Notes

- Screenshots, charts, and visual summaries for each question are available under `docs/images/`.
