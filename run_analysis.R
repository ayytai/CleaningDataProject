## Getting and Cleaning Data Course Project
## By Anju Tai

library(dplyr)

## Set data directories
dataDir <- paste(getwd(), "UCI HAR Dataset", sep = "/")
testDir <- paste(dataDir, "test", sep = "/")
trainDir <- paste(dataDir, "train", sep = "/")

## Set file names
subjectTestFile <- paste(testDir, "subject_test.txt", sep = "/")
xTestFile <- paste(testDir, "X_test.txt", sep = "/")
yTestFile <- paste(testDir, "y_test.txt", sep = "/")

subjectTrainFile <- paste(trainDir, "subject_train.txt", sep = "/")
xTrainFile <- paste(trainDir, "X_train.txt", sep = "/")
yTrainFile <- paste(trainDir, "y_train.txt", sep = "/")

activityLabelsFile <- paste(dataDir, "activity_labels.txt", sep = "/")
featuresFile <- paste(dataDir, "features.txt", sep = "/")

tidyDatasetFile <- paste(dataDir, "tidy_data_set.txt", sep = "/")

run <- function() {
    ## First check to see if the Samsung data exists in the working directory
    if(!file.exists(dataDir)) {
        stop("The Samsung data does not exist. Please download and unzip the data into your working directory. E.g. C:/Users/john/Documents/UCI HAR Dataset")
    }
    
    ## Read activities and features
    activities  <- read.table(activityLabelsFile)
    names(activities) = c("id", "label")
    
    features <- read.table(featuresFile)
    names(features) = c("id", "label")
    
    ## Read and combine test data sets
    testSubjects <- read.table(subjectTestFile)
    testX <- read.table(xTestFile, stringsAsFactors = FALSE)
    names(testX) <- features[, 2]
    testY <- read.table(yTestFile)
    testDataSet <- cbind(testSubjects, testY, testX)
    names(testDataSet)[1] <- "subject"
    names(testDataSet)[2] <- "activity"
    
    ## Read and combine training data sets
    trainSubjects <- read.table(subjectTrainFile)
    trainX <- read.table(xTrainFile, stringsAsFactors = FALSE)
    names(trainX) <- features[, 2]
    trainY <- read.table(yTrainFile)
    trainDataSet <- cbind(trainSubjects, trainY, trainX)
    names(trainDataSet)[1] <- "subject"
    names(trainDataSet)[2] <- "activity"
    
    ## 1. Merge the training and the test sets to create one data set.
    allData <- rbind(testDataSet, trainDataSet)
    
    ## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
    toBeSelected <- grep("mean\\(\\)|std\\(\\)", names(allData))
    columnIndices  <- c(1, 2, toBeSelected)
    extractedData <- allData[, columnIndices]
    
    ## 3. Uses descriptive activity names to name the activities in the data set
    extractedData$activity <- activities[extractedData$activity, 2]
    
    ## 4. Appropriately labels the data set with descriptive variable names.
    ## *This is done already
    
    ## 5. From the data set in step 4, creates a second, independent tidy data set with the average 
    ## of each variable for each activity and each subject.
    
    extractedDataGrouped <- group_by(extractedData, activity, subject)
    summarizedData <- summarise_each(extractedDataGrouped, funs(mean))
    
    ## output tidy data set
    write.table(summarizedData, tidyDatasetFile, row.names = FALSE)
    
    print("tidy_data_set.txt produced successfully!")
}

