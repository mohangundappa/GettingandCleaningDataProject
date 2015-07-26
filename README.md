# Getting and Cleaning Data Project
Data Science Course - Getting and Cleaning Data

##You should create one R script called run_analysis.R that does the following. 

	1.	Merges the training and the test sets to create one data set.
    2.	Extracts only the measurements on the mean and standard deviation
		for each measurement. 
    3.	Uses descriptive activity names to name the activities in the data set
    4.	Appropriately labels the data set with descriptive variable names. 
	5.	From the data set in step 4, creates a second, independent tidy data
		set with the average of each variable for each activity and each subject.

##Steps to run/work on this project

    1.	Create a folder "GettingandCleaningDataProject".
	2.	Put run_analysis.R file under the folder "GettingandCleaningDataProject".
	3.	Download and Keep data source folder "UCI HAR Dataset" under 
		"GettingandCleaningDataProject" folder.
	4.	Set working directory in RStudio to "GettingandCleaningDataProject" folder.
    3.	Run source("run_analysis.R"), then it will generate a new file Tidy.txt
		in your working directory.

##Dependencies
	
	1.	run_analysis.R file will automatically install the dependencies.
	2.	It depends on dplyr and data.table packages. 