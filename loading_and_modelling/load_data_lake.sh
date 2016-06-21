# strip header lines from needed files
tail -n +2 ~/Documents/W205/Hospital_General_Information.csv > ~/Documents/W205/hospitals.csv
tail -n +2 ~/Documents/W205/Timely_and_Effective_Care_-_Hospital.csv > ~/Documents/W205/effective_care.csv
tail -n +2 ~/Documents/W205/Readmissions_and_Deaths_-_Hospital.csv > ~/Documents/W205/readmissions.csv
tail -n +2 ~/Documents/W205/Measure_Dates.csv > ~/Documents/W205/Measures.csv
tail -n +2 ~/Documents/W205/hvbp_hcahps_05_28_2015.csv > ~/Documents/W205/surverys_responses.csv

#Start HDFS, Hadoop Yarn and Hive:
/root/start-hadoop.sh

# Make a new folder in HDFS for this lab: 
hdfs dfs -mkdir /user/w205/hospital_compare

# Upload files into w205 instance
git clone https://github.com/jchiangMIDS/exercise_1
cd exercise_1/loading_and_modelling
unzip effective_care.zip

# Load the datasets into HDFS
hdfs dfs -put hospitals.csv /user/w205/hospital_compare
hdfs dfs -put effective_care.csv.zip /user/w205/hospital_compare
hdfs dfs -put readmissions.csv /user/w205/hospital_compare
hdfs dfs -put Measures.csv /user/w205/hospital_compare
hdfs dfs -put surveys_responses.csv /user/w205/hospital_compare

