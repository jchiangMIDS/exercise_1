#Rank hospitals by best average procedure_scores across all their procedures

SELECT Hospital_Name, AVG(Procedure_score) AS score 
FROM hospitals 
GROUP BY Hospital_Name 
ORDER BY score DESC
LIMIT 100;
