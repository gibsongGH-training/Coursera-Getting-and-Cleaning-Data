# run_analysis.R
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Uses descriptive activity names to name the activities in the data set.
# Appropriately labels the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy data set with the average 
# of each variable for each activity and each subject.

library(tidyr)
library(dplyr)
setwd("C:/gitpost")
path <- "C:/gitpost/dataset.zip"

# download file and unzip
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, path)
unzip(zipfile="./dataset.zip",exdir="./data")

# list.files("./data", recursive = TRUE)  # check unzipped contents

# get label files per Readme.txt
setwd("C:/gitpost/data/UCI HAR Dataset")
activities <- read.table("activity_labels.txt", col.names = c("activityId", "activity"))
features <- read.table("features.txt", col.names = c("featureId", "feature"))

# import training data and combine with provided label file
subjectTrain <- read.table("./train/subject_train.txt", col.names = "subjectId")
xTrain <- read.table("./train/X_train.txt", col.names = features[,2]) 
yTrain <- read.table("./train/y_train.txt", col.names = "activityId")
# each have 7,352 observations
dataTraining <- cbind(yTrain, subjectTrain, xTrain)

# import testing data and combine with provided label file
subjectTest <- read.table("./test/subject_test.txt", col.names = "subjectId")
xTest <- read.table("./test/X_test.txt", col.names = features[,2]) 
yTest <- read.table("./test/y_test.txt", col.names = "activityId")
# each have 2,947 observations
dataTest <- cbind(yTest, subjectTest, xTest)

# combine train and test data into one table
dataAll <- rbind(dataTraining, dataTest)
# 10,299 observations, 563 variables

# extract columns related to mean and standard deviation
mean_std <- grepl("activity|subject|mean\\.|std\\.",colnames(dataAll))
dataAllExtract <- dataAll[mean_std == TRUE]
# 68 variables

# clarify column name labels
names(dataAllExtract) <-gsub("std", "stddev", names(dataAllExtract))
names(dataAllExtract) <-gsub("^t", "time", names(dataAllExtract))
names(dataAllExtract) <-gsub("^f", "frequency", names(dataAllExtract))
names(dataAllExtract) <-gsub("Acc", "Accelerometer", names(dataAllExtract))
names(dataAllExtract) <-gsub("Gyro", "Gyroscope", names(dataAllExtract))
names(dataAllExtract) <-gsub("Mag", "Magnitude", names(dataAllExtract))
names(dataAllExtract) <-gsub("BodyBody", "Body", names(dataAllExtract))

# calculate mean of each metric
dataTidy <- dataAllExtract %>% group_by(activityId, subjectId) %>% summarize_all(mean)

# write summarized table
write.table(dataTidy, file = "./tidydata.txt", row.names = FALSE, col.names = TRUE)
