## Readme for submission of Assignment for Getting and Cleaning Data

The file "run_analysis.R" contains all the necessary code to process the HAR_UCI Dataset and produce a tidy data set at the end.

To use the code, run through the following steps:
1. Download the data from the following link and save on your computer:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. Then copy in the directory where the data are saved into the "setwd" command at the top of the script.

3. In the R Studio console, set the working directory to the same as above.

4. Now type "source("run_analysis.R")" into the console. It may take a few seconds for the code to run, but once finished it should save the tidy dataset "ActivityMeans.txt" into your working directory.


To import the tidy dataset "ActivityMeans.txt" into R, use the following command:
data <- read.table("ActivityMeans.txt", sep = " ", col.names = TRUE )


Explanation of the code:
Step 1 imports the test and training datasets and adds the features labels to each. It then merges the test and training sets together to form HARData

Step 2 takes the HARData and identifies which variables contain observations on the mean or standard deviation. It Then takes a subset of HARData based on this selection.

Step 3 of the assignment was done in step 1, where the code replaced the activity numbers with their descriptive names.

Step 4 assigns more descriptive variable names to the dataset. It does this by replacing abbreviations or codes with clearer names. For example, I replaced abbreviations such as "acc" and "gyro" with their full names, removed unnecessary parentheses to try and shorten the variable names and replaced the "t" and "f" prefixes with their actual meanings. 

Step 5 creates an independent tidy dataset by aggregating the dataset from step 4 by calculating the mean by activity name.

This is a tidy dataset because:
	-Each column contains variables
	-Each row contains observations on those variables, ie the mean measurements for each activity
	-The entire table contains only observations for each activity

Finally it writes the dataset to the working directory. 