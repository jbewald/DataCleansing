run_analysis.R 
============================

run_analysis.R creates a "tidy" data set from raw accelerometer and gyroscope 3-axial signals. 
The raw data can be found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Execution Instructions: 
============================
1. The datafile from the raw data link above must be downloaded and unzipped. Note that instructions exist in the script for downloading and unzipping the file; however, these have beem commented out and it is assumed that the file has already been obtained and unzipped. 

2. The working directory must be set to the location where the base files (features.txt and activity_labels.txt) exist.  The assumption is that when the files were unzipped test and train directories were also created. 

3. Source the run_analysis.R scipt. A sample script call from R Console is shown below: 

		> setwd("c:/data/UCI HAR Dataset")
		> source("c:/users/brad/documents/R/DataCleansing/run_analysis.R")
		Loading required package: gsubfn
		Loading required package: proto
		Loading required package: RSQLite
		Loading required package: DBI
		Loading required package: tcltk
		Dataset tidy created with 180 rows and 68 columns
		Warning messages:
		1: package ‘sqldf’ was built under R version 3.2.1 
		2: package ‘gsubfn’ was built under R version 3.2.1 
		3: package ‘RSQLite’ was built under R version 3.2.1 
		4: package ‘DBI’ was built under R version 3.2.1 

4. This creates a data frame called tidy which can be used for further analysis. 

run_analysis.R Data Cleansing 
===============================
The following cleanup is preformed by run_analysis.R: 

1. Create base data frames from unzipped files 
2. Add the data frame column names for features (step #4 from instructions) 
3. Concatenate columns for training dataset 
4. Combine the two data sets (step #1 from assignment) 
5. Get the mean and standard deviaton columns only 
6. Replace the numeric activiy levels with descriptive ones 
7. Get the average metrics (features) grouped by subject and activity 

The final result is stored in a data frame called "tidy" 

Notes on the "feature" metrics captured from the raw data 
=============================================================
See features_info.txt for more information on source metrics 





