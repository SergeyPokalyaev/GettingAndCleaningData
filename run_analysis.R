run_analysis <- function() {
  #Download file from internet
  destfileName = "downloadedData.zip"
  downloadedFile <- download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                                  destfile = destfileName);
    
  #Unzip file
  #unzip(destfileName, exdir = ".", overwrite = TRUE)
  
  #remove downloaded zip-file
  file.remove(destfileName)
  
  #Set activity names
  activityNames <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
  
  #Set feathers data frame
  feathers <- read.table("./UCI HAR Dataset/features.txt")[,2]
  
  #Mean/Std columns positions, names
  featuresColumns <- grep(".*(mean\\(|std\\().*", feathers)
  featuresNames <- feathers[featuresColumns]
  
  #4 Appropriately labels the data set with descriptive variable names. 
  featuresNames <- gsub("^t", "Time", featuresNames)
  featuresNames <- gsub("^f", "Frequency", featuresNames)
  featuresNames <- gsub("-mean\\(\\)", "Mean", featuresNames)
  featuresNames <- gsub("-std\\(\\)", "StdDev", featuresNames)
  featuresNames <- gsub("-", "", featuresNames)
  
  
  #2 Extracts only the measurements on the mean and standard deviation for each measurement. 
  #Get means, std
  XTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")[, featuresColumns] 
  XTest <- read.table("./UCI HAR Dataset/test/X_test.txt")[, featuresColumns]
  
  XTrainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")[, 1] 
  XTestSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")[, 1]
  
  YTrain <- activityNames[read.table("./UCI HAR Dataset/train/y_train.txt")[, 1]]
  YTest <- activityNames[read.table("./UCI HAR Dataset/test/y_test.txt")[, 1]]
  
  unlink("./UCI HAR Dataset")
  
  #1 Merges the training and the test sets to create one data set.
  #Merged sets
  XMerged <- rbind(XTrain, XTest)
  XMergedSubject <- c(XTrainSubject, XTestSubject)
  YMerged <- c(YTrain, YTest) 
  
  #3 Uses descriptive activity names to name the activities in the data set
  colnames(XMerged) <- featuresNames
  
  tidyResult <- cbind(subject = XMergedSubject, activity = YMerged, XMerged)
  
  #5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  #Use this library for computing average
  library(plyr)
  tidyResultAverage <- ddply(tidyResult, .(subject, activity), function(data) { colMeans(data[,-c(1,2)])})
  names(tidyResultAverage)[-c(1,2)] <- paste0("Mean", names(tidyResultAverage)[-c(1,2)])
  
  write.table(tidyResultAverage, file = "tidyResultAverage.txt",  row.name=FALSE)
}