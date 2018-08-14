# courserajhuw4
# 5 mission in total
# 1 Merges the training and the test sets to create one data set.
# 2 Extracts only the measurements on the mean and standard deviation for each measurement.
# 3 Uses descriptive activity names to name the activities in the data set
# 4 Appropriately labels the data set with descriptive variable names.
# 5 Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Run run_analysis.R
There are 2 packages we need.
data.table;reshape2

## Download and unzip the data into working directory by ourseleves
## What the script have done.
# read data 
read data from the working diretory
# Mission 1 Merges the training and the test sets to create one data set.
 Merge subject_train subject_test as one table 
         Y_train       Y_test       as one table 
         X_train       X_test       as one table 
         then merge them all called "Mergeall"
# Mission 2 Extracts only the measurements on the mean and standard deviation for each measurement.
read features.txt, get the features' name
use "grep" to find which columns have mean or std --- "posMeanStd"
as the last two columns, Y_merge and MergeTestTrain do not have mean or std, but we need them.
so I add them into posMeanStd manually.
subset the "Mergeall" dataset by "posMeanStd" --"meanAndStd"
# Mission 3 Uses descriptive activity names to name the activities in the data set
read the activity_labels.txt called "actnames"
match the "meanAndStd" and "actnames" by Ymer(which is the activity code) called "Datawithnames"
# Mission 4 Appropriately labels the data set with descriptive variable names.
rename the columns names
make the columns names more clear and easier to read.
# Mission 5 Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
subset first and last two columns of "Datawithnames" than we will have all variables;
Meting "Datawithnames" using the measure variables defined and as Id the columns "Subject", "Activity_ID" and "Activity_Name". 
using the formula : Subject + Activity_Name ~ variable. And the aggregate function mean.
save the new tidy data into a file called tidyData.txt.
