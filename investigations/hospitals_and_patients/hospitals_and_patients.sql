
  SELECT Hospital_Name, AVG(base_score) AS base 
  FROM hospitals_scores 
  GROUP BY Hospital_Name ORDER BY base DESC LIMIT 10;
