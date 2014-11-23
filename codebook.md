#Code Book
==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

*For further details on raw dataset please refer to documentation contained within ./UCI HAR Dataset that is downloaded and created through the run_analysis.R script.*

==================================================================
##Data Dictionary - tidydata.txt

###measurement
Describes source (accelerometer, gyroscope) and type of measure for each value.
- structure - [prefix][measure][calculation][axis]
  * Example - fBodyAcc-mean()-X
- prefix
  * t - Time domain signals captured at constant rate of 50Hz
  * f - Fast Fourier Transform (FFT) applied to signals
- measure
  * BodyAcc - Accelerometer signal
  * BodyAccJerk - Acceleration and angular velocity "Jerk" signal (Accelerometer signal)
  * BodyGyro - Gyroscope signal
  * BodyGyroJerk - Acceleration and angular velocity "Jerk" signal (Gyroscope signal)
  * GravityAcc - Accelerometer gravity acceleration signal
- calculation
  * mean() - Mean value
  * std() - Standard deviation
- axis
  * X - Movement signal along X axis
  * Y - Movement signal along Y axis
  * Z - Movement signal along Z axis

###activity
Describes activity that test subject is performing
- WALKING
- WALKING_UPSTAIRS
- WALKING_DOWNSTAIRS
- SITTING
- STANDING
- LAYING

###subjectid
Numeric representation for each unique test subject
- 1:30

###average
Summarization of all signals for each measurement, activity, and subject id.
- Calculation used is mean()
