# R script run_analysis.R does the following. 
#
# 1.  Merges the training and the test sets to create one data set.
# 2.  Extracts only the measurements on the mean and standard deviation. 
# 3.  Uses descriptive activity names to name the activities in the data 
#     set
# 4.  Appropriately labels the data set with descriptive variable names. 
# 5.  From the data set in step 4, creates a second, independent tidy 
#     data set with the average of each variable for each activity and
#     each subject.

# Validates and installs "data.table" and "dplyr" packages required for
# this script to execute.
if (!require("data.table")) 
{
    install.packages("data.table")
}

if (!require("dplyr")) 
{
    install.packages("dplyr")
}

require("data.table")
require("dplyr")

# Features - In other words column names
featureNames <- read.table("UCI HAR Dataset/features.txt")
# Activity Labels - In other words descriptive names for activities
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)

# Reading Training data
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activityTrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
featuresTrain <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)

# Reading Test data
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activityTest <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
featuresTest <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)

# Binding Training and Test data
subject <- rbind(subjectTrain, subjectTest)
activity <- rbind(activityTrain, activityTest)
features <- rbind(featuresTrain, featuresTest)

# Adding column names for features.
colnames(features) <- t(featureNames[2])

# Adding column names for Acitvity and Subject
colnames(activity) <- "Activity"
colnames(subject) <- "Subject"

# Combining features, activity and subject data - A complete data set.
completeData <- cbind(features,activity,subject)

# Identifying only mean and standard deviation columns.
columnsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(completeData), ignore.case=TRUE)

requiredColumns <- c(columnsWithMeanSTD, 562, 563)

# Extract Mean and Standard deviation columns.
extractedData <- completeData[,requiredColumns]

# Descriptive activity names to name the activities in the data set
extractedData$Activity <- as.character(extractedData$Activity)
for (i in 1:6){
  extractedData$Activity[extractedData$Activity == i] <- as.character(activityLabels[i,2])
}

extractedData$Activity <- as.factor(extractedData$Activity)

# Appropriately labels the data set with descriptive variable names
names(extractedData)
names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
names(extractedData)<-gsub("^t", "Time", names(extractedData))
names(extractedData)<-gsub("^f", "Frequency", names(extractedData))
names(extractedData)<-gsub("tBody", "TimeBody", names(extractedData))
names(extractedData)<-gsub("-mean()", "Mean", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-std()", "STD", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-freq()", "Frequency", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("angle", "Angle", names(extractedData))
names(extractedData)<-gsub("gravity", "Gravity", names(extractedData))

names(extractedData)

extractedData$Subject <- as.factor(extractedData$Subject)
extractedData <- data.table(extractedData)

# Data set with the average of each variable for each activity and each subject
tidyData <- aggregate(. ~Subject + Activity, extractedData, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
write.table(tidyData, file = "Tidy.txt", row.names = FALSE)