################ 
 run_analysis.R
################ 

This script obtains the data for the project and then performs the 5 steps requiered in the instructions:

1- Downloads project files and extracts them.

2- Loads the data to the following datasets:
	features <- features.txt : The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. 
	activities <- activity_labels.txt : contains the list of activities ids and names 
	subject_test <- test/subject_test.txt : contains the measurement's corresponding subject_id for 9/30 participants.
	x_test <- test/X_test.txt : contains the collected test data
	y_test <- test/y_test.txt : contains the activities ids for the test data
	subject_train <- test/subject_train.txt : contains the measurement's corresponding subject_id for 21/30 participants.
	x_train <- test/X_train.txt : contains the collected train data
	y_train <- test/y_train.txt : contains the activities ids for the train data

3- Step_1: Merges the training and the test sets to create one data set named "data_1".
	subject: the result of merging subject_train and subject_test using rbind()
	x : the result of merging x_train and x_test using rbind()
	y : the result of merging y_train and y_test using rbind()
	data_1: the merged data is obtained by applying cbind() on subject, y and x

4- Step_2: Extracts only the measurements on the mean and standard deviation for each measurement.
	data_1: is created by selecting the columns subject_id, activity_id and the columns corresponding to measurements of mean and standard deviation (std)

5- Step_3: Uses descriptive activity names to name the activities in the data set
	data_1: The activities ids in column 2 are replaced by the activities names extracted from the activities dataset.

6- Step_4: Appropriately labels the data set with descriptive variable names.
	*renames the activity_id column into "activity"
	*the "mean" contained in columns names is changed for "Mean" 
	*the "std" contained in columns names is changed for "Std" 
	*the "gravity" contained in columns names is changed for "Gravity" 
	*the "f" starting in columns names is changed for "Frequency" 
	*the "t" starting in columns names is changed for "Time" 
	*the ".t" contained in columns names is changed for ".Time" 
	*the "acc" contained in columns names is changed for "Accelerometer" 
	*the "gyro" contained in columns names is changed for "Gyroscope" 
	*the "mag" contained in columns names is changed for "Magnitude" 

7- Step_5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	final_data: is the result of sumarizing data_2 calculating the mean of each column groupped by subject_id and activity.

9- Adds "Mean." to the beginning of each column name except for columns 1 and 2. 
	
8- Exports final_data to a txt file. 
