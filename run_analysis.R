## Getting and cleaning data - Week 4 - Assignment

# Set working directory
setwd("/Users/Andrew/Documents/Getting and cleaning data/Assignment")
# Load required packages
library(dplyr)

## Step 1 - Read in and merge the test and training datasets

# Read in test data

xtest <- read.table("./UCI HAR Dataset/test/X_test.txt",sep="")
activityLabels <- as.character(read.table("./UCI HAR Dataset/activity_labels.txt",sep = "")$V2)
attributeNames <- read.table("./UCI HAR Dataset/features.txt",sep="")$V2
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt",sep = "")
names(xtest) <- attributeNames
names(ytest) <- "Activity"
ytest$Activity <- as.factor(ytest$Activity)
levels(ytest$Activity) <- activityLabels  ## Step 3 - gives test data descriptive activity names
testSubjects <-read.table("./UCI HAR Dataset/test/subject_test.txt", sep = "",col.names = "Subject") 
  
# Merge activity numbers with dataset
test <- cbind(testSubjects,ytest,xtest)

# Read in train data
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt",sep = "")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt",sep = "")
trainSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt",sep = "",col.names = "Subject")
names(xtrain) <- attributeNames
names(ytrain) <- "Activity"
ytrain$Activity <- as.factor(ytrain$Activity)
levels(ytrain$Activity) <- activityLabels  ## Step 3 - gives train data descriptive activity names
# Merge train data together
train <- cbind(trainSubjects,ytrain,xtrain)
# Merge test and train
HARData <- rbind(test,train)

## Step 2 - Subset HARData by variables containing means and standard deviaitons

# Find column numbers with variable names containing "mean()" and "std()"
meanCond <- grep("mean[(][)]",attributeNames)+2
stdCond <- grep("std[(][)]",attributeNames)+2
colNums <- c(1,2,meanCond,stdCond)
# Extract only columns with "mean()" and "std()" from HARData
HARData <- HARData[,colNums]

## Step 4 - create descriptive variable names
names(HARData) <- sub("Acc","Acceleration",names(HARData)) # Make Acc more meaningful
names(HARData) <- sub("[(][)]","",names(HARData)) # Remove parentheses after mean and std
names(HARData) <- sub("Gyro","Gyroscope",names(HARData)) # Make gyro clearer
names(HARData) <- sub("BodyBody","Body",names(HARData)) # Remove duplicate Body
names(HARData) <- sub("^t","Time",names(HARData)) # Make it clear wht the "t" prefix stands for
names(HARData) <- sub("^f","Freq",names(HARData)) # Make it clear what the "f" prefix stands for

## Step 5 - create an independent idy dataset with the means of each variable for each subject and acivity

# First create a data frame with means by subject
SubjectMeans <- aggregate(HARData[,3:68],list(HARData$Subject),mean)
names(SubjectMeans)[1] <- "Subject" # Re-label Subject column

## Then create a separate  data frame with means by activity
ActivityMeans <- aggregate(HARData[,3:68],list(HARData$Activity),mean)
names(ActivityMeans)[1] <- "Activity" # Re-label Activity column

# Export the tidy data frame
write.table(ActivityMeans, file = "ActivityMeans.txt",row.names = FALSE)


