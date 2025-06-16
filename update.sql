CREATE TABLE kifu_filtered AS
SELECT *
FROM kifu
WHERE "タイトル" IS NOT NULL
AND "現在集まっている金額" IS NOT NULL
AND "説明文" IS NOT NULL
AND "住所" IS NOT NULL
AND "開始日" IS NOT NULL
AND "終了日" IS NOT NULL
AND "団体名" IS NOT NULL
AND "団体ラベル名" IS NOT NULL;

UPDATE kifu_filtered
SET "現在集まっている金額" = NULLIF(
  REGEXP_REPLACE(
    REGEXP_REPLACE("現在集まっている金額", '円', '', 'g'),
    ',', '', 'g'
  ), ''
)::numeric;-- もし「現在集まっている金額」カラムが文字列の場合、numericに変換してからテキストに戻す例

UPDATE kifu_filtered
SET "目標金額" = NULLIF(
    REGEXP_REPLACE(
        REGEXP_REPLACE(
            REGEXP_REPLACE("目標金額", '[円,/]', '', 'g'),
        ',', '', 'g'),
    '', NULL)
::numeric, '');

-- 「開始日」の変換
UPDATE kifu_filtered
SET "開始日" = TO_DATE("開始日", 'YYYY年MM月DD日');

-- 「終了日」の変換
UPDATE kifu_filtered
SET "終了日" = TO_DATE("終了日", 'YYYY年MM月DD日');

-- 年カラムを追加
ALTER TABLE kifu_filtered ADD COLUMN "開始日_年" INTEGER;
ALTER TABLE kifu_filtered ADD COLUMN "開始日_月" INTEGER;
ALTER TABLE kifu_filtered ADD COLUMN "開始日_日" INTEGER;

-- 年・月・日を抽出して代入
UPDATE kifu_filtered
SET 
  "開始日_年" = EXTRACT(YEAR FROM "開始日"),
  "開始日_月" = EXTRACT(MONTH FROM "開始日"),
  "開始日_日" = EXTRACT(DAY FROM "開始日");

-- 同様に終了日も
ALTER TABLE kifu_filtered ADD COLUMN "終了日_年" INTEGER;
ALTER TABLE kifu_filtered ADD COLUMN "終了日_月" INTEGER;
ALTER TABLE kifu_filtered ADD COLUMN "終了日_日" INTEGER;

UPDATE kifu_filtered
SET 
"終了日_年" = EXTRACT(YEAR FROM "終了日"),
"終了日_月" = EXTRACT(MONTH FROM "終了日"),
"終了日_日" = EXTRACT(DAY FROM "終了日");