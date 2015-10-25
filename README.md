# Getting-and-Cleaning-Data-Project
Class Project for Getting and Cleaning Data Course

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


The included run_analysis.R script extracts and creates a tidy data set.

run_analysis.R expects the following packages to be pre-installed: reshape, dplyr, plyr, reshape2 
The installation of these packages is commented out in the R script but can be uncommented for installation.

The script performs the following:

1. Loads the train and test data files supplied in the referenced zip folder.

2. Loads the train and test data files into data tables and then renames the variables. The variables are manually assigned for subject and activity. For the features, the variables are named from the features text file.

3. Once the columns are named, a cbind and rbind are used to combine the test and train data sets.

4. The merged data set is then filtered to include only the columns of subject, activity_id, and variables with mean and standard deviation (std)

5. An additional column is added providing descriptive activity names.

6. Finally, an independent tidy data set is created by melting the data set, grouping by subject and activity, and applying mean to all other variables. This is then cast back into a long format and the tidy_data_set.txt is produced. The tidy data set provides a single row per subject/activity for further analysis.

Further description of the tidy_data_set.txt can be located in the codebook.txt (https://github.com/ASykut/Getting-and-Cleaning-Data-Project/blob/master/codebook.txt) file of this Repository.
