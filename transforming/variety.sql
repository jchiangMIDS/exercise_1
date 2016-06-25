
CREATE TABLE procedures_number
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.columnar.ColumnarSerDe"
   STORED AS RCFile
   AS
SELECT DISTINCT Measure_ID
FROM effectivecare_schema;

SELECT Count(Measure_ID) FROM procedures_number;

CREATE TABLE variety
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.columnar.ColumnarSerDe"
   STORED AS RCFile
   AS
SELECT Provider_ID, COUNT(Score) AS Measure_Count
FROM effectivecare_schema
WHERE Score BETWEEN 0 AND 5000 GROUP BY Provider_ID;






