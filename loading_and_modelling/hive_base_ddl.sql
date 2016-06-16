DROP TABLE <table_name>;
CREATE EXTERNAL TABLE <table_name> (<col1_name>, <col1_type>, …)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
 "separatorChar" = ",",
 "quoteChar" = '"',
  "escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION ‘/path/in/hdfs’;

DROP TABLE effective_care;
CREATE EXTERNAL TABLE effective_care (Provider_Number STRING, Hospital_Name STRING,
Address STRING, City STRING, State STRING, ZIP_Code STRING, County_Name STRING, 
Communication_with_Nurses_Achievement_Points STRING, Communication_with_Nurses_Improvement_Points STRING,
Communication_with_Nurses_Dimension_Score STRING, Communication_with_Doctors_Achievement_Points STRING, 
Communication_with_Doctors_Improvement_Points STRING, Communication_with_Doctors_Dimension_Score STRING,
Responsiveness_of_Hospital_Staff_Achievement_Points STRING, Responsiveness_of_Hospital_Staff_Improvement_Points STRING,
Responsiveness_of_Hospital_Staff_Dimension_Score STRING, Pain_Management_Achievement_Points STRING, 
Pain_Management_Improvement_Points STRING, Pain_Management_Dimension_Score STRING, 
Communication_about_Medicines_Achievement_Points STRING, Communication_about_Medicines_Improvement_Points STRING, 
Communication_about_Medicines_Dimension_Score STRING, Cleanliness_and_Quietness_of_Hospital_Environment_Achievement_Points STRING,
Cleanliness_and_Quietness_of_Hospital_Environment_Improvement_Points STRING, 
Cleanliness_and_Quietness_of_Hospital_Environment_Dimension_Score STRING, Discharge_Information_Achievement_Points STRING,
Discharge_Information_Improvement_Points STRING, Discharge_Information_Dimension_Score STRING, 
Overall_Rating_of_Hospital_Achievement_Points STRING, Overall_Rating_of_Hospital_Improvement_Points STRING, 
Overall_Rating_of_Hospital_Dimension_Score STRING, HCAHPS_Base_Score INT, HCAHPS_Consistency_Score INT
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
 "separatorChar" = ",",
 "quoteChar" = '"',
  "escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION /user/w205/;


DROP TABLE responses;
CREATE EXTERNAL TABLE responses (Provider_ID STRING, Hospital_name STRING, 
Address STRING, City STRING, State STRING, ZIP_Code STRING, County_name STRING, 
Phone_number STRING, Condition STRING, Measure_ID STRING, Measure_name STRING, 
Score INT, Sample INT, Footnote STRING, Measure_Start_Date DATE, Measure_End_Date DATE)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
 "separatorChar" = ",",
 "quoteChar" = '"',
  "escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION /user/w205/;