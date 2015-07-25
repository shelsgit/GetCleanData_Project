# !Note: Be sure that the 'UCI HAR Dataset' folder is in your home directory
# !Be sure that dplyr and reshape2 package is installed and loaded before running this script
#
## This script does the following:
## 1 - Merges the training and the test sets to create one data set (TidySet_AVES)
## 2 - Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3 - Uses descriptive activity names to name the activities in the data set
## 4 - Appropriately labels the data set with descriptive variable names. 
## 5 - From the data set in step 4, creates a second, independent tidy data set(TidySet_AVEs) with the average of each variable for each activity and each subject.

# Get URLs of training and test sets
TrainX_SetURL <- "UCI HAR Dataset/test/X_test.txt"
TrainY_SetURL <- "UCI HAR Dataset/test/y_test.txt"
Train_SubjURL <- "UCI HAR Dataset/test/subject_test.txt"
TestX_SetURL <- "UCI HAR Dataset/train/X_train.txt"
TestY_SetURL <- "UCI HAR Dataset/train/y_train.txt"
Test_SubjURL <- "UCI HAR Dataset/train/subject_train.txt"
Cols_Y_ActivityURL <- "UCI HAR Dataset/activity_labels.txt"
Cols_set_FeaturesURL <- "UCI HAR Dataset/features.txt"

# Read train and test datasets
TrainY_Set <- read.table(TrainY_SetURL, col.names = "ActivityNum")
Train_Subj <- read.table(Train_SubjURL, col.names = "Subject")
TestY_Set <- read.table(TestY_SetURL, col.names = "ActivityNum")
Test_Subj <- read.table(Test_SubjURL, col.names = "Subject")
Cols_Y_Activity <- read.fwf(Cols_Y_ActivityURL, widths = c(1,-1,20), col.names = c("ActivityNum","Activity"))
Cols_set_Features <- read.table(Cols_set_FeaturesURL)
TrainX_Set <- read.table(TrainX_SetURL, strip.white=TRUE, col.names = Cols_set_Features$V2, sep = "", check.names=FALSE)
TestX_Set <- read.table(TestX_SetURL, strip.white=TRUE, col.names = Cols_set_Features$V2, sep = "", check.names=FALSE)

# Merge Activity descriptions into Train and Test Y Sets
TrainY_Set <- merge(TrainY_Set, Cols_Y_Activity, by.x="ActivityNum", by.y="ActivityNum", all = TRUE, sort = FALSE)
TestY_Set <- merge(TestY_Set, Cols_Y_Activity, by.x="ActivityNum", by.y="ActivityNum", all = TRUE, sort = FALSE)

# Filter out only the STD and Mean columns of the trainX and testX sets
#ptn1 <- '.*?mean.*?'
#ptn2 <- '.*?std.*?'
ptn1 <- '.*?mean()'
ptn2 <- '.*?std()'
MeanSD_Cols <- c(grep(ptn1, Cols_set_Features$V2, perl=T), grep(ptn2, Cols_set_Features$V2, perl=T))
TrainX_Set <- TrainX_Set[,MeanSD_Cols]
TestX_Set <- TestX_Set[,MeanSD_Cols]

# Combine columns of each Test and Train Set
Test_Combined <- cbind(Test_Subj, TestY_Set, TestX_Set)
Train_Combined <- cbind(Train_Subj, TrainY_Set, TrainX_Set)

# Combine Test and Train Sets into one (TidySet)
TidySet <- rbind(Test_Combined, Train_Combined)
TidySet <- select(TidySet, -ActivityNum)

# Create Dataset (TidySet_AVES), with the average of each variable for each activity and each subject
# TidySet_AVEs_Subj <- dcast(Tidymelt, Subject ~ variable, mean)
# TidySet_AVEs_Activity <- dcast(Tidymelt, Activity ~ variable, mean)
Tidymelt <- melt(data = TidySet,id=c("Subject", "Activity"), measure.vars = colnames(TidySet[,grep("mean|std",colnames(TidySet))]))
TidySet_AVEs <- dcast(Tidymelt, Activity + Subject ~ variable, mean)

# Remove all other sets
#rm(Cols_set_Features, Cols_Y_Activity, Test_Combined, Test_Subj, TestX_Set, TestY_Set, Tidymelt, Train_Combined, Train_Subj, TrainX_Set, TrainY_Set)
#rm(Cols_set_FeaturesURL, Cols_Y_ActivityURL, MeanSD_Cols, ptn1, ptn2, Test_SubjURL, TestX_SetURL, TestY_SetURL, Train_SubjURL, TrainX_SetURL, TrainY_SetURL)
