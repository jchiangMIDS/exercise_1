

#Add simplified survey datatable
CREATE TABLE survey_calc
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.columnar.ColumnarSerDe"
   STORED AS RCFile
   AS
SELECT Provider_Number, hcahps_base_score*100/80+0.1 AS base_score, (hcahps_consistency_score-1)*100/19+0.1 AS consistency_score
FROM surveys_responses_schema;

