run_analysis <- function() 
{ 

	## This function reads downloaded data files located at:
	## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
	##
	## The function will do the following:
	## 1. Read the files from the downloaded file in the train and test folders
	## 2. Merge the these files into one filetraining and the test sets to create one data set.
	## 3. Extract only the measurements on the mean and standard deviation for each measurement. 
	## 4. Use descriptive activity names to name the activities in the data set
	## 5. Appropriately labels the data set with descriptive variable names. 
	## 6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

 
	# Read and Merge the files from the downloaded file in the train and test folders
	
	tmpTrain <- read.table("UCI HAR Dataset/train/X_train.txt") 
 	tmpTest <- read.table("UCI HAR Dataset/test/X_test.txt")

 	XCombine <- rbind(tmpTrain, tmpTest) 
 
 
 	tmpTrain <- read.table("UCI HAR Dataset/train/subject_train.txt") 
 	tmpTest <- read.table("UCI HAR Dataset/test/subject_test.txt") 
 	
	SubjCombine <- rbind(tmpTrain, tmpTest) 
 
 
 	tmpTrain <- read.table("UCI HAR Dataset/train/y_train.txt") 
 	tmpTest <- read.table("UCI HAR Dataset/test/y_test.txt") 
 	
	YCombine <- rbind(tmpTrain, tmpTest) 
 
 
 	# Extract only the measurements on the mean and standard deviation for each measurement.
 
 	featuresTxt <- read.table("UCI HAR Dataset/features.txt") 
 	Feature_Indices <- grep("-mean\\(\\)|-std\\(\\)", featuresTxt[, 2]) 
 	XCombine <- XCombine[, Feature_Indices] 
 	names(XCombine) <- featuresTxt[Feature_Indices, 2] 
 	names(XCombine) <- gsub("\\(|\\)", "", names(XCombine)) 
 	names(XCombine) <- tolower(names(XCombine)) 
 
 
 	# Use descriptive activity names to name the activities in the data set 
 
 	ActivityNames <- read.table("UCI HAR Dataset/activity_labels.txt") 
 	ActivityNames[, 2] = gsub("_", "", tolower(as.character(ActivityNames[, 2]))) 
 	YCombine[,1] = ActivityNames[YCombine[,1], 2] 
 	names(YCombine) <- "activity" 
 
 
 	# Appropriately labels the data set with descriptive variable names.

 	names(SubjCombine) <- "subject" 
 	CleanData <- cbind(SubjCombine, YCombine, XCombine) 
 	write.table(CleanData, "Clean_Data.txt") 
 
 
 	# From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
	# for each activity and each subject.
 
 
 	DistinctiveSubjects = unique(SubjCombine)[,1] 
 	numOfSubjects = length(unique(SubjCombine)[,1]) 
 	numOfActivities = length(ActivityNames[,1]) 
 	numOfCols = dim(CleanData)[2] 
 	result = CleanData[1:(numOfSubjects*numOfActivities), ] 
 
 
 	row = 1 
 	for (sub in 1:numOfSubjects) 
	{ 
     		for (act in 1:numOfActivities) 
		{ 
      		result[row, 1] = DistinctiveSubjects[sub] 
         		result[row, 2] = ActivityNames[act, 2] 
         		tmp <- CleanData[CleanData$subject==sub & CleanData$activity==ActivityNames[act, 2], ] 
         		result[row, 3:numOfCols] <- colMeans(tmp[, 3:numOfCols]) 
         		row = row+1 
 		} 
 	} 
 	write.table(result, "Result/TidyDataSet.txt") 
}
