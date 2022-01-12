getwd()
#list.files()
#list.files("specdata")

#Problem 1

#1a
#Reading information about the variables
features <- read.table("./specdata/features.txt") #features

#Reading the training sets
s_train <- read.table("./specdata/train/subject_train.txt") #subject     
x_train <- read.table("./specdata/train/x_train.txt") #training set 
y_train <- read.table("./specdata/train/y_train.txt") #training labels

#Reading the test sets
s_test <- read.table("./specdata/test/subject_test.txt") #subject      
x_test <- read.table("./specdata/test/x_test.txt") #test set
y_test <- read.table("./specdata/test/y_test.txt") #test labels 

#Row binding the training and test sets
s_data <- rbind(s_train, s_test) #Subject
x_data <- rbind(x_train, x_test) #Set
y_data <- rbind(y_train, y_test) #Labels

#Assigning names to the variables
names(s_data) <- c("Subject")
names(x_data) <- features$V2
names(y_data) <- c("Activity")

#Merging the training and test sets
sub.act <- cbind(s_data, y_data)
merged <- cbind(sub.act, x_data)
merged.data <- merged[, !duplicated(colnames(merged))]

#1b
#install.packages("dplyr")
library(dplyr)
mean.sd <- select(merged.data, Subject, Activity, contains("mean()"), contains("std()"))

#1c
#Reading activity labels
act.labels <- read.table("./specdata/activity_labels.txt") #features
mean.sd$Activity <- as.factor(mean.sd$Activity)
levels(mean.sd$Activity) <- act.labels$V2

#1d

#To label the data set with descriptive variable names, 
#we expand the prefixes of the variables according to the following:
#tBody     time-Body
#tGravity	 time-Gravity
#Mag	     Magnitude
#Gyro	     Gyroscope
#Acc	     Accelerometer
#fBody	   fastFourierTransform_Body
#Freq	     Frequency
#BodyBody	 Body

names(mean.sd) <-gsub("tBody", "time-Body", names(mean.sd))
names(mean.sd) <-gsub("tGravity", "time-Gravity", names(mean.sd))
names(mean.sd) <-gsub("Mag", "Magnitude", names(mean.sd))
names(mean.sd) <-gsub("Gyro", "Gyroscope", names(mean.sd))
names(mean.sd) <-gsub("Acc", "Accelerometer", names(mean.sd))
names(mean.sd) <-gsub("fBody", "fastFourierTransform_Body", names(mean.sd))
names(mean.sd) <-gsub("Freq", "Frequency", names(mean.sd))
names(mean.sd) <-gsub("BodyBody", "Body", names(mean.sd))

#1e

newdata <- mean.sd %>% 
           group_by(Subject, Activity) %>% 
           summarise_each(funs(mean)) 














