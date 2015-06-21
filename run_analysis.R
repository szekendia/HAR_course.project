## Coursera : Getting and Cleaning Data : Week 03 : Course Project
## Created by: szekendia

## Task objective: The purpose of this project is to demonstrate your ability to collect, work with,
## and clean a data set. The goal is to prepare tidy data that can be used for later analysis

## CREATE:
## 1) a tidy data set,
## 2) a link to a Github repository with your script for performing the analysis, and
## In THE REPO:
##    (The repo explains how all of the scripts work and how they are connected)
## 3) CodeBook.md
##    A code book that describes the variables, the data, and any transformations or
##    work that you performed to clean up the data
## 4) README.md
##    with your scripts

## Create a script: run_analysis.R
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set
##    with the average of each variable for each activity and each subject.


## Source data:
## Course project:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## Original:        http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip

## ***********************************************************************
##                         Getting compressed data
## ***********************************************************************

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

subfolder <- "./Week03_CourseProject"                            ## Subfolder within the working directory
destfile <- paste(subfolder, "UCI_HAR_Dataset.zip", sep="/")     ## Local, compressed destination filename including subfolder

if(!file.exists(subfolder)) {dir.create(subfolder)}              ## Create subfolder if not exists
download.file(fileURL, destfile, mode="wb")                      ## mode="wb" for compressed (binary) files

## Unzip non-MacOSX content to subdirectories
filelist <- unzip(destfile, list=TRUE)                           ## list compressed files

## Original data source includes MACOS data format as well
## if exists, filter non-MacOSX related filenames
if (length(grep("MACOSX", filelist$Name)) > 0) {filelist <- filelist[-grep("MACOSX", filelist$Name),]}

unzip(destfile, files=filelist$Name, exdir=subfolder)            ## extract (unzip) files


## ***********************************************************************
##                               Load data
## ***********************************************************************

## Data loader function
load_data <- function(filename) {
    ## in: filename : without file extension, e.g. "body_acc_x_train" instead of "body_acc_x_train.txt"
    
    ## Eliminate specific filename parts in order to identify similar filenames from test and training sources
    filename_mod <- gsub("test", "", gsub("train", "", filename))
    
    ## Raise error if file is not among HAR file set
    if (length(grep(paste("/",filename_mod,".txt",sep=""), gsub("test", "", gsub("train", "", filelist$Name)))) == 0)
        {
        stop("File is not among the Human Activity Recognition (HAR) source files!")
        }
    ## Collect single filename and path or similar filenames and pathes if they exist in test and training folders
    else
        {
        filenamePath <- paste(subfolder, filelist[grep(paste("/",filename_mod,".txt",sep=""), gsub("test", "", gsub("train", "", filelist$Name))),"Name"], sep="/")
        }

    data <- lapply(filenamePath, read.table, as.is=TRUE, header=FALSE)
    do.call(rbind, data)

}


## Load meta-data

## activity_labels
activity_labels <- load_data("activity_labels")
names(activity_labels) <- c("activityID","activity")

## features
features <- load_data("features")
names(features) <- c("featureID","feature")


## LOAD and MERGE training and test data set
## load_data input parameter: filename without extension containing either 'test' or 'train' text

## LOAD and MERGE test and training subjects (source file: subject_%.txt)
subjects <- load_data("subject_test")
names(subjects) <- c("subjectID")
subjects$rowID <- as.numeric(row.names(subjects))         ## Define rowID field for merging purposes

## LOAD and MERGE test and training data set (source file: X_%.txt)
data <- load_data("X_test")
## Clean and set feature names as field names of merged dataset
names(data) <- gsub("\\.", "_", make.names(features$feature, unique=TRUE))
data$rowID <- as.numeric(row.names(data))                 ## Define rowID field for merging purposes

## LOAD and MERGE test and training activities (source file: y_%.txt)
activities <- load_data("y_test")
names(activities) <- c("activityID")
## Define rowID field for merging purposes
activities$rowID <- as.numeric(row.names(activities))


## Identify MEAN and STD related measures
mean_std_cols <- c(
         match("rowID", names(data)),
         sort(c(grep("std__", names(data)), grep("mean__", names(data))))
         )
## SELECT only MEAN and STD related measures
mean_std_data <- select(data, mean_std_cols)
## Finalize field names (replace '___' and '__' text)
names(mean_std_data) <- gsub("__", "", gsub("___", "_", names(mean_std_data)))


## LOAD and MERGE test and training inertial signals
body_acc_x <- load_data("body_acc_x_test")
body_acc_x$rowID <- as.numeric(row.names(body_acc_x))                 ## Define rowID field for merging purposes
body_acc_y <- load_data("body_acc_y_test")
body_acc_y$rowID <- as.numeric(row.names(body_acc_y))                 ## Define rowID field for merging purposes
body_acc_z <- load_data("body_acc_z_test")
body_acc_z$rowID <- as.numeric(row.names(body_acc_z))                 ## Define rowID field for merging purposes

body_gyro_x <- load_data("body_gyro_x_test")
body_gyro_x$rowID <- as.numeric(row.names(body_gyro_x))               ## Define rowID field for merging purposes
body_gyro_y <- load_data("body_gyro_y_test")
body_gyro_y$rowID <- as.numeric(row.names(body_gyro_y))               ## Define rowID field for merging purposes
body_gyro_z <- load_data("body_gyro_z_test")
body_gyro_z$rowID <- as.numeric(row.names(body_gyro_z))               ## Define rowID field for merging purposes

total_acc_x <- load_data("total_acc_x_test")
total_acc_x$rowID <- as.numeric(row.names(total_acc_x))               ## Define rowID field for merging purposes
total_acc_y <- load_data("total_acc_y_test")
total_acc_y$rowID <- as.numeric(row.names(total_acc_y))               ## Define rowID field for merging purposes
total_acc_z <- load_data("total_acc_z_test")
total_acc_z$rowID <- as.numeric(row.names(total_acc_z))               ## Define rowID field for merging purposes


## ***********************************************************************
##                      Merge relevant data.frames
## ***********************************************************************

## MERGE "activities" and 'activity_labels'
activities <- merge(activities, activity_labels, by="activityID", all=TRUE)

## MERGE 'mean_std_data' & activities
mean_std_data <- merge(mean_std_data, activities, by="rowID", all=TRUE)

## MERGE 'mean_std_data' & subjects
mean_std_data <- merge(mean_std_data, subjects, by="rowID", all=TRUE)

## Rearrange fields
mean_std_data <- select(mean_std_data, c(match(c("rowID","activityID","activity","subjectID"), names(mean_std_data)),c(2:67)))

## ***********************************************************************
##              Summarise each measure by Activity and Subject
## ***********************************************************************

## 5. From the data set in step 4, creates a second, independent tidy data set
##    with the average of each variable for each activity and each subject.

data_by_sub_act <- group_by(mean_std_data, activity, subjectID)

summary_by_sub_act <- summarize(data_by_sub_act,
          m_tBodyAcc_mean_X = mean(tBodyAcc_mean_X, na.rm = TRUE),
          m_tBodyAcc_mean_Y = mean(tBodyAcc_mean_Y, na.rm = TRUE),
          m_tBodyAcc_mean_Z = mean(tBodyAcc_mean_Z, na.rm = TRUE),
          m_tBodyAcc_std_X = mean(tBodyAcc_std_X, na.rm = TRUE),
          m_tBodyAcc_std_Y = mean(tBodyAcc_std_Y, na.rm = TRUE),
          m_tBodyAcc_std_Z = mean(tBodyAcc_std_Z, na.rm = TRUE),
          m_tGravityAcc_mean_X = mean(tGravityAcc_mean_X, na.rm = TRUE),
          m_tGravityAcc_mean_Y = mean(tGravityAcc_mean_Y, na.rm = TRUE),
          m_tGravityAcc_mean_Z = mean(tGravityAcc_mean_Z, na.rm = TRUE),
          m_tGravityAcc_std_X = mean(tGravityAcc_std_X, na.rm = TRUE),
          m_tGravityAcc_std_Y = mean(tGravityAcc_std_Y, na.rm = TRUE),
          m_tGravityAcc_std_Z = mean(tGravityAcc_std_Z, na.rm = TRUE),
          m_tBodyAccJerk_mean_X = mean(tBodyAccJerk_mean_X, na.rm = TRUE),
          m_tBodyAccJerk_mean_Y = mean(tBodyAccJerk_mean_Y, na.rm = TRUE),
          m_tBodyAccJerk_mean_Z = mean(tBodyAccJerk_mean_Z, na.rm = TRUE),
          m_tBodyAccJerk_std_X = mean(tBodyAccJerk_std_X, na.rm = TRUE),
          m_tBodyAccJerk_std_Y = mean(tBodyAccJerk_std_Y, na.rm = TRUE),
          m_tBodyAccJerk_std_Z = mean(tBodyAccJerk_std_Z, na.rm = TRUE),
          m_tBodyGyro_mean_X = mean(tBodyGyro_mean_X, na.rm = TRUE),
          m_tBodyGyro_mean_Y = mean(tBodyGyro_mean_Y, na.rm = TRUE),
          m_tBodyGyro_mean_Z = mean(tBodyGyro_mean_Z, na.rm = TRUE),
          m_tBodyGyro_std_X = mean(tBodyGyro_std_X, na.rm = TRUE),
          m_tBodyGyro_std_Y = mean(tBodyGyro_std_Y, na.rm = TRUE),
          m_tBodyGyro_std_Z = mean(tBodyGyro_std_Z, na.rm = TRUE),
          m_tBodyGyroJerk_mean_X = mean(tBodyGyroJerk_mean_X, na.rm = TRUE),
          m_tBodyGyroJerk_mean_Y = mean(tBodyGyroJerk_mean_Y, na.rm = TRUE),
          m_tBodyGyroJerk_mean_Z = mean(tBodyGyroJerk_mean_Z, na.rm = TRUE),
          m_tBodyGyroJerk_std_X = mean(tBodyGyroJerk_std_X, na.rm = TRUE),
          m_tBodyGyroJerk_std_Y = mean(tBodyGyroJerk_std_Y, na.rm = TRUE),
          m_tBodyGyroJerk_std_Z = mean(tBodyGyroJerk_std_Z, na.rm = TRUE),
          m_tBodyAccMag_mean = mean(tBodyAccMag_mean, na.rm = TRUE),
          m_tBodyAccMag_std = mean(tBodyAccMag_std, na.rm = TRUE),
          m_tGravityAccMag_mean = mean(tGravityAccMag_mean, na.rm = TRUE),
          m_tGravityAccMag_std = mean(tGravityAccMag_std, na.rm = TRUE),
          m_tBodyAccJerkMag_mean = mean(tBodyAccJerkMag_mean, na.rm = TRUE),
          m_tBodyAccJerkMag_std = mean(tBodyAccJerkMag_std, na.rm = TRUE),
          m_tBodyGyroMag_mean = mean(tBodyGyroMag_mean, na.rm = TRUE),
          m_tBodyGyroMag_std = mean(tBodyGyroMag_std, na.rm = TRUE),
          m_tBodyGyroJerkMag_mean = mean(tBodyGyroJerkMag_mean, na.rm = TRUE),
          m_tBodyGyroJerkMag_std = mean(tBodyGyroJerkMag_std, na.rm = TRUE),
          m_fBodyAcc_mean_X = mean(fBodyAcc_mean_X, na.rm = TRUE),
          m_fBodyAcc_mean_Y = mean(fBodyAcc_mean_Y, na.rm = TRUE),
          m_fBodyAcc_mean_Z = mean(fBodyAcc_mean_Z, na.rm = TRUE),
          m_fBodyAcc_std_X = mean(fBodyAcc_std_X, na.rm = TRUE),
          m_fBodyAcc_std_Y = mean(fBodyAcc_std_Y, na.rm = TRUE),
          m_fBodyAcc_std_Z = mean(fBodyAcc_std_Z, na.rm = TRUE),
          m_fBodyAccJerk_mean_X = mean(fBodyAccJerk_mean_X, na.rm = TRUE),
          m_fBodyAccJerk_mean_Y = mean(fBodyAccJerk_mean_Y, na.rm = TRUE),
          m_fBodyAccJerk_mean_Z = mean(fBodyAccJerk_mean_Z, na.rm = TRUE),
          m_fBodyAccJerk_std_X = mean(fBodyAccJerk_std_X, na.rm = TRUE),
          m_fBodyAccJerk_std_Y = mean(fBodyAccJerk_std_Y, na.rm = TRUE),
          m_fBodyAccJerk_std_Z = mean(fBodyAccJerk_std_Z, na.rm = TRUE),
          m_fBodyGyro_mean_X = mean(fBodyGyro_mean_X, na.rm = TRUE),
          m_fBodyGyro_mean_Y = mean(fBodyGyro_mean_Y, na.rm = TRUE),
          m_fBodyGyro_mean_Z = mean(fBodyGyro_mean_Z, na.rm = TRUE),
          m_fBodyGyro_std_X = mean(fBodyGyro_std_X, na.rm = TRUE),
          m_fBodyGyro_std_Y = mean(fBodyGyro_std_Y, na.rm = TRUE),
          m_fBodyGyro_std_Z = mean(fBodyGyro_std_Z, na.rm = TRUE),
          m_fBodyAccMag_mean = mean(fBodyAccMag_mean, na.rm = TRUE),
          m_fBodyAccMag_std = mean(fBodyAccMag_std, na.rm = TRUE),
          m_fBodyBodyAccJerkMag_mean = mean(fBodyBodyAccJerkMag_mean, na.rm = TRUE),
          m_fBodyBodyAccJerkMag_std = mean(fBodyBodyAccJerkMag_std, na.rm = TRUE),
          m_fBodyBodyGyroMag_mean = mean(fBodyBodyGyroMag_mean, na.rm = TRUE),
          m_fBodyBodyGyroMag_std = mean(fBodyBodyGyroMag_std, na.rm = TRUE),
          m_fBodyBodyGyroJerkMag_mean = mean(fBodyBodyGyroJerkMag_mean, na.rm = TRUE),
          m_fBodyBodyGyroJerkMag_std = mean(fBodyBodyGyroJerkMag_std, na.rm = TRUE))

## EXPORT summary table
write.table(summary_by_sub_act, "means_by_activity_and_subject.txt", row.name=FALSE)
