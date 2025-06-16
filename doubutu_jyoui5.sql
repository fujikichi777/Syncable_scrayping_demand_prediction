WITH filtered AS (
  SELECT *
  FROM kifu_filtered
  WHERE "団体ラベル名" = '動物を守りたい'
),
threshold AS (
  SELECT PERCENTILE_CONT(0.8) WITHIN GROUP (ORDER BY "現在集まっている金額") AS p80
  FROM filtered
)
SELECT f.*
FROM filtered f
JOIN threshold t ON f."現在集まっている金額" >= t.p80
ORDER BY f."現在集まっている金額" DESC;
