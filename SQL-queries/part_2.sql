USE DATABASE assignment_1;

-- 1) In “table_youtube_category” which category_title has duplicates if we don’t take into account the categoryid (return only a single row)?

SELECT CATEGORY_TITLE, COUNT(DISTINCT CATEGORY_ID) AS num_category_ids
FROM table_youtube_category
GROUP BY CATEGORY_TITLE
HAVING COUNT(DISTINCT CATEGORY_ID) > 1;


-- 2) In “table_youtube_category” which category_title only appears in one country?

SELECT CATEGORY_TITLE, COUNT(DISTINCT COUNTRY) AS NUMBER_OF_COUNTRY
FROM table_youtube_category
GROUP BY CATEGORY_TITLE
HAVING COUNT(DISTINCT COUNTRY) =1;

-- 3) In “table_youtube_final”, what is the categoryid of the missing category_titles?

SELECT CATEGORYID FROM table_youtube_final
WHERE CATEGORY_TITLE IS NULL;

-- 4) Update the table_youtube_final to replace the NULL values in category_title with the answer from the previous question.

UPDATE table_youtube_final f
SET CATEGORY_TITLE = C.CATEGORY_TITLE
FROM table_youtube_category C
WHERE f.CATEGORYID = c.CATEGORY_ID
AND f.CATEGORY_TITLE IS NULL;


-- 5) In “table_youtube_final”, which video doesn’t have a channeltitle (return only the title)?

SELECT TITLE FROM table_youtube_final
WHERE CHANNELTITLE IS NULL;

-- 6) Delete from “table_youtube_final“, any record with video_id = “#NAME?”
SELECT COUNT(*) FROM table_youtube_final
WHERE video_id = '#NAME?';

DELETE FROM table_youtube_final
WHERE video_id = '#NAME?';


-- 7) Create a new table called “table_youtube_duplicates”  containing only the “bad” duplicates by using the row_number() function.

CREATE OR REPLACE TABLE table_youtube_duplicates AS
SELECT * FROM (
SELECT * , ROW_NUMBER() OVER (
PARTITION BY video_id, country, trending_date
ORDER BY viewcount DESC
)AS rn
from table_youtube_final
) SUB
WHERE rn >1;

SELECT COUNT(*) FROM table_youtube_duplicates;
SELECT * FROM table_youtube_duplicates;


-- 8) Delete the duplicates in “table_youtube_final“ by using “table_youtube_duplicates”.

DELETE FROM table_youtube_final t
USING table_youtube_duplicates d
WHERE t.id = d.id;



-- 9) Count the number of rows in “table_youtube_final“ and check that it is equal to 2,597,494 rows.

SELECT COUNT(*) FROM table_youtube_final;
SELECT * FROM table_youtube_final;


