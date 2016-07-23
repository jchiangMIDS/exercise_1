#create variety score on a scale of 0.1 - 100.1
CREATE TABLE variety_score
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.columnar.ColumnarSerDe"
   STORED AS RCFile
   AS
SELECT Provider_ID, Measure_Count, Measure_Count/51*100+0.1 AS Variety_Score
FROM variety;
