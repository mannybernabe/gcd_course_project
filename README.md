Getting and Cleaning Data course project
========================================

run_analysis.R is designed to run in the same directory as the [UCI HAR Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) folder of test data.

Running the script
* Combines test and training data in to one consolidated data set
* Extracts only the measures pertaining to mean and standard deviation
* The output of the script is two data frames
1 The first data frame contains the aggregated data
2 The second data frame contains the mean for each measurement for each subject/activity pair
