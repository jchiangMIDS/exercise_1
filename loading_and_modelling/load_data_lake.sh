# strip header lines from needed files in local directory
tail -n +2 ~/Documents/W205/Timely_and_Effective_Care_-_Hospital.csv > ~/Documents/W205/effective_care.csv
tail -n +2 ~/Documents/W205/hvbp_hcahps_05_28_2015.csv > ~/Documents/W205/surverys_responses.csv

#Start HDFS, Hadoop Yarn and Hive:
/root/start-hadoop.sh

# Make a new folders in HDFS for this lab: 
hdfs dfs -mkdir /user/w205/hospital_compare/effective_care
hdfs dfs -mkdir /user/w205/hospital_compare/surveys_responses

# Upload files into w205 instance
git clone https://github.com/jchiangMIDS/exercise_1
cd exercise_1/loading_and_modelling
unzip effective_care.zip

# Load the datasets into HDFS
hdfs dfs -put effective_care.csv /user/w205/hospital_compare/effective_care
hdfs dfs -put surveys_responses.csv /user/w205/hospital_compare/surveys_responses


