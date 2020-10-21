library(dplyr)

#Download project files

if (!file.exists("Project_Files.zip")){
  fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl,destfile="./Project_Files.zip",method="curl")
}
if (!file.exists("UCI HAR Dataset")){
  unzip("./Project_Files.zip")
}

#Load data
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("Function_id","Functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("Activity_id", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "Subject_id")
x_test <- read.table("UCI HAR Dataset/test/x_test.txt", col.names = features$Functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "Activity_id")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "Subject_id")
x_train <- read.table("UCI HAR Dataset/train/x_train.txt", col.names = features$Functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "Activity_id")

#Merged Data
subject <- rbind(subject_train, subject_test)
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
data_1 <- cbind(subject, y, x)

#Extract mean & std measurements
data_2<-select(data_1,Subject_id,Activity_id, contains("mean"), contains("std"))

#Change to activity names

data_2$Activity_id<-activities[data_2$Activity_id,2]

#Change to descriptive variable names
names(data_2)[2] = "Activity"
names(data_2)<-gsub("mean","Mean",names(data_2), ignore.case = TRUE)
names(data_2)<-gsub("std","Std",names(data_2), ignore.case = TRUE)
names(data_2)<-gsub("gravity","Gravity",names(data_2), ignore.case = TRUE)
names(data_2)<-gsub("angle","Angle",names(data_2), ignore.case = TRUE)
names(data_2)<-gsub("^f","Frequency",names(data_2), ignore.case = TRUE)
names(data_2)<-gsub("^t","Time",names(data_2), ignore.case = TRUE)
names(data_2)<-gsub("\\.t","\\.Time",names(data_2), ignore.case = TRUE)
names(data_2)<-gsub("acc","Accelerometer",names(data_2), ignore.case = TRUE)
names(data_2)<-gsub("gyro","Gyroscope",names(data_2), ignore.case = TRUE)
names(data_2)<-gsub("mag","Magnitude",names(data_2), ignore.case = TRUE)

#New data set with the average of each variable for each activity and each subject

final_data <-data_2 %>%  
  group_by(Subject_id, Activity) %>% summarise_all(mean)

names(final_data)[-(1:2)]<-gsub("^","Mean\\.",names(final_data)[-(1:2)])
write.table(final_data, "FinalData.txt")
