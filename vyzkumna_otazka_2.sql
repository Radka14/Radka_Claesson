SELECT
    year,
    good,
    price_unit,
    ROUND(AVG(avg_salary)::numeric, 2) AS avg_salary,
    ROUND(AVG(avg_price)::numeric, 2) AS avg_price,
    ROUND(
        (AVG(avg_salary) / AVG(avg_price))::numeric,
        2
    ) AS quantity_affordable
FROM t_radka_claesson_project_SQL_primary_final
WHERE good IN ('Chléb konzumní kmínový', 'Mléko polotučné pasterované')
  AND year IN (
      (SELECT MIN(year) FROM t_radka_claesson_project_SQL_primary_final),
      (SELECT MAX(year) FROM t_radka_claesson_project_SQL_primary_final)
  )
GROUP BY year, good, price_unit
ORDER BY year, good;


