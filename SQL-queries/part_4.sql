-- If you were to launch a new Youtube channel tomorrow, which category (excluding “Music” and “Entertainment”) of video will you be trying to create to have them appear in the top trend of Youtube? Will this strategy work in every country?

USE DATABASE assignment_1;
SELECT * FROM table_youtube_final;

-- MOST TRENDING CATEGORY
SELECT CATEGORY_TITLE, COUNT(CATEGORY_TITLE) AS CATEGORY_TRENDY_COUNTS
FROM table_youtube_final
WHERE NOT CATEGORY_TITLE = 'Entertainment'
AND NOT CATEGORY_TITLE = 'Music'
GROUP BY CATEGORY_TITLE
ORDER BY CATEGORY_TRENDY_COUNTS DESC;

--MOST VIEWS BY CATEGORY

SELECT CATEGORY_TITLE, SUM(VIEWCOUNT) AS TOTAL_VIEW_COUNTS
FROM table_youtube_final
WHERE NOT CATEGORY_TITLE = 'Entertainment'
AND NOT CATEGORY_TITLE = 'Music'
GROUP BY CATEGORY_TITLE
ORDER BY TOTAL_VIEW_COUNTS DESC;

-- ENGAGEMENT RATE BY CATEGORY

SELECT CATEGORY_TITLE,
       ROUND(AVG((LIKES + COMMENT_COUNT) / NULLIF(VIEWCOUNT, 0)), 4) AS avg_engagement_rate
FROM table_youtube_final
WHERE CATEGORY_TITLE NOT IN ('Music', 'Entertainment')
GROUP BY CATEGORY_TITLE
ORDER BY avg_engagement_rate DESC;

-- Country-Specific Category Trends
SELECT COUNTRY, CATEGORY_TITLE, COUNT(*) AS CATEGORY_COUNTS
FROM table_youtube_final
WHERE CATEGORY_TITLE NOT IN ('Music', 'Entertainment')
GROUP BY COUNTRY, CATEGORY_TITLE
ORDER BY CATEGORY_COUNTS DESC;



