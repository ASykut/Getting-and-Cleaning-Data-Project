
##install "reshape" package to pivot features rows into columns for naming
install.packages("reshape")
library(reshape)

##install "dplyr" package to select mean and std dev columns
install.packages("dplyr")
library(dplyr)

##install "plyr
install.packages("plyr")
library(plyr)

##install "reshape"
install.packages("reshape2")
library(reshape2)

##identify all important filenames Assumes data has been extracted into UCI HAR Dataset folder in Working Directory

##Features List
fln_features <- "UCI HAR Dataset//features.txt" 

##Activity List
fln_activities <- "UCI HAR Dataset//activity_labels.txt"

##Test Data
fln_subject_test <- "UCI HAR Dataset//test//subject_test.txt"
fln_x_test <- "UCI HAR Dataset//test//x_test.txt"
fln_y_test <- "UCI HAR Dataset//test//y_test.txt"

##Train Data
fln_subject_train <- "UCI HAR Dataset//train//subject_train.txt"
fln_x_train <- "UCI HAR Dataset//train//x_train.txt"
fln_y_train <- "UCI HAR Dataset//train//y_train.txt"


##Prepare Features List
data_features <- t(read.table(fln_features))
features <- data_features[2,]

##Prepare Activities List
data_activities <- read.table(fln_activities)

##Prepare Test data, providing descriptive colnames for each variable
data_subject_test <- read.table(fln_subject_test)
colnames(data_subject_test) <- "subject"

data_x_test <- read.table(fln_x_test)
colnames(data_x_test) <- c(features)

data_y_test <- read.table(fln_y_test)
colnames(data_y_test) <- "activity_id"

data_subject_train <- read.table(fln_subject_train)
colnames(data_subject_train) <- "subject"

data_x_train <- read.table(fln_x_train)
colnames(data_x_train) <- c(features)

data_y_train <- read.table(fln_y_train)
colnames(data_y_train) <- "activity_id"

##Merge Data Into 1 DataSet
data_test_combined <- cbind(data_subject_test, data_x_test, data_y_test)
data_train_combined <- cbind(data_subject_train, data_x_train, data_y_train)
data_full_merge <- data.frame(rbind(data_test_combined, data_train_combined))

##Extract Specific Columns of subject, activity_id, and Mean/Std Deviation
##Clean Column Names to remove special characters to support mean/std extraction
valid_column_names <- make.names(names=names(data_full_merge), unique=TRUE, allow_ = TRUE)
names(data_full_merge) <- valid_column_names
SEL_Data <- select(.data = data_full_merge, subject, activity_id, matches("(mean|std)"))

##Label Activities with Descriptive activity Names
Final_Set <- data.frame(merge(SEL_Data, data_activities, by.x="activity_id", by.y = "V1"))
colnames(Final_Set)[89] <- "activity" 

##Summarize Data grouped by subject and activity, providing mean of each group
##reshape data
mt <- melt(Final_Set, id.vars = c("subject","activity"))
##calculate mean
dt_mean <- ddply(mt, c("subject", "activity", "variable"), summarise, mean = mean(value))
##reshape data
ct <- dcast(dt_mean, subject + activity ~ variable)

##Write Results to text file
write.table(ct, "tidy_data_set.txt",row.name = FALSE)
