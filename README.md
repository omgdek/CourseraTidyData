CourseraTidyData
================

For Coursera Getting and Cleaning Data Course.

###Requirements
You should create one R script called run_analysis.R that does the following: 
  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names. 
  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Process Steps
####Step 1: Load required packages
For this script I have elected to use dplyr and tidyr to leverage their power in cleaning and manipulating sets of data.

####Step 2: Prepare download and extract
- Determine if required file structure exists and creates necessary folders if missing.
- Download zip file if not existing.
- Extract zip if not existing
 
####Step 3: Load base .txt files
- Load the following files:
  * features.txt
  * activity_labels.txt
  * subject_test.txt
  * y_test.txt
  * X_test.txt
  * subject_train.txt
  * y_train.txt
  * X_train.txt
 
####Step 4: Tidy and merge raw tables (Completes Requirement 1)
- Using column binding, (cbind) merge raw sets into two sets of data (test and train)
  * *Activities occur separate before combining to keep records per user lined up correctly*
- Using tidyr, gather to lengthen and create tidy datasets for each
- Remove "V" from featureid column for use in joining later to feature dimension table
- Using row binding (rbind), merge test and train data into one tidy dataset **(Req 1)**

####Step 5: Remove unneeded objects and wasted memory
- Use remove function to remove objects

####Step 6: Filter for Mean and STD and join to descriptive dimension tables (Completes Requirement 2 & 3)
- Use inner_join to join to features and activity dimension tables **(Req 3)**
  * *Replaces numeric representations of activities with descriptive versions. Examples: feature:1=tBodyAcc-mean()-X and activity:1=WALKING*
- Use filter to return only observations containing "-mean()-" and "-std()-" **(Req 2)**

####Step 7: Complete final clean-up and renaming of variables (Completes Requirement 4)
- Use select to return only final data set variables (subjectid, measurement, activity, value) **(Req 4)**
  * subjectid: Unique ID for each test subject. Variable name identifies that it is the ID value for subject.
  * measurement: Type of measurement (sensor, axis, type (mean, std)).
  * activity: Descriptive type of activity occurring (WALKING, STANDING).
  * value: The observed value. (This column is later renamed to average after summarizing in step 5)
- Use separate to split measurement into other columns for further analysis (Not used in final output. For personal analysis.)
- 
####Step 8: Summarize with mean() and write to file for submission (Completes Requirement 5)
- Use group_by to group on measurement, activity, and subjectid
- Use summarise to calculate average using mean() function. Value column renamed to Average. **(Req 5)**
- Use write.table to output as tidydata.txt with row.name = FALSE **(Req 5)**
