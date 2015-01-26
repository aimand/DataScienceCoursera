The data can be obtained from the following link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Original description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The run_analysis.R has a function that does not require any parameters run_analysis. The function does the following:

1.	Read the files from the downloaded file in the train and test folders

2.	Merge the these files into one file training and the test sets to create one data set.

3.	Extract only the measurements on the mean and standard deviation for each measurement. 

4.	Use descriptive activity names to name the activities in the data set.

5.	Appropriately labels the data set with descriptive variable names. 

6.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Internally, the function will obtain the following labels from the activity_labels.txt:
	walking
	walkingupstairs
	walkingdownstairs
	sitting
	standing
	laying

Then the function will clean and merge the data into a file named Clean_Data.txt that has the follolwing column headers:
•	subject
•	activity
•	tbodyacc-mean-x 
•	tbodyacc-mean-y 
•	tbodyacc-mean-z 
•	tbodyacc-std-x 
•	tbodyacc-std-y 
•	tbodyacc-std-z 
•	tgravityacc-mean-x 
•	tgravityacc-mean-y

The final step to get the averages and store them in the result file TidyDataSet.txt that has the same column headers.
