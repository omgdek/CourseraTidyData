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
 
####Step 4: Merge raw tables into the separate test and train data
- Using column binding, (cbind) merge raw sets into two sets of data (test and train)
  * *Activies occur seperate before combining to keep records per user lined up correctly*
- Using tidyr, gather to lengthen and create tidy dataset
- remove "V" from featureid column for use in joining later to feature dimension table
 
####Step 5: Remove unneeded objects and wasted memory
- Use remove function to remove objects
