WITH TotalSpend AS(
SELECT 
      id_user,
      id_region,
      SUM(amount) AS total_spend
FROM `zeta-ascent-478317-f3.test.task 1` 
GROUP BY id_user, id_region
),
AverageSpendRegion AS(
SELECT
      id_user,
      id_region,
      total_spend,
      AVG(total_spend) OVER (PARTITION BY id_region) AS avg_regional_spend
FROM TotalSpend
)
SELECT
      id_region,
      id_user,
      total_spend,
      avg_regional_spend
FROM AverageSpendRegion
WHERE total_spend > avg_regional_spend
ORDER BY id_region, total_spend DESC
