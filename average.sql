SELECT 
  "団体ラベル名",
  COUNT("現在集まっている金額") AS 件数,
  AVG("現在集まっている金額") AS 平均金額
FROM 
  kifu_filtered
GROUP BY 
  "団体ラベル名";