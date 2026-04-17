WITH yearly_prices AS (
    SELECT
        year,
        id_goods,
        good,
        AVG(avg_price) AS avg_year_price
    FROM t_radka_claesson_project_SQL_primary_final
    GROUP BY year, id_goods, good
),
price_growth AS (
    SELECT
        year,
        id_goods,
        good,
        avg_year_price,
        LAG(avg_year_price) OVER (PARTITION BY id_goods ORDER BY year) AS prev_price
    FROM yearly_prices
)
SELECT
    good,
    ROUND(
        AVG(
            ((avg_year_price - prev_price) / prev_price)::numeric * 100
        ),
        2
    ) AS avg_yearly_growth_percent
FROM price_growth
WHERE prev_price IS NOT NULL
GROUP BY good
ORDER BY avg_yearly_growth_percent
LIMIT 1;
