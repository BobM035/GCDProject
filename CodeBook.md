# CodeBook
## Getting and Cleaning Data Class Project

This code book describes the variables, the data, and all transformations or work that I performed to clean up the data.

### Data Set Information:
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

For each record in the dataset it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables: **X_test.txt** & **X_train.txt**
- Its activity label: **y_test.txt** & **y_train.txt**
- An identifier of the subject who carried out the experiment: **subject_test.txt** & **subject_train.txt**

### Data Used
The **README.txt** file that came with the dataset provided an overview of the contents of each file.

All data files were found to be fixed width text (no delimiters between columns).

In addition to the six files referenced above, the **activity_labels.txt** file provided the link between the "y" files and a text description of each activity. And the **features.txt** file provides the column names for the "X" files above.

The data contained in the *Inertial Signals* subdirectories was determined, for the purposes of this project, to be redundant (as it is the source data, that the data in the "X" files were derived from).

### Data transformations
All data files were read using the *read.table()* function.  The only parameter specified was: *stringsAsFactors=FALSE*

The column name data was cleaned up by:
1. Removing the column of numbers and leaving the column of text.
2. Stripping out "(", ")", "-", and "," characters from the text.
3. I chose not to change capitalization because it would have made the column headings too hard to read.

The column names were then applied to the "X" data frames using the *colnames()* function.

The subject and activity data frames were modified to add a column header of 'subject' and 'activity'.

Next, the *cbind()* function was used to add the subject and columns to the left side of the "X" data frames. Then the *rbind()* function was used to join the test and train data frames into one combined data frame.

Per the requirements of the project, I then extracted all the columns that contained measurements containing a 'mean' or 'standard deviation'.  However, the *grep()* function I used to find matches, also included columns containing the measurement meanFreq, which I determined to be something different than mean, per the *features_info.txt* file that was included in the data set. I then ran a *-grepl()* function to get rid of those columns.

Finally, with just the right columns remaining, I used the *group_by()* and *summarise_each()* functions to create an independent  tidy data set with the average of each variable for each activity and each subject. The tidy data set was then written to disk as: *TidyData.txt*.

I decided to make my tidy data set wide because, to me, in this specific application, listing all the variables in a single column (with their values in the next column) would have made the resulting report less intuitive.
