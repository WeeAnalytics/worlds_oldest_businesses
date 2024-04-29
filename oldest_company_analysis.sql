-- oldest company 
SELECT company_name, 
       year_founded,
       country
FROM company    
ORDER BY year_founded ASC
LIMIT 1;

-- least oldest company
SELECT company_name, 
       year_founded,
       country
FROM company    
WHERE year_founded IS NOT NULL
ORDER BY year_founded DESC
LIMIT 1;

--companies founded before year 1000
SELECT *
FROM company    
WHERE year_founded <1000
;

--Number of oldest companies every century
SELECT EXTRACT(YEAR FROM DATE_TRUNC('century',TO_DATE(CAST(year_founded AS TEXT),'YYYY'))) AS start_of_century,
       COUNT(*) AS num_of_companies
FROM company
WHERE year_founded IS NOT NULL
GROUP BY DATE_TRUNC('century',TO_DATE(CAST(year_founded AS TEXT),'YYYY'))
ORDER BY start_of_century ASC;

--Counting the number of companies in each continent
SELECT  continent,
        COUNT(company_name) as company_count
FROM company INNER JOIN continent ON company.country = continent.country
WHERE year_founded IS NOT NULL
GROUP BY continent
ORDER BY company_count DESC;
       
-- top 3 oldest companies in each continent
WITH year_founded_rank AS (
    SELECT continent,
           company_name,
           year_founded,
           category,
           ROW_NUMBER() OVER(PARTITION BY continent ORDER BY year_founded ASC) AS row_num
    FROM company INNER JOIN continent ON company.country = continent.country
    WHERE year_founded IS NOT NULL)

SELECT *
FROM year_founded_rank
WHERE row_num <=3;

-- top 3 oldest companies in each category
WITH category_rank AS(
SELECT category,
       company_name,
       year_founded,
       country,
       ROW_NUMBER() OVER(PARTITION BY category ORDER BY year_founded ASC) AS rank
FROM company
WHERE year_founded IS NOT NULL)

SELECT * 
FROM category_rank
WHERE rank <=3;
