WITH salary_yearly AS (
    SELECT
        year,
        AVG(avg_salary) AS avg_salary_year
    FROM t_radka_claesson_project_SQL_primary_final
    GROUP BY year
),
salary_growth AS (
    SELECT
        year,
        avg_salary_year,
        LAG(avg_salary_year) OVER (ORDER BY year) AS prev_salary,
        ((avg_salary_year - LAG(avg_salary_year) OVER (ORDER BY year))
            / LAG(avg_salary_year) OVER (ORDER BY year) * 100) AS salary_growth_pct
    FROM salary_yearly
),
price_yearly AS (
    SELECT
        year,
        AVG(avg_price) AS avg_price_year
    FROM t_radka_claesson_project_SQL_primary_final
    GROUP BY year
),
price_growth AS (
    SELECT
        year,
        avg_price_year,
        LAG(avg_price_year) OVER (ORDER BY year) AS prev_price,
        ((avg_price_year - LAG(avg_price_year) OVER (ORDER BY year))
            / LAG(avg_price_year) OVER (ORDER BY year) * 100) AS price_growth_pct
    FROM price_yearly
)
SELECT
    s.year,
    ROUND(s.salary_growth_pct::numeric, 2) AS salary_growth_pct,
    ROUND(p.price_growth_pct::numeric, 2) AS price_growth_pct,
    ROUND((p.price_growth_pct - s.salary_growth_pct)::numeric, 2) AS difference_pct,
    CASE
        WHEN (p.price_growth_pct - s.salary_growth_pct) > 10 THEN 'Cena rostla >10% rychleji než mzdy'
        ELSE 'Cena rostla pomaleji než mzdy nebo méně než 10%'
    END AS note
FROM salary_growth s
JOIN price_growth p
    ON s.year = p.year
WHERE s.salary_growth_pct IS NOT NULL
  AND p.price_growth_pct IS NOT NULL
ORDER BY s.year;
