# Coursera JHU Data science Course: Getting and Cleaning Data
# Assignment: Course Project
# Author & Date: J. DaRon Huffaker 03/21/15
# R Script Description: This script performs project requirements 1-5 in the order of 
# requirements 1, 4, 3, 2, and 5. To me, it made sense and was easier to perform requirements 1, 4, 
# and 3 first and then 2 and 5. The five requirements are listed in the script body where applicable.
# REFERENCES: Course lecture videos and slides for Weeks 1-3 and numerous web searches of R functions
# Main data frames generated: 1) fdata2 is all the data and labels from the extracted files, and 
# 2) Project_df which is the final mean table

# REQUIREMENT 1: Merges the training and the test sets to create one data set.

# Identify the directory of the different files in the project
labelpath <- "C:/Users/jdhuffaker/Documents/Coursera JHU Data Science Courses/03 Getting and Cleaning Data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/"
trainpath <- "C:/Users/jdhuffaker/Documents/Coursera JHU Data Science Courses/03 Getting and Cleaning Data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/"
testpath <- "C:/Users/jdhuffaker/Documents/Coursera JHU Data Science Courses/03 Getting and Cleaning Data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/"

# Read in the train data files
trainx <- read.table(paste(trainpath,"X_train.txt", sep=""))
trainy <- read.table(paste(trainpath,"y_train.txt", sep=""))
trains <- read.table(paste(trainpath,"subject_train.txt", sep=""))   

# Read in the test data files
testx <- read.table(paste(testpath,"X_test.txt", sep=""))
testy <- read.table(paste(testpath,"y_test.txt", sep=""))
tests <- read.table(paste(testpath,"subject_test.txt", sep=""))

# Read in the label files
act_label <- read.table(paste(labelpath,"activity_labels.txt", sep=""))
features <- read.table(paste(labelpath,"features.txt", sep=""))

# Determine the subject numbers used in the test and train data sets:
table(tests)
table(trains)

# Combine the columns of the subject number, activity number, and corresponding data for both train
# and test data sets
train <- cbind(trains, trainy, trainx)
test <- cbind(tests, testy, testx)

# Create a new column in both the train and test data sets to identify its group
# This is an extra column that will be used for modeling (i.e., to identify the training and test sets).
train$Group <- "Train Set"
test$Group <- "Test Set"

# View the first 6 rows of cols 1-5 and 560-564 of the train and test data sets
head(train[1:5])
head(test[1:5])
head(train[560:564])
head(test[560:564])

# Combine the rows of the train data set with the rows of the test data set into one data frame
fdata <- rbind(train,test)
fdata <- fdata[,c(1,2,564,3:563)] #rearrange the order of the columns


# REQUIREMENT 4: Appropriately labels the data set with descriptive variable names. 
# Set the names for the subject and activity number columns
colnames(fdata)[1] <- "Subject_Number"
colnames(fdata)[2] <- "Activity_Number"

# Change the feature column from factor to character for the next looping step
features$V2 <- as.character(features$V2)
#head(features)

# Loop through feature list names and assign them to the final data column names
# Note: This can probably be done with one of the apply functions
for(i in 4:564){
    colnames(fdata)[i] <- features[i-3,2]
}

# View the first 6 rows of cols 1-5 and 560-564 of the combined train and test data sets
head(fdata[1:5])
head(fdata[560:564])
tail(fdata[1:5])
tail(fdata[560:564])


# REQUIREMENT 3: Uses descriptive activity names to name the activities in the data set
# Set the names of the act_label
colnames(act_label) <- c("Activity_Number","Activity")

# Merge the activity label data frame with the combined train and test data frame
fdata2 = merge(act_label, fdata, by = "Activity_Number")
fdata2 <- fdata2[,c(3,1,2,4:565)] #rearrange the order of the columns
fdata2$Activity <- as.character(fdata2$Activity) #change Activity class from factor to character 

# Sort the final data set by train/test Group in descending order, Subject Number in ascending order
# and Activity Number in ascending order
# Must have plyr package installed
#install.packages("dplyr")
#library(dplyr)
fdata2 <- arrange(fdata2, desc(Group),Subject_Number,Activity_Number)
class(fdata2)

# Another syntax for ordering:
#fdata2 <- fdata2[order(desc(fdata2[,"Group"]), fdata2[,"Subject_Number"], fdata2[,"Activity_Number"]), ]

# Another syntax for ordering:
#fdata2 <- fdata2[order(desc(fdata2$Group), fdata2$Subject_Number, fdata2$Activity_Number), ]


#str(fdata2[,1:10])
#colnames(fdata2[,1:10])

# View the first 6 rows of cols 1-5 and 560-564 of the final combined train and test data sets
head(fdata2[1:5])
head(fdata2[560:564])
tail(fdata2[1:5])
tail(fdata2[560:564])

#colnames(fdata2)

# Generate cross tab tables of variable levels:
#table(fdata2$Subject_Number, fdata2$Activity_Number, fdata2$Activity, fdata2$Group)
#table(fdata$Group, fdata2$Subject_Number)
#table(fdata2$Activity_Number)
#table(fdata2$Activity)


# REQUIREMENT 2: Extracts only the measurements on the mean and standard deviation for each measurement.
# This is after adding the descriptive column (or variable) names and the descriptive activity names.
# Found two ways to subset just the mean() and std() columns:
fdata2_sub <- cbind(fdata2[,1:4],(fdata2[,grep("mean[[:punct:]]|std[[:punct:]]", colnames(fdata2))]))
head(fdata2_sub) #print the first 6 rows

#fdata2_sub <- head(fdata2[,c("Subject_Number","Activity_Number","Activity","Group",colnames(fdata2)[grep("mean[[:punct:]]|std[[:punct:]]", colnames(fdata2))])])
#head(fdata2_sub) #print the first 6 rows

#dim(try)
#colnames(try)


# REQUIREMENT 5: From the data set in step 4 (it is actually step 2 for my scripting order), creates a second, independent tidy data set with the average 
# of each variable for each activity and each subject. Note that this is table that will be uploaded
# as the project output file.

# Change Subject_Number and Activity_Number to character values
#fdata2$Subject_Number <- as.character(fdata2$Subject_Number)
#fdata2$Activity_Number <- as.character(fdata2$Activity_Number)

# Generate the final project file to upload:
Project_df <- ddply(fdata2_sub, .(Subject_Number,Activity_Number,Activity,Group), colwise(mean, na.rm=TRUE))

# write the Project_df data set out to a txt file with my username.
writepath <- "C:/Users/jdhuffaker/Documents/Coursera JHU Data Science Courses/03 Getting and Cleaning Data/"
write.table(Project_df, file=paste(writepath,"project_df_jdhuffaker.txt",sep=""), row.name=FALSE)

list.files("C:/Users/jdhuffaker/Documents/Coursera JHU Data Science Courses/03 Getting and Cleaning Data")

### END OF SCRIPT ###
