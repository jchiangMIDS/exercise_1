
#Transform data to have Min, Max, and Range for procedure scores as dilneated by Measure_ID
CREATE TABLE survey_m
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.columnar.ColumnarSerDe"
   STORED AS RCFile
   AS
SELECT MIN(hcahps_base_score*100/100) AS Base_MinScore, MAX(hcahps_base_score*100/100) AS Base_MaxScore, 
MAX(hcahps_base_score*100/100)-MIN(hcahps_base_score*100/100) As Base_Range, 
MIN(hcahps_consistency_score*100/100) AS Consistency_MinScore, 
MAX(hcahps_consistency_score*100/100) AS Consistency_MaxScore, 
MAX(hcahps_consistency_score*100/100)-MIN(hcahps_consistency_score*100/100) As Consistency_Range 
FROM surveys_responses_schema;


