#Merge new procedure_score values with procedures
CREATE TABLE hospitals
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.columnar.ColumnarSerDe"
   STORED AS RCFile
   AS
SELECT procedure_calc.Provider_ID, procedure_calc.Measure_ID, procedure_calc.Procedure_Score, 
procedures_m.State, procedures_m.Hospital_Name
FROM procedures_m
LEFT JOIN procedure_calc ON procedure_calc.Provider_ID = procedures_m.Provider_ID;
