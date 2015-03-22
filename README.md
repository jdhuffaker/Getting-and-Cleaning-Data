=======================================================================================================================================
## README for:

## Coursera JHU Data science Course: Getting and Cleaning Data
## Assignment: Course Project
## Author & Date: J. DaRon Huffaker 03/21/15
## R Script Description: This script performs project requirements 1-5 in the order of requirements 1, 4, 3, 2, and 5. To me, it made sense and was easier to perform requirements 1, 4, and 3 first followed by 2 and 5. The five requirements are listed below.
### REFERENCES: Course lecture videos and slides for Weeks 1-3 and numerous web searches of R functions
### Main data frames generated: 1) full_data_frame.txt (Combined Train and Test Data) is all the data and labels from the extracted files, and 2) project_df_jdhuffaker.txt (Final Mean Table) which is the final mean table.

### REQUIREMENT 1: Merges the training and the test sets to create one data set.
### REQUIREMENT 4: Appropriately labels the data set with descriptive variable names. 
### REQUIREMENT 3: Uses descriptive activity names to name the activities in the data set
### REQUIREMENT 2: Extracts only the measurements on the mean and standard deviation for each measurement.
### REQUIREMENT 5. From the data set in step 4 (it is actually step 2 above for my scripting order), creates a second, independent tidy data set with the average of each variable for each activity and each subject. Note that this is table that will be uploaded as the project output file.

=======================================================================================================================================
### R Script Name: run_analysis.R
### The R script can be found at this same repository

======================================================================================================================================
Information about the experimental data can be found in the README file located with the rest of the files at: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

=======================================================================================================================================

The R script does the following:
 
1. Reads in the following files:

* X_train.txt (data on 21 subjects that can be used to generate a training model at a future date)
* y_train.txt (activity numbers where the numbers correspond to 6 activities given in activity_labels.txt)
* subject_train.txt (subject numbers of the train data sets)
* X_test.txt (data on 9 subjects that can be used to test the training model at a future date)
* y_train.txt ()activity numbers where the numbers correspond to 6 activities given in activity_labels.txt)
* subject_test.txt (subject numbers of the test data sets)
* activity_labels.txt (list of the 6 activity names used to generate the experimental data)
* features.txt (list of the variable or column names in the X_train.txt and X_test.txt files)
 
2. Combines all of the train files into one data frame and combines all of the test files into one data frame
  (combines experimental data, subject numbers, and activity numbers).

3. Generates a new column named "Group" that identifies the TRAIN or TEST group in the two data frames.

4. Combines the TRAIN and TEST data frames into one data frame.

5. Adds column names (variable labels) to all of the columns in the combined data frame. The column names for the data columns
   are taken from the features.txt file.

6. Creates a new column of the activity names based on the corresponding activity number. This is done by merging the main data frame
   with the activity_labels.txt file by Activity Number.

7. Sort the main data frame by Group (in descending order), Subject Number, and Activity Number.

8. Create a subset data frame of the mean() and std() variables only.

9. Generate the final table of the means of the subset data frame by Subject Number, Activity Number, Activity Group,
   and Group (Train or Test). This is the mean of the means and mean of the stdevs. There are 30 subjects and 6 activities.
   This equates to 30 x 6 = 180 rows of mean values.

NOTES:
1. There are 561 variables in the original combined data frame (all Train and Test data).

2. There are 66 variables in the final project data frame (includes the mean() and std() columns/variables only).   

