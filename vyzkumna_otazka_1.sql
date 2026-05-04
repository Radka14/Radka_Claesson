WITH salary_data AS (
    SELECT
        branch,
        year,
        avg_salary,
        LAG(avg_salary) OVER (PARTITION BY branch ORDER BY year) AS prev_salary
    FROM t_radka_claesson_project_SQL_primary_final
)
SELECT
    branch,
    year,
    avg_salary,
    ROUND(
        (avg_salary - prev_salary) / prev_salary * 100
    , 2) AS salary_change_percent,
    CASE 
        WHEN avg_salary > prev_salary THEN 'Růst'
        WHEN avg_salary < prev_salary THEN 'Pokles'
        ELSE 'Beze změny'
    END AS trend
FROM salary_data
ORDER BY branch, year;
