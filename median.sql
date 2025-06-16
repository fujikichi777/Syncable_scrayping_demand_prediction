SELECT 
  "団体ラベル名",
  COUNT("現在集まっている金額") AS 件数,
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY "現在集まっている金額") AS 中央金額
FROM 
  kifu_filtered
GROUP BY 
  "団体ラベル名";
