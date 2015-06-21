# Human Activity Recognition (HAR)
## Johns Hopkins University - Getting and Cleaning data Course project - CodeBook

The Code book contains additional information to the original code-book of the source HAR data set:
* .\UCI HAR Dataset\README.txt
* .\UCI HAR Dataset\features_info.txt

### Study design
More information at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

* Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
* Smartlab - Non Linear Complex Systems Laboratory
* DITEN - Università degli Studi di Genova.
* Via Opera Pia 11A, I-16145, Genoa, Italy.
* activityrecognition@smartlab.ws
* www.smartlab.ws

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.

### Tidy data set: means_by_activity_and_subject.txt
* The tidy data set is produced by run_analysis.R
* More information about the usage of the R script is available in README.md of the repository

### Data structure of the tidy data set

* rowID: field has been introduced to brovide join condition values. The field values are based on as.numeric(row-names(*data-frame-name*)). Not available in the means_by_activity_and_subject.txt output table but all the other tables (_activities, subjects, data, mean_std_data, body_acc_x, body_acc_y, body_acc_z, body_gyro_x, body_gyro_y, body_gyro_z, total_acc_x, total_acc_y, total_acc_z_)

* activity: training and test activityIDs are loaded from y_test.txt and y_train.txt. The corresponding activity labels are resolved from .\UCI HAR Dataset\activity_labels.txt
* subjectID: training and test subjectIDs are loaded from subject_test.txt and subject_train.txt 
* m_tBodyAcc_mean_X: mean of "tBodyAcc-mean()-X"
* m_tBodyAcc_mean_Y: mean of "tBodyAcc-mean()-Y"
* m_tBodyAcc_mean_Z: mean of "tBodyAcc-mean()-Z"
* m_tBodyAcc_std_X:  mean of "tBodyAcc-std()-X"
* m_tBodyAcc_std_Y:  mean of "tBodyAcc-std()-Y"
* m_tBodyAcc_std_Z:  mean of "tBodyAcc-std()-Z"
* m_tGravityAcc_mean_X:  mean of "tGravityAcc-mean()-X"
* m_tGravityAcc_mean_Y:  mean of "tGravityAcc-mean()-Y"
* m_tGravityAcc_mean_Z:  mean of "tGravityAcc-mean()-Z"
* m_tGravityAcc_std_X:  mean of "tGravityAcc-std()-X"
* m_tGravityAcc_std_Y:  mean of "tGravityAcc-std()-Y"
* m_tGravityAcc_std_Z:  mean of "tGravityAcc-std()-Z"
* m_tBodyAccJerk_mean_X:  mean of _time is ticking :)_
* m_tBodyAccJerk_mean_Y:  mean of _time is ticking :)_
* m_tBodyAccJerk_mean_Z:  mean of _time is ticking :)_
* m_tBodyAccJerk_std_X:  mean of _time is ticking :)_
* m_tBodyAccJerk_std_Y:  mean of _time is ticking :)_
* m_tBodyAccJerk_std_Z:  mean of _time is ticking :)_
* m_tBodyGyro_mean_X:  mean of _time is ticking :)_
* m_tBodyGyro_mean_Y:  mean of _time is ticking :)_
* m_tBodyGyro_mean_Z:  mean of _time is ticking :)_
* m_tBodyGyro_std_X:  mean of _time is ticking :)_
* m_tBodyGyro_std_Y:  mean of _time is ticking :)_
* m_tBodyGyro_std_Z:  mean of _time is ticking :)_
* m_tBodyGyroJerk_mean_X:  mean of _time is ticking :)_
* m_tBodyGyroJerk_mean_Y:  mean of _time is ticking :)_
* m_tBodyGyroJerk_mean_Z:  mean of _time is ticking :)_
* m_tBodyGyroJerk_std_X:  mean of _time is ticking :)_
* m_tBodyGyroJerk_std_Y:  mean of _time is ticking :)_
* m_tBodyGyroJerk_std_Z:  mean of _time is ticking :)_
* m_tBodyAccMag_mean:  mean of _time is ticking :)_
* m_tBodyAccMag_std:  mean of _time is ticking :)_
* m_tGravityAccMag_mean:  mean of _time is ticking :)_
* m_tGravityAccMag_std:  mean of _time is ticking :)_
* m_tBodyAccJerkMag_mean:  mean of _time is ticking :)_
* m_tBodyAccJerkMag_std:  mean of _time is ticking :)_
* m_tBodyGyroMag_mean:  mean of _time is ticking :)_
* m_tBodyGyroMag_std:  mean of _time is ticking :)_
* m_tBodyGyroJerkMag_mean:  mean of _time is ticking :)_
* m_tBodyGyroJerkMag_std:  mean of _time is ticking :)_
* m_fBodyAcc_mean_X:  mean of _time is ticking :)_
* m_fBodyAcc_mean_Y:  mean of _time is ticking :)_
* m_fBodyAcc_mean_Z:  mean of _time is ticking :)_
* m_fBodyAcc_std_X:  mean of _time is ticking :)_
* m_fBodyAcc_std_Y:  mean of _time is ticking :)_
* m_fBodyAcc_std_Z:  mean of _time is ticking :)_
* m_fBodyAccJerk_mean_X:  mean of _time is ticking :)_
* m_fBodyAccJerk_mean_Y:  mean of _time is ticking :)_
* m_fBodyAccJerk_mean_Z:  mean of _time is ticking :)_
* m_fBodyAccJerk_std_X:  mean of _time is ticking :)_
* m_fBodyAccJerk_std_Y:  mean of _time is ticking :)_
* m_fBodyAccJerk_std_Z:  mean of _time is ticking :)_
* m_fBodyGyro_mean_X:  mean of _time is ticking :)_
* m_fBodyGyro_mean_Y:  mean of _time is ticking :)_
* m_fBodyGyro_mean_Z:  mean of _time is ticking :)_
* m_fBodyGyro_std_X:  mean of _time is ticking :)_
* m_fBodyGyro_std_Y:  mean of _time is ticking :)_
* m_fBodyGyro_std_Z:  mean of _time is ticking :)_
* m_fBodyAccMag_mean:  mean of _time is ticking :)_
* m_fBodyAccMag_std:  mean of _time is ticking :)_
* m_fBodyBodyAccJerkMag_mean:  mean of _time is ticking :)_
* m_fBodyBodyAccJerkMag_std:  mean of _time is ticking :)_
* m_fBodyBodyGyroMag_mean:  mean of _time is ticking :)_
* m_fBodyBodyGyroMag_std:  mean of _time is ticking :)_
* m_fBodyBodyGyroJerkMag_mean:  mean of _time is ticking :)_
* m_fBodyBodyGyroJerkMag_std:  mean of _time is ticking :)_

### Data flow and transformations
* Data gathering and transformation is performed by runu_analysis.R script. (follow README.md for usage instractions)
* Source files from HTTPS site to the .\Week03_CourseProject subdirectory of the working directory
* Archive is extracted to .\Week03_CourseProject\UCI HAR Dataset\ subfolder
* The source files are loaded by load_data <- function(filename), where 'filename' is without file extension, e.g. "body_acc_x_train" instead of "body_acc_x_train.txt"
* activity_labels
* _time is ticking :)_
* for more information please follow the inline comments of run_analysis.R script