CREATE TABLE procedures
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.columnar.ColumnarSerDe"
   STORED AS RCFile
   AS
SELECT Provider_ID, Measure_ID, Score, Sample, State, Hospital_Name 
FROM effectivecare_schema;
