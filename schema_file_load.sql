-- create a table for the companies
CREATE TABLE company (
    country         VARCHAR,
    company_name        VARCHAR,
    year_founded    INT, 
    category        VARCHAR
 );

--Create a table for the continents and countries
CREATE TABLE continent (
    continent       VARCHAR,
    country         VARCHAR
 );


-- loading data into the company table
COPY company
FROM '/mnt/c/Users/kyoto/OneDrive/Documents/Oldest_company_SQL/Oldest companies in the world.csv'
DELIMITER ',' CSV HEADER NULL 'NULL';


-- loading data into the continent table
COPY continent
FROM '/mnt/c/Users/kyoto/OneDrive/Documents/Oldest_company_SQL/Continent.csv'
WITH CSV HEADER;