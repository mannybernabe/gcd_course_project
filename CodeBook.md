Codebook
========

Data has been sourced from the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). 

UCI HAR Dataset is split into training and test data - each folder contains a set of inertial signals as well as their resulting calculated measures used in this exercise:
* `subject_test.txt` contains the subject (1-30) for each measurement
* `X_test.txt` contains the measures of each observation (i.e. each subject/activity pair)
* `y_test.txt` contains the activity label of each observation

Equally for the training data (`X_train.txt`, `y_train.txt` etc.)

Activity labels are specified in the root folder in the file `activity_labels.txt` and variables for the "x data" is specified in the `features.txt` file.

The data is transformed in the following way by the R script:
* Only measures pertaining to the mean or standard deviation is extracted.
* Variable names are transformed to an unambiguous form.
* Data is loaded in to two data frames - one with the aggregated means and std measures in full and one summary for each subject/activity pair.

The structure of each data frame follow the below:
```
'data.frame':	10299 obs. of  68 variables:
 $ subject                  : Factor w/ 30 levels "subject2","subject4",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ activity                 : Factor w/ 6 levels "walking","walking.upstairs",..: 5 5 5 5 5 5 5 5 5 5 ...
 $ timeBodyAccelerationMeanX: num  0.257 0.286 0.275 0.27 0.275 ...
 $ timeBodyAccelerationMeanY: num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
 $ timeBodyAccelerationMeanZ: num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ...
 ```

* time or frequency refer to each domain
* Body/Gravity
* Acceleration/Gyro refer to sensor used (accelerometer or gyroscope)
* Mean/Std refer to measure (mean or standard deviation)
* X/Y/Z refer to axis
   



