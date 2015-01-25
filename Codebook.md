#Code book for getting and cleaning data course project

This codebook describes the variables, the data, and any transformations or work that is performed to clean up the data

###Variables :-
This section lists all the main variables
* <b>train.dataset</b> - train dataset is loaded in it
* <b>test.dataset</b> - test dataset is loaded in it
* <b>combined.traintest</b> - data frame in which training and testing datasets are merged
* <b>final.dataset</b> - contains extracted data on the mean and standard deviation measurements
* <b>features</b> - contains names of all the features
* <b>tidy.data</b> - data set with the average of each variable for each activity and each subject

####run_analysis.R script is organized as follows
<b>Section 1</b> - Merge the training and the testing data sets</b>
* dataset containing training and testing measurements
* dataset containing Acticity Ids
* dataset containing Subject Ids

<b>Section 2</b> - Extract only the measurements on the mean and standard deviation for each measurement
* Measurements corresponding to mean and standard deviation are extracted into different dataframe. These two dataframes are then combined together using bind_cols() function
* In the final datset, all the columns corresponding to mean comes first and then all the columns corresponding to standard deviation comes

<b>Section 3</b> - Use descriptive activity names to name the activities in the data set
* This section names all the activities as given in activity_labels.txt 

<b>Section 4</b> - Appropriately labels the data set with descriptive variable names
* Firstly, special characters such as "-", "()", "," are removed from features names
* Secondly, short forms are substituted with corresponing long forms such as "t for time", "f for Frequency", "Acc for Accelerator", "gyro for Gyroscope", "mag for Magnitude"

<b>Section 5</b> - tidy data set with the average of each variable for each activity and each subject
* This section produces tidy data as per instructions given in the project
* columns of tidy data are rearranged so that subject Ids column is first, activities column is 2nd and rest other columns comes after these two columns


