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
CREATE EXTERNAL TABLE effective_care (Provider_ID STRING, Hospital_name STRING, 
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
LOCATION ‘/path/in/hdfs’;
