CREATE DATABASE assignment_1;

USE DATABASE assignment_1;

CREATE OR REPLACE STAGE stage_assignment_1
URL='azure://utsbdeparisa.blob.core.windows.net/bde-lab-2'
CREDENTIALS=(AZURE_SAS_TOKEN='sv=2024-11-04&ss=b&srt=co&sp=rwdlaciytfx&se=2025-12-30T14:01:29Z&st=2025-08-06T06:46:29Z&spr=https&sig=mJSoeiNi8O8p87gyAmvzcBDHr4YW6LA1ptTXLQcsgPA%3D
')
;

list @stage_assignment_1;

CREATE OR REPLACE EXTERNAL TABLE ex_table_youtube_trending (
    video_id varchar       AS (value:c1::varchar),
    title varchar          AS (value:c2::varchar),
    publishedAt date    AS (value:c3::date),   
    channelId varchar      AS (value:c4::varchar),
    channelTitle varchar   AS (value:c5::varchar),
    categoryId int        AS (value:c6::int),
    trending_date date  AS (value:c7::date),  
    viewCount int         AS (value:c8::int),
    likes int             AS (value:c9::int),
    dislikes int          AS (value:c10::int),
    comment_count int     AS (value:c11::int)
)
WITH LOCATION = @stage_assignment_1/trending/
FILE_FORMAT = (
    TYPE = CSV,
    FIELD_OPTIONALLY_ENCLOSED_BY = '"',
    SKIP_HEADER = 1
)
AUTO_REFRESH = FALSE;

SELECT *
    FROM ASSIGNMENT_1.PUBLIC.EX_TABLE_YOUTUBE_TRENDING
LIMIT 10;

CREATE OR REPLACE EXTERNAL TABLE ex_table_youtube_category (
    kind varchar                   AS (value:"kind"::varchar),
    etag varchar                   AS (value:"etag"::varchar),
    item_kind varchar              AS (value:"items"[0]:"kind"::varchar),
    item_etag varchar              AS (value:"items"[0]:"etag"::varchar),
    item_id int                AS (value:"items"[0]:"id"::int),
    snippet_title varchar          AS (value:"items"[0]:"snippet":"title"::varchar),
    snippet_assignable BOOLEAN    AS (value:"items"[0]:"snippet":"assignable"::BOOLEAN),
    snippet_channelId varchar      AS (value:"items"[0]:"snippet":"channelId"::varchar)
)
WITH LOCATION = @stage_assignment_1/category/
FILE_FORMAT = (
    TYPE = JSON
)
AUTO_REFRESH = FALSE;

SELECT *
FROM ASSIGNMENT_1.PUBLIC.ex_table_youtube_category
LIMIT 10;

CREATE OR REPLACE TABLE table_youtube_trending (
    video_id VARCHAR,
    title VARCHAR,
    publishedAt DATE,
    channelId VARCHAR,
    channelTitle VARCHAR,
    categoryId INT,
    trending_date DATE,
    viewCount INT,
    likes INT,
    dislikes INT,
    comment_count INT,
    country VARCHAR

);

INSERT INTO table_youtube_trending
SELECT
    video_id,
    title,
    publishedAt,
    channelId,
    channelTitle,
    categoryId,
    trending_date,
    viewCount,
    likes,
    dislikes,
    comment_count,
    SPLIT_PART(SPLIT_PART(METADATA$FILENAME, '/', -1), '_', 1) AS country
FROM ex_table_youtube_trending;

SELECT * FROM table_youtube_trending
LIMIT 10;

CREATE OR REPLACE TABLE table_youtube_category (
    country VARCHAR,
    category_id INT,
    category_title VARCHAR
);


INSERT INTO table_youtube_category
SELECT
    SPLIT_PART(SPLIT_PART(METADATA$FILENAME, '/', -1), '_', 1) AS country,
    flattened.value:id::int AS category_id,
    flattened.value:snippet:title::string AS category_title
FROM ex_table_youtube_category AS ext,
LATERAL FLATTEN(input => ext.value:items) AS flattened;

SELECT * FROM table_youtube_trending;

SELECT * FROM table_youtube_category;

CREATE OR REPLACE TABLE table_youtube_final AS
SELECT 
    UUID_STRING() AS ID,
    t.video_id,
    t.title,
    t.publishedAt,
    t.channelId,
    t.channelTitle,
    t.categoryId,
    t.trending_date,
    t.viewCount,
    t.likes,
    t.dislikes,
    t.comment_count,
    c.category_title,
    t.country,
FROM table_youtube_trending t
LEFT JOIN table_youtube_category c
ON t.CATEGORYID = c.category_id
AND t.COUNTRY = c.country;

SELECT * FROM table_youtube_final;
SELECT COUNT(*) FROM table_youtube_final;




