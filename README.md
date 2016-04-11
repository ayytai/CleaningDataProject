# CleaningDataProject
###Coursera [Getting and Cleaning Data Course Project]
By Anju Tai

This project is the final assignment for the Coursera course "Getting and Cleaning
Data"" offered by John Hopkins University.

The script run_analysis.R takes the data collected from a sample of accelerometers 
from the Samsung Galaxy S smartphone and performs a series of data scrubbing and
transformations to produce a new, tidy dataset as the output.

A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Please note that the data must be downloaded and unzipped into the R working directory of the user.
E.g. C:/Users/john/Documents/UCI HAR Dataset

### How does the script work?

The script runs through the following steps to product the final output file:

1. Read in relevant input data files: 
    * subject, X, and Y files for the test data
    * subject, X, and Y files for the training data 
    * activity labels/ids (corresponds to the X data files)
    * features (attributes corresponding to the Y data files)
2. Merge the test and training data into one dataset
3. Extract only the measurements on the mean and standard deviation for each measurement (any 
   variables that match "mean()" and "std()"
4. Update the activities in the data set from ids to the activity label
5. Appropriately label the data set with descriptive variable names found in the features file 
6. From the cleaned dataset up to the last step, create a second, independent tidy data set with the average 
   of each variable for each activity and each subject.
   The data file is called tidy_data_set.txt and it will be found inside the working directory inside the 
   Samsung data folder.