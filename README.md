# Getting and Cleaning Data - Course Project
This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:

1. Loads the necessary packages "reshape2" and "dplyr"
2. Downloads the dataset if it does not already exist in the working directory
3. Loads the activity and feature info
4. Loads both the training and test datasets, keeping only those columns which reflect a mean or standard deviation
5. Loads the activity and subject data for each dataset, and merges those columns with the dataset
6. Merges the two datasets
7. Converts the activity and subject columns into factors
8. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
9. The end result is located in the file tidy.txt.
