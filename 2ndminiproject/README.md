#First, we need to create a directory "specdata" in our local file. 
Here, we have already made a directory "specdata" and to make sure it has been created, we use the function list.files() and look for "specdata." To look at the contents of "specdata", we use list.files("specdata").

#1a Merges the training and the test sets to create one data set.
We read all the necessary files into R using the function read.table().
Then, we used rbind() to combine the files for the training and test set.
Now, that we have combined each of the files, we assigned their names. 
Note that the names assigned for x_data are taken from the second column of the list of all variables.
Finally, to obtain one data set for the training and test sets, 
we column bind the subject, activity, and set or the measurement.
To remove the duplicated variable names, we used !duplicated().

#1b Extracts only the measurements on the mean and standard deviation for each measurement
For this, we used the dplyr package.
Then, we selected the following columns: Subject, Activity, and the measurements that contain
"mean()" and "std()" using the select() verb in dplyr.

#1c Uses descriptive activity names to name the activities in the dataset
We read the file "activity_labels.txt" into R using read.table() and store it in "act.labels" 
We factorize the Activity column in the data set from the previous item.
After factorizing, we can store the categorical data or the descriptive activity names
for the Activity column in the data set after assigning the levels.  
In assigning the levels, we used the second column of "act.labels" 

#1d Appropriately labels the data set with descriptive variable names
For the variable names, we expanded the prefixes according to the following:
#tBody     time-Body
#tGravity	 time-Gravity
#Mag	     Magnitude
#Gyro	     Gyroscope
#Acc	     Accelerometer
#fBody	   fastFourierTransform_Body
#Freq	     Frequency
#BodyBody	 Body
Then, we use the gsub() function to replace multiple characters.
To update the variable names, we stored the value of gsub() using the names() function with the
concerned data set as an argument.

#1e From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
We used the %>% operator and dplyr verbs: group_by() and summarise_each().
We must get the average of each variables for each activity and each subject. 
Hence, we used the group verb group_by().
From this, we used summarise_each(funs(mean)) to apply the mean to each variable. 

#Finally, we obtained a tidy independent data set from one big data set. 
In 1a, we merged the training and test set to create a working data set.

From the data set in 1a we extracted only the measurements on the mean and standard deviation and obtained 
a new data set for 1b.

Then, we edited the Activity column of 1b. Because the numbers 1:6 in the Activity column have a 
corresponding descriptive name, we factorized it and used the categorical names to obtain an updated data set for 1c.

From 1c, we expanded the column names or the variable names according to its prefixes,
to obtain an updated data set for 1d.

Finally, we used the data set in 1d to obtain a tidy data with the average of each variable for each activity and each subject.



