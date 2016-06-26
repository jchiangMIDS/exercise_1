  SELECT Measure_ID, ABS(AVG(Procedure_Score)-50.05) AS variability 
  FROM hospitals_scores
  GROUP BY Measure_ID 
  ORDER BY variability DESC LIMIT 10;
