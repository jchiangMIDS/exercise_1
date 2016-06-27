
#Createatable for slimmed down maintable now called procedures
CREATE TABLE procedures
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.columnar.ColumnarSerDe"
   STORED AS RCFile
   AS
SELECT Provider_ID, Measure_ID, Score, Sample, State, Hospital_Name 
FROM effectivecare_schema;


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
SELECT Provider_ID, Measure_ID, (Score-MinScore)*100/Range+0.1 AS Procedure_Score
FROM procedures_m WHERE Score BETWEEN 0 AND 5000; 


#Merge new procedure_score values with procedures
CREATE TABLE hospitals
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.columnar.ColumnarSerDe"
   STORED AS RCFile
   AS
SELECT procedure_calc.Provider_ID, procedure_calc.Measure_ID, procedure_calc.Procedure_Score, 
procedures_m.State, procedures_m.Hospital_Name
FROM procedures_m
LEFT JOIN procedure_calc ON procedure_calc.Provider_ID = procedures_m.Provider_ID;


#Merge nhospitals with survey results
CREATE TABLE hospitals_final
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.columnar.ColumnarSerDe"
   STORED AS RCFile
   AS
SELECT hospitals.Provider_ID, hospitals.Measure_ID, hospitals.Procedure_Score, 
surveys_responses_schema.HCAHPS_Base_Score, surveys_responses_schema.HCAHPS_Consistency_Score, 
hospitals.State, hospitals.Hospital_Name 
FROM surveys_responses_schema
LEFT JOIN hospitals ON hospitals.Provider_ID = surveys_responses_schema.Provider_Number;









