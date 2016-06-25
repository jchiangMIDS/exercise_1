
#Createatable for slimmed down maintable now called procedures
CREATE TABLE procedures
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.columnar.ColumnarSerDe"
   STORED AS RCFile
   AS
SELECT Provider_ID, Measure_ID, Score, Sample, State, Hospital_Name 
FROM effectivecare_schema;


#Createatable for slimmed down surveytable called surveys
CREATE TABLE surveys
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.columnar.ColumnarSerDe"
   STORED AS RCFile
   AS
SELECT Provider_Number, HCAHPS_Base_Score, HCAHPS_Consistency_Score
FROM surveys_responses_schema;


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


#calculate procedure_score that puts all scores on same 0to100 scale
CREATE TABLE procedure_calc
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.columnar.ColumnarSerDe"
   STORED AS RCFile
   AS
SELECT Provider_ID, Measure_ID, (Score-MinScore)/Range*100 AS Procedure_Score, Hospital_Name, State
FROM procedures_m GROUP BY Provider_ID, Measure_ID;


#Merge new scoremetric values with procedures
CREATE TABLE hospitals
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.columnar.ColumnarSerDe"
   STORED AS RCFile
   AS
SELECT procedure_calc.Provider_ID, procedure_calc.Measure_ID, procedure_calc.Procedure_Score, 
surveys.HCAHPS_Base_Score, surveys.HCAHPS_Consistency_Score, procedure_calc.State, procedure_calc.Hospital_Name
FROM surveys
LEFT JOIN procedure_calc ON procedure_calc.Provider_ID = surveys.Provider_Number;








