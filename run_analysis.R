# Script for analysing data from a wearable device
# assumes that data is present in the current directory (under subfolders)

library(dplyr)

# read the descriptive data
features <- read.table("UCI HAR Dataset\\features.txt")
activity_labels <- read.table("UCI HAR Dataset\\activity_labels.txt")

####
# read the data sets, both training and test
####

subject_train <- read.table("UCI HAR Dataset\\train\\subject_train.txt", header = FALSE)
activity_train <- read.table("UCI HAR Dataset\\train\\y_train.txt", header = FALSE)
features_train <- read.table("UCI HAR Dataset\\train\\x_train.txt", header = FALSE)

subject_test <- read.table("UCI HAR Dataset\\test\\subject_test.txt", header = FALSE)
activity_test <- read.table("UCI HAR Dataset\\test\\y_test.txt", header = FALSE)
features_test <- read.table("UCI HAR Dataset\\test\\x_test.txt", header = FALSE)

####
# merge the data together
####

subject_complete <- rbind(subject_train, subject_test)
activity_complete <- rbind(activity_train, activity_test)
features_complete <- rbind(features_train, features_test)

####
# set the column names
####

# set the column names for the features data set, this is given by the second column in the file
# features.txt

colnames(features_complete) <- t(features[2])

# then gives column names to the activity and subject data

colnames(activity_complete) <- "Activity"
colnames(subject_complete) <- "Subject"

####
# join the data together
####

har_dataset = cbind(subject_complete, activity_complete, features_complete)

####
# extract mean and standard deviation measurements
####

cols_for_mean_and_std <- grep(".*-mean|.*-std", names(har_dataset))

# subject and activity are cols 1 and 2

har_mean_and_std_dataset <- har_dataset[,c(1,2,cols_for_mean_and_std)]

####
# change numbers denoting activity with the label (they are 1 to 6)
####

har_mean_and_std_dataset$Activity <- as.character(har_mean_and_std_dataset$Activity)
for (i in 1:6){
  har_mean_and_std_dataset$Activity[har_mean_and_std_dataset$Activity == i] <- as.character(activity_labels[i,2])
}

####
# write out the tidy data set
####


write.table(har_mean_and_std_dataset, "har_mean_and_std_dataset.txt", row.names = FALSE)

