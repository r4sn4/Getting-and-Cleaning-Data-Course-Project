#load library dplyr
library(dplyr)

#create working directory
setwd("E:/rasna/D drive/Datascience/GettingAndCleaningData/WorkingDir")

#Section 1 - Merge the training and the testing data sets
# read rain file data and test file data into data frame
train.dataset <- read.table("./X_train.txt")
test.dataset <- read.table("./X_test.txt")
combined.traintest <- bind_rows(train.dataset , test.dataset)

train.subjectid <- as.vector(read.table("./subject_train.txt"))
test.subjectid <- as.vector(read.table("./subject_test.txt"))
subject.ids <- bind_rows(train.subjectid,test.subjectid)

train.activityid <- as.vector(read.table("./y_train.txt"))
test.activityid <- as.vector(read.table("y_test.txt"))
activity.ids <- bind_rows(train.activityid,test.activityid)
#Section 1 ends

features <- read.table("./features.txt")
features <- as.vector(features[, 2])
colnames(combined.traintest) <- features


#Section 2 - Extracts measurements on mean and standard deviation
mean.dataset <- combined.traintest[,grepl("mean",colnames(combined.traintest),ignore.case = TRUE)]
stddev.dataset <- combined.traintest[,grepl("std",colnames(combined.traintest),ignore.case = TRUE)]
mean.std.dataset <- bind_cols(mean.dataset,stddev.dataset)

# Add Activity Id and subject Id to final dataset
final.dataset <- bind_cols(subject.ids, activity.ids, mean.std.dataset)
colnames(final.dataset) <- c("subject.ids","activities",colnames(mean.std.dataset))
#Section 2 Ends

##Section 3 - descriptive activity names to name the activities in the data set
final.dataset$activities <- as.character(final.dataset$activities)
final.dataset$activities[final.dataset$activities==1] <- "WALKING"
final.dataset$activities[final.dataset$activities==2] <- "WALKING UPSTAIRS"
final.dataset$activities[final.dataset$activities==3] <- "WALKING DOWNSTAIRS"
final.dataset$activities[final.dataset$activities==4] <- "SITTING"
final.dataset$activities[final.dataset$activities==5] <- "STANDING"
final.dataset$activities[final.dataset$activities==6] <- "LAYING"
final.dataset$activities <- as.factor(final.dataset$activities)
#Section 3 ends

#Section 4 - Appropriately labels the data set with descriptive variable names
# Remove special characters such as " - , ( ) "from features 
pattern <- "-|\\(|\\)|,"
colnames(final.dataset) <- sapply(colnames(final.dataset), function(X) gsub(pattern,"",X))

# Give descriptive name to columns
names(final.dataset) <- gsub("^t","time",colnames(final.dataset))
names(final.dataset) <- gsub("^f","frequency",colnames(final.dataset))
names(final.dataset) <- gsub("Acc","Accelerator",colnames(final.dataset))
names(final.dataset) <- gsub("Gyro","Gyroscope",colnames(final.dataset))
names(final.dataset) <- gsub("Mag","Magnitude",colnames(final.dataset))
#Section 4 ends

#Section 5 - tidy data set with the average of each variable for each activity and each subject
tidy.data <- aggregate(. ~ activities + subject.ids, final.dataset, mean)

#rearrange columns so that subject.ids is first column, acivities is 2nd, and rest of the columns comes after these two columns
tidy.data <- select(tidy.data,subject.ids,activities, timeBodyAcceleratormeanX : frequencyBodyBodyGyroscopeJerkMagnitudestd)
write.table(tidy.data, './tidyData.txt',row.names=FALSE,sep='\t')
#Section 5 ends
