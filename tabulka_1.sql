CREATE TABLE t_radka_claesson_project_SQL_primary_final AS
WITH avg_salary AS (
    SELECT
        p.payroll_year AS year,
        p.industry_branch_code AS id_branch,
        i.name AS branch,
        AVG(p.value) AS avg_salary
    FROM czechia_payroll p
    JOIN czechia_payroll_industry_branch i
        ON p.industry_branch_code = i.code
    WHERE p.value_type_code = 5958
      AND p.calculation_code = 200
    GROUP BY p.payroll_year, p.industry_branch_code, i.name
),
avg_price AS (
    SELECT
        EXTRACT(YEAR FROM cp.date_from)::integer AS year,
        cp.category_code AS id_goods,
        cpc.name AS good,
        AVG(cp.value) AS avg_price,
        CASE 
            WHEN cpc.name LIKE '%Mléko%' THEN 'l'
            WHEN cpc.name LIKE '%Chléb%' THEN 'kg'
            ELSE 'ks'
        END AS price_unit
    FROM czechia_price cp
    JOIN czechia_price_category cpc
        ON cp.category_code = cpc.code
    GROUP BY EXTRACT(YEAR FROM cp.date_from)::integer, cp.category_code, cpc.name
)
SELECT
    s.year,
    s.id_branch,
    s.branch,
    s.avg_salary,
    p.id_goods,
    p.good,
    p.avg_price,
    p.price_unit
FROM avg_salary s
JOIN avg_price p
    ON s.year = p.year
ORDER BY s.year, s.id_branch, p.id_goods;
