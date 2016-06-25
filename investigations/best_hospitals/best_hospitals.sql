#Rank hospitals by best average procedure_scores across all their procedures
CREATE TABLE best_provider
   ROW FORMAT SERDE "org.apache.hadoop.hive.serde2.columnar.ColumnarSerDe"
   STORED AS RCFile
   AS
SELECT Hospital_Name, AVG(Procedure_score) AS procedure, AVG(Variety_score) AS variety
FROM hospitals_scores 
GROUP BY Hospital_Name;


  SELECT Hospital_Name, procedure*variety as scores, procedure, variety
  FROM best_provider
  ORDER BY scores DESC
  LIMIT 20;
