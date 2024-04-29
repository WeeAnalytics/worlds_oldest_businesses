# What and where are the world's oldest businesses - SQL
This is a project idea suggested on https://www.datacamp.com/blog/sql-projects-for-all-levels


In this project, I will examine the data from BusinessFinancing.co.uk to discover the oldest businesses in the world. These businesses survived changing market conditions for hundreds of years and are still operating. 

I am interested to know:
1. What are the oldest and least oldest businesses in the list.
2. How many businesses are founded before year 1000.
3. The number of businesses that were founded every century and survived till today.
4. What are the top 3 businesses in each continent?
5. What are the top 3 businesses in each categories?


## About the dataset:

- I found the original dataset on https://businessfinancing.co.uk/the-oldest-company-in-almost-every-country/#4_Oldest_Companies_in_Asia .
- The dataset is presented in a spreadsheet and are separated into different tabs, according to which continent the businesses are in.
- Using google sheets, I consolidated all the data and saved it as `Oldest companies in the world.csv`.
- I also put together `Continents.csv` which contains the countries and the continents they are in.

## About the project:

I created 2 tables in Postgresql and copied the data from the csv files to the tables.

1. `Oldest companies in the world.csv`
```
    company

    country         VARCHAR
    company_name    VARCHAR
    year_founded    INT
    category        VARCHAR
```
2. `Continents.csv`
```
    continent

    continent       VARCHAR
    country         VARCHAR
```
## Analyzing the data

1. What is the oldest and least oldest business in the list.

    - Dataset in `company` table are sorted by `year_founded` using `ORDER BY` (`ASC` for the oldest and `DESC` for the least oldest)
    - `LIMIT` is used to restrict the result by the top row only

2. How many businesses are founded before year 1000.
  
   -  The criteria of `year_founded <1000` is used in `WHERE`

3. The number of businesses that were founded every century and survived till today.

    - The `year_founded` is converted from integer to date type using `CAST(year_founded AS TEXT)`
    - `DATE_TRUNC` function is used to truncate the founding years to the nearest century
    - The data is `GROUP BY` each century 
    - `COUNT` is used to find the number of businesses each century
    
4. What are the top 3 oldest businesses in each continent?

    - An `INNER JOIN` between the `company` and `continent` tables is used to match each country to their continents
    - A common table expression (CTE) with a `ROW_NUMBER()` function is used to assign a row number based on the `year_founded`
    - `PARTITION BY` is also used in the CTE to divide the rows by their continent
    - The top 3 rows for each continent will be the 3 oldest businesses.

5. What are the top 3 businesses in each categories?

    - The approach to answering this question is similar to (4)
    - `INNER JOIN` is not required because the continent information is not needed
    
    
