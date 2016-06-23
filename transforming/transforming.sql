

#Transform data to have Min, Max, and Range for procedure scores as dilneated by Measure_ID
CREATE TABLE scoremetrics
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.OpenCSVSerde"
   STORED AS TEXTFILE
   AS
SELECT Measure_ID, MIN(Score) AS MaxScore, MIN(Score) AS MinScore, MAX(Score)-MIN(Score) As Range 
FROM effective_care_schema 
WHERE Score BETWEEN 0 AND 5000 GROUP BY Measure_ID;

#Create a table for slimmed down effective_care_schema now called procedures
CREATE TABLE procedures
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.OpenCSVSerde"
   STORED AS TEXTFILE
   AS
SELECT Provider_ID, Measure_ID, Score, Sample 
FROM effective_care_schema;

#Merge new scoremetric values with procedures
CREATE TABLE procedures_m
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.OpenCSVSerde"
   STORED AS TEXTFILE
   AS
SELECT procedures.Provider_ID, procedures.Measure_ID, procedures.Score, scoremetrics.MinScore, scoremetrics.MaxScore, scoremetrics.Range
FROM procedures
LEFT JOIN scoremetrics ON procedures.Measure_ID = scoremetrics.Measure_ID;


CREATE TABLE procedure_calc
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.OpenCSVSerde"
   STORED AS TEXTFILE
   AS
SELECT Provider_ID, (Score-MIN(Score))/Range AS Procedure_Score 
FROM procedures_m
WHERE Score BETWEEN 0 AND 5000 GROUP BY Measure_ID;


