library(dplyr)
library(tidyr)


# Create new folder if does not exist
if(!file.exists("./data")){dir.create("./data")}

# Download data if does not exist
if(!file.exists("./data/getdata-projectfiles-UCI HAR Dataset.zip")) {
      print("Downloading file")
      fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(fileUrl, destfile = "./data/getdata-projectfiles-UCI HAR Dataset.zip")
}

# Unzip downloaded file if not unzipped
if(!file.exists("./UCI HAR Dataset")) {
      unzip("./data/getdata-projectfiles-UCI HAR Dataset.zip")   
}


# Load source tables
print("Loading Base Tables")
features <- tbl_df(
      read.table(
            "./UCI HAR Dataset/features.txt"
            , col.names = c("featureid", "feature")
            )
      )

activitylabels <- tbl_df(
      read.table(
            "./UCI HAR Dataset/activity_labels.txt"
            , col.names = c("activityid", "activity")
      )
)

## Load base Test data ##
test_subject <- tbl_df(
      read.table(
            "./UCI HAR Dataset/test/subject_test.txt"
            , col.names = c("subjectid")
      )
)

test_activity <- tbl_df(
      read.table(
            "./UCI HAR Dataset/test/y_test.txt"
            , col.names = c("activityid")
      )
)

test_set <- tbl_df(
      read.table(
            "./UCI HAR Dataset/test/X_test.txt"
      )
)


## Load base Training data ##
train_subject <- tbl_df(
      read.table(
            "./UCI HAR Dataset/train/subject_train.txt"
            , col.names = c("subjectid")
      )
)

train_activity <- tbl_df(
      read.table(
            "./UCI HAR Dataset/train/y_train.txt"
            , col.names = c("activityid")
      )
)

train_set <- tbl_df(
      read.table(
            "./UCI HAR Dataset/train/X_train.txt" 
      )
)


## Merge
# Merge and tidy "Test" data
print("Merging data")
test_data <- tbl_df(cbind(test_subject, test_activity, test_set)) #Column Bind
tidy_test_data <- gather(test_data, featureid, values, V1:V561) #Create long dataset
tidy_test_data$featureid <- as.integer(gsub("V", "", tidy_test_data$featureid)) #Remove "V"

# Merge and tidy "Training" data
train_data <- tbl_df(cbind(train_subject, train_activity, train_set)) #Column Bind
tidy_train_data <- gather(train_data, featureid, values, V1:V561) #Create long dataset
tidy_train_data$featureid <- as.integer(gsub("V", "", tidy_train_data$featureid)) #Remove "V"

# Merge tidy datasets (Training and Test) [STEP1]
tidy_merge_dataset <- rbind(tidy_test_data, tidy_train_data) 



# Cleanup unneeded objects
print("Cleaning up extra objects")
remove(test_subject)
remove(test_activity)
remove(test_set)
remove(test_data)
remove(train_subject)
remove(train_activity)
remove(train_set)
remove(train_data)
remove(tidy_test_data)
remove(tidy_train_data)



# Filter and join [STEP2&3]
print("Filtering and joining data")
tidy_filter_ds <- tidy_merge_dataset %>%
      # Join activitylabels and features
      inner_join(features) %>%
      inner_join(activitylabels) %>%

      # Filter dataset for Mean and STD ("mean()", "std()")
      filter(grepl("-mean\\(\\)-", feature) | grepl("-std\\(\\)-", feature))



# Final cleanup [STEP4]
print("Renaming variables and sorting")
tidy_final <- tidy_filter_ds %>%
      # Reorder and drop columns
      select(subjectid, feature, activity, values) %>%
      arrange(subjectid, feature, activity)

names(tidy_final) <- c("subjectid", "measurement", "activity", "value")
tidy_final <- separate(
      tidy_final, measurement
      , into = c("measure_name", "measure_type", "measure_axis")
      , sep = "-"
      , remove = FALSE)

# Final output [STEP5]
print("Generating txt file")
tidy_final_output <- tidy_final %>%
      group_by(measurement, activity, subjectid) %>%
      summarise(average = mean(value))

write.table(tidy_final_output, file = "tidydata.txt", row.name = FALSE)