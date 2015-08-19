##########################
# Author: Brad Ewald 
# Create Date: 8/10/2015
# Description: run_analysis.R creates a "tidy" data set from raw accelerometer and gyroscope 3-axial signals from a 
#
# Sample Script Call
# setwd("c:/data/UCI HAR Dataset")
# source("c:/users/brad/documents/R/DataCleansing/run_analysis.R")
#
# Created and tested with R version 3.2.0
#
##########################
#setwd("c:/data")

# Download Data File if it doesn not already exist 
#destfile <- "UCI_HAR.zip" 
#if (!file.exists(destfile)) {
#	fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
#	download.file(fileUrl, destfile = destfile, method = "libcurl")
#}
#dateDownloaded <- date()
#unzip(destfile)
#setwd("./UCI HAR Dataset")

# Create base data frames from unzipped files 
train_X <- read.table("./train/X_train.txt")				#561 metrics 
train_Y <- read.table("./train/y_train.txt")                #Activity Level 
train_subject <- read.table("./train/subject_train.txt")

test_X <- read.table("./test/X_test.txt")
test_Y <- read.table("./test/Y_test.txt")
test_subject <- read.table("./test/subject_test.txt")

# Add the data frame column names for features (step #4 from instructions) 
features_list <- read.table("./features.txt")
names(test_X) <- features_list[,2]
names(train_X) <- features_list[,2]

#Concatenate columns for training dataset 
all_cols_train <- cbind(DataSet = "Training",train_subject, train_Y,  train_X, deparse.level = 2)
all_cols_test <- cbind(DataSet = "Test",test_subject, test_Y,  test_X, deparse.level = 2)

# combine the two data sets (step #1 from assignment) 
combined_test_train <- rbind(all_cols_train, all_cols_test)

# Append the columns names for Subject and Activity Level 
names(combined_test_train)[2] <- "Subject"
names(combined_test_train)[3] <- "ActivityLevel"

combined_test_train_mean_std <- cbind( combined_test_train[,1:3],
                combined_test_train[grepl("mean\\(\\)", names(combined_test_train))],
				combined_test_train[grepl("std\\(\\)", names(combined_test_train))]
			  )

# Include the Descriptive Activity Level 
library(sqldf)   			  
activity <- read.table("activity_labels.txt")			  
query <- "select a.V2 ActivityDesc, ds.* from combined_test_train_mean_std ds join activity a on a.V1 = ds.[ActivityLevel]"
combined_test_train_mean_std_clean <- sqldf(query, stringsAsFactors = FALSE)

			
# final tidy
tidy_mean_std <- combined_test_train_mean_std_clean[,c(1,3,5:70)]

# Step 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_metrics <- names(tidy_mean_std)[3:68]
tidy <- aggregate(tidy_mean_std[tidy_metrics], by=list(tidy_mean_std$ActivityDesc, tidy_mean_std$Subject), mean)
names(tidy)[1] <- "Activity" 
names(tidy)[2] <- "SubjectNumber" 

d <- dim(tidy)
message("Dataset tidy created with ", d[1], " rows and ", d[2], " columns")
			

			
# Step 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#query <- c("select ActivityDesc, Subject , ", names(tidy_mean_std)[3:70], ""  )
#combined_test_train_averages <- sqldf(query, stringsAsFactors = FALSE)



#names(combined_test_train)[1] <- "ActivityDesc"
#combined_test_train[grepl("fBodyAcc-bandsEnergy", names(combined_test_train))]			  
#combined_test_train[grepl("mean", names(combined_test_train))]
#dim(test_X)
#lybrary(dplyr)
#all_train_X <- rbind(train_X, test_X)
#all_train_Y <- rbind(train_Y, test_Y)
#all_train_subject <- rbind(train_subject, test_subject)
#names(combined_test_train) <- features_list[,2] 





