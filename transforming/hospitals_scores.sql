#Merge nhospitals with survey results
CREATE TABLE final
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.columnar.ColumnarSerDe"
   STORED AS RCFile
   AS
SELECT hospitals.Provider_ID, hospitals.Measure_ID, hospitals.Procedure_Score, 
survey_calc.base_score, survey_calc.consistency_score, 
hospitals.State, hospitals.Hospital_Name 
FROM survey_calc
LEFT JOIN hospitals ON hospitals.Provider_ID = survey_calc.Provider_Number;

CREATE TABLE hospitals_scores
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.columnar.ColumnarSerDe"
   STORED AS RCFile
   AS
SELECT final.Provider_ID, final.Measure_ID, final.Procedure_Score, 
variety_score.Variety_Score, final.base_score, final.consistency_score, 
final.State, final.Hospital_Name 
FROM variety_score
LEFT JOIN final ON final.Provider_ID = variety_score.Provider_ID;
