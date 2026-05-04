SELECT
    t.year,
    t.gdp,
    t.avg_wage,
    t.avg_food_price,
    (t.gdp - LAG(t.gdp) OVER (ORDER BY t.year))
        / LAG(t.gdp) OVER (ORDER BY t.year) * 100 AS gdp_growth,
    (t.avg_wage - LAG(t.avg_wage) OVER (ORDER BY t.year))
        / LAG(t.avg_wage) OVER (ORDER BY t.year) * 100 AS wage_growth,
    (t.avg_food_price - LAG(t.avg_food_price) OVER (ORDER BY t.year))
        / LAG(t.avg_food_price) OVER (ORDER BY t.year) * 100 AS price_growth
FROM (
    SELECT
        p.year,
        s.gdp,
        AVG(p.avg_salary) AS avg_wage,
        AVG(p.avg_price) AS avg_food_price
    FROM t_radka_claesson_project_sql_primary_final p
    JOIN t_radka_claesson_project_sql_secondary_final s
        ON p.year = s.year
    WHERE s.country = 'Czech Republic'
    GROUP BY
        p.year,
        s.gdp
) t
ORDER BY t.year;
