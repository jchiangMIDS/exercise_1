CREATE TABLE best_state
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.columnar.ColumnarSerDe"
   STORED AS RCFile
   AS
SELECT State, AVG(Procedure_score) AS procedure, AVG(Variety_score) AS variety
FROM hospitals_scores 
GROUP BY State;

SELECT State, procedure*variety as scores, procedure, variety
FROM best_state
ORDER BY scores DESC
LIMIT 10;
