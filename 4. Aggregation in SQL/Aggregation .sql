
-- AGGREGATION IN SQL ASSIGNMENT
-- Using world database

USE world;

-- ----------------------------------------------------
-- Q1: Count how many cities are there in each country
-- ----------------------------------------------------
SELECT 
    CountryCode,
    COUNT(*) AS total_cities
FROM city
GROUP BY CountryCode;

-- ----------------------------------------------------
-- Q2: Display all continents having more than 30 countries
-- ----------------------------------------------------
SELECT 
    Continent,
    COUNT(*) AS total_countries
FROM country
GROUP BY Continent
HAVING COUNT(*) > 30;

-- ----------------------------------------------------
-- Q3: List regions whose total population exceeds 200 million
-- ----------------------------------------------------
SELECT 
    Region,
    SUM(Population) AS total_population
FROM country
GROUP BY Region
HAVING SUM(Population) > 200000000;

-- ----------------------------------------------------
-- Q4: Top 5 continents by average GNP per country
-- ----------------------------------------------------
SELECT 
    Continent,
    AVG(GNP) AS avg_gnp
FROM country
GROUP BY Continent
ORDER BY avg_gnp DESC
LIMIT 5;

-- ----------------------------------------------------
-- Q5: Total number of official languages spoken in each continent
-- ----------------------------------------------------
SELECT 
    c.Continent,
    COUNT(DISTINCT cl.Language) AS total_languages
FROM country c
JOIN countrylanguage cl 
    ON c.Code = cl.CountryCode
WHERE cl.IsOfficial = 'T'
GROUP BY c.Continent;

-- ----------------------------------------------------
-- Q6: Maximum and minimum GNP for each continent
-- ----------------------------------------------------
SELECT 
    Continent,
    MAX(GNP) AS max_gnp,
    MIN(GNP) AS min_gnp
FROM country
GROUP BY Continent;

-- ----------------------------------------------------
-- Q7: Country with the highest average city population
-- ----------------------------------------------------
SELECT 
    c.Name AS country_name,
    AVG(ci.Population) AS avg_city_population
FROM city ci
JOIN country c ON c.Code = ci.CountryCode
GROUP BY ci.CountryCode
ORDER BY avg_city_population DESC
LIMIT 1;

-- ----------------------------------------------------
-- Q8: Continents where average city population > 200,000
-- ----------------------------------------------------
SELECT 
    c.Continent,
    AVG(ci.Population) AS avg_city_pop
FROM city ci
JOIN country c ON c.Code = ci.CountryCode
GROUP BY c.Continent
HAVING AVG(ci.Population) > 200000;

-- ----------------------------------------------------
-- Q9: Total population + avg life expectancy per continent
-- ----------------------------------------------------
SELECT 
    Continent,
    SUM(Population) AS total_population,
    AVG(LifeExpectancy) AS avg_life_expectancy
FROM country
GROUP BY Continent
ORDER BY avg_life_expectancy DESC;

-- ----------------------------------------------------
-- Q10: Top 3 continents with highest avg life expectancy 
--       but only where population > 200 million
-- ----------------------------------------------------
SELECT 
    Continent,
    AVG(LifeExpectancy) AS avg_life_expectancy,
    SUM(Population) AS total_population
FROM country
GROUP BY Continent
HAVING SUM(Population) > 200000000
ORDER BY avg_life_expectancy DESC
LIMIT 3;

