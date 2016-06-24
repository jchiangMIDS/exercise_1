
#Createatable for slimmed down maintable now called procedures
CREATE TABLE procedures
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.OpenCSVSerde"
   STORED AS TEXTFILE
   AS
SELECT Provider_ID, Measure_ID, Score, Sample, State, Hospital_Name 
FROM effective_care_schema;


#Add primary key to slimmed down main table
ALTER TABLE procedures
ADD PRIMARY KEY (P_Id);


#Createatable for slimmed down surveytable called surveys
CREATE TABLE surveys
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.OpenCSVSerde"
   STORED AS TEXTFILE
   AS
SELECT Provider_Number, HCAHPS_Base_Score, HCAHPS_Consistency_Score
FROM surveys_responses_schema;


#Transform data to have Min, Max, and Range for procedure scores as dilneated by Measure_ID
CREATE TABLE scoremetrics
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.OpenCSVSerde"
   STORED AS TEXTFILE
   AS
SELECT Measure_ID, MIN(Score) AS MaxScore, MIN(Score) AS MinScore, MAX(Score)-MIN(Score) As Range 
FROM effective_care_schema 
WHERE Score BETWEEN 0 AND 5000 GROUP BY Measure_ID;


#Merge new scoremetric values with procedures
CREATE TABLE procedures_m
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.OpenCSVSerde"
   STORED AS TEXTFILE
   AS
SELECT procedures.P_Id, procedures.Provider_ID, procedures.Measure_ID, procedures.Score, 
scoremetrics.MinScore, scoremetrics.MaxScore, scoremetrics.Range, procedures.Hospital_Name, procedures.State 
FROM procedures
LEFT JOIN scoremetrics ON procedures.Measure_ID = scoremetrics.Measure_ID;


#calculate procedure_score that puts all scores on same 0to100 scale
CREATE TABLE procedure_calc
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.OpenCSVSerde"
   STORED AS TEXTFILE
   AS
SELECT P_Id, Provider_ID, (Score-MIN(Score))/Range*100 AS Procedure_Score, Hospital_Name, State
FROM procedures_m
WHERE Score BETWEEN 0 AND 5000 GROUP BY Measure_ID;


#Merge new scoremetric values with procedures
CREATE TABLE hospitals
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.OpenCSVSerde"
   STORED AS TEXTFILE
   AS
SELECT procedure_calc.P_Id, procedure_calc.Provider_ID, procedure_calc.Procedure_Score, 
surveys.HCAHPS_Base_Score, surveys.HCAHPS_Consistency_Score, procedure_calc.State, procedure_calc.Hospital_Name
FROM surveys
LEFT JOIN procedure_calc ON procedure_calc.Provider_ID = surveys.Provider_Number;

