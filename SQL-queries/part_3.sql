USE DATABASE assignment_1;

-- 1) What are the 3 most viewed videos for each country in the Gaming category for the trending_date = 2024-04-01. Order the result by country and the rank, 

SELECT COUNTRY,
    TITLE,
    CHANNELTITLE,
    VIEWCOUNT,
ROW_NUMBER() OVER (
PARTITION BY COUNTRY
ORDER BY VIEWCOUNT DESC
) AS RK
FROM table_youtube_final
WHERE CATEGORY_TITLE = 'Gaming'
AND TRENDING_DATE = '2024-04-01'
QUALIFY RK <=3
ORDER BY COUNTRY, RK;

-- 2) For each country, count the number of distinct video with a title containing the word “BTS” (case insensitive) and order the result by count in a descending order.

SELECT COUNTRY, COUNT(DISTINCT VIDEO_ID) AS CT
FROM table_youtube_final
WHERE LOWER(TITLE) LIKE '%bts%'
GROUP BY COUNTRY
ORDER BY CT DESC;

-- 3) For each country, year and month (in a single column) and only for the year 2024, which video is the most viewed and what is its likes_ratio(defined as the percentage of likes against view_count) truncated to 2 decimals. Order the result by year_month and country. 

WITH RANKED_VIDEOS AS (
  SELECT
    COUNTRY,
    TO_CHAR(DATE_TRUNC('month', TRENDING_DATE), 'YYYY-MM-DD') AS YEAR_MONTH,
    TITLE,
    CHANNELTITLE,
    CATEGORY_TITLE,
    VIEWCOUNT,
    LIKES,
    ROW_NUMBER() OVER (
      PARTITION BY COUNTRY, DATE_TRUNC('month', TRENDING_DATE)
      ORDER BY VIEWCOUNT DESC
    ) AS rn
  FROM table_youtube_final
  WHERE EXTRACT(YEAR FROM TRENDING_DATE) = 2024
)

SELECT
  COUNTRY,
  YEAR_MONTH,
  TITLE,
  CHANNELTITLE,
  CATEGORY_TITLE,
  VIEWCOUNT,
  ROUND((LIKES * 100.0) / NULLIF(VIEWCOUNT, 0), 2) AS likes_ratio
FROM RANKED_VIDEOS
WHERE rn = 1
ORDER BY YEAR_MONTH, COUNTRY;


-- 4) For each country, which category_title has the most distinct videos and what is its percentage (2 decimals) out of the total distinct number of videos of that country? Only look at the data from 2022. Order the result by category_title and country. 
    
WITH category_counts AS (
    SELECT
        COUNTRY,
        CATEGORY_TITLE,
        COUNT(DISTINCT VIDEO_ID) AS total_category_video
    FROM table_youtube_final
    WHERE EXTRACT(YEAR FROM TRENDING_DATE) >= 2022
    GROUP BY COUNTRY, CATEGORY_TITLE
),
country_totals AS (
    SELECT
        COUNTRY,
        COUNT(DISTINCT VIDEO_ID) AS total_country_video
    FROM table_youtube_final
    WHERE EXTRACT(YEAR FROM TRENDING_DATE) >= 2022
    GROUP BY COUNTRY
),
ranked_categories AS (
    SELECT
        c.COUNTRY,
        c.CATEGORY_TITLE,
        c.total_category_video,
        t.total_country_video,
        ROUND((c.total_category_video * 100.0) / NULLIF(t.total_country_video, 0), 2) AS percentage,
        RANK() OVER (PARTITION BY c.COUNTRY ORDER BY c.total_category_video DESC) AS rnk
    FROM category_counts c
    JOIN country_totals t
      ON c.COUNTRY = t.COUNTRY
)
SELECT
    COUNTRY,
    CATEGORY_TITLE,
    total_category_video,
    total_country_video,
    percentage
FROM ranked_categories
WHERE rnk = 1
ORDER BY CATEGORY_TITLE, COUNTRY;



-- 5) Which channeltitle has produced the most distinct videos and what is this number? 

SELECT CHANNELTITLE, COUNT(DISTINCT VIDEO_ID) AS DISTINCT_VIDEOS
FROM table_youtube_final
GROUP BY CHANNELTITLE
ORDER BY DISTINCT_VIDEOS DESC
LIMIT 1;



