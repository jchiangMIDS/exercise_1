#calculate procedure_score that puts all scores on same 0to100 scale
CREATE TABLE procedure_calc
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.columnar.ColumnarSerDe"
   STORED AS RCFile
   AS
SELECT Provider_ID, Measure_ID, (Score-MinScore)*100/Range+0.1 AS Procedure_Score
FROM procedures_m WHERE Score BETWEEN 0 AND 5000; 
