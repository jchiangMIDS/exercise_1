  SELECT Measure_ID, ABS(AVG(Procedure_Score)-((MAX(Procedure_Score)-MIN(Procedure_Score))/2+MIN(Procedure_Score))) AS variability 
  FROM hospitals_scores
  GROUP BY Measure_ID 
  ORDER BY variability DESC LIMIT 10;
