CREATE TABLE t_radka_claesson_project_SQL_secondary_final AS
SELECT
    e.country,
    e.year,
    e.gdp,
    e.population,
    e.gini
FROM data_academy_content.economies e
JOIN data_academy_content.countries c
    ON e.country = c.country
WHERE
    c.continent = 'Europe'
    AND e.year BETWEEN 2006 AND 2018
    AND e.gdp IS NOT NULL
    AND e.population IS NOT NULL;
