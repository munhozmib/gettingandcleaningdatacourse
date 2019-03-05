### Attention: before running the script, it is advised to configure your 
### environment as below.

  ## Read data and convert it into one data frame
    ## features <- read.csv("./UCI HAR Dataset/features.txt", header = FALSE, sep = ' ')
    ## features <- as.character(features[,2])

  ## grabs each file for data training
    ## training.data <- read.table("./UCI HAR Dataset/train/X_train.txt")
    ## training.data.activity <- read.csv("./UCI HAR Dataset/train/y_train.txt", 
      ## header = FALSE, sep = ' ')
    ## training.data.subject <- read.csv("./UCI Har Dataset/train/subject_train.txt",
      ## header = FALSE, sep = ' ')

  ## converts each file into one data frame
    ## data.train <- data.frame(training.data.subject, training.data.activity, 
      ## training.data)
  
  ## names(data.train) <- c(c('subject', 'activity'), features)
  
  ## grabs each file for data testing
    ## testing.data <- read.table('./UCI HAR Dataset/test/X_test.txt')
    ## testing.data.activity <- read.csv('./UCI HAR Dataset/test/y_test.txt', 
      ## header = FALSE, sep = ' ')
  ## testing.data.subject <- read.csv('./UCI HAR Dataset/test/subject_test.txt', 
      ## header = FALSE, sep = ' ')
  
  ## converts them into one data frame
    ## data.test <-  data.frame(testing.data.subject, testing.data.activity,
       ##testing.data)
    ## names(data.test) <- c(c('subject', 'activity'), features)


### Here comes the script to solve each part of the project

 ## 1. Merges the training and the test sets to create one data set.
  
  data.set <- rbind(data.train, data.test)

 ## 2. Extracts only the measurements on the mean and standard deviation for 
  ## each measurement.  
  
  mean_std <- grep('mean|std', features)
  data.set2 <- data.set[,c(1, 2,mean_std + 2)] 
  
 ## 3. Uses descriptive activity names to name the activities in the data set
  
  activity <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)
  activity <- as.character(activity[,2])
  data.set2$activity <- activity[data.set2$activity]
  
 ## 4. Appropriately labels the data set with descriptive variable names.
  
  name.set <- names(data.set2)
  name.set <- gsub("[(][)]", "", name.set)
  name.set <- gsub("^t", "TimeDomain_", name.set)
  name.set <- gsub("^f", "FrequencyDomain_", name.set)
  name.set <- gsub("Acc", "Accelerometer", name.set)
  name.set <- gsub("Gyro", "Gyroscope", name.set)
  name.set <- gsub("Mag", "Magnitude", name.set)
  name.set <- gsub("-mean-", "_Mean_", name.set)
  name.set <- gsub("-std-", "_StandardDeviation_", name.set)
  name.set <- gsub("-", "_", name.set)
  names(data.set2) <- name.set
  
 ## 5. From the data set in step 4, creates a second, independent tidy data set 
  ## with the average of each variable for each activity and each subject.
  
  data.set3 <- aggregate(data.set2[,3:81], 
    by = list(activity = data.set2$activity, subject = data.set2$subject), 
    FUN = mean)
  write.table(x = data.set3, file = "data_set_3.txt", row.names = FALSE)
  