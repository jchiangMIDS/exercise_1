#Transform data to have Min, Max, and Range for procedure scores as dilneated by Measure_ID
CREATE TABLE scoremetrics
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.columnar.ColumnarSerDe"
   STORED AS RCFile
   AS
SELECT Measure_ID, MIN(Score*100/100) AS MinScore, MAX(Score*100/100) AS MaxScore, MAX(Score*100/100)-MIN(Score*100/100) As Range 
FROM effectivecare_schema
WHERE Score BETWEEN 0 AND 5000 GROUP BY Measure_ID;


#Merge new scoremetric values with procedures
CREATE TABLE procedures_m
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.columnar.ColumnarSerDe"
   STORED AS RCFile
   AS
SELECT procedures.Provider_ID, procedures.Measure_ID, procedures.Score, 
scoremetrics.MinScore, scoremetrics.MaxScore, scoremetrics.Range, procedures.Hospital_Name, procedures.State 
FROM procedures
LEFT JOIN scoremetrics ON procedures.Measure_ID = scoremetrics.Measure_ID;
