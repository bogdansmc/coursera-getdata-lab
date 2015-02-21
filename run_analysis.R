require(plyr)

# Read raw data
features <- read.table("features.txt")
activities <- read.table("activity_labels.txt")

train_x <- read.table("train/X_train.txt")
train_subject <- read.table("train/subject_train.txt")
train_y <- read.table("train/y_train.txt")

test_x <- read.table("test/X_test.txt")
test_subject <- read.table("test/subject_test.txt")
test_y <- read.table("test/y_test.txt")

# Merges the training and the test sets to create one data set.
all_x <- rbind(train_x, test_x)
all_subject <- rbind(train_subject, test_subject)
all_y <- rbind(train_y, test_y)

names(all_x) <- features$V2
names(all_subject) <- c("Subject.ID")

# Extracts only the measurements on the mean and standard deviation for each measurement. 
subset_indexes <- grep("mean\\(\\)|std\\(\\)", features$V2)
subset_x <- all_x[subset_indexes]

# Uses descriptive activity names to name the activities in the data set
all_y <- merge(all_y, activities)
names(all_y) <- c("Activity.ID", "Activity.Label")

# Appropriately labels the data set with descriptive variable names. 
names(subset_x) <- make.names(names(subset_x))
names(subset_x) <- gsub('\\.\\.', "", names(subset_x))
names(subset_x) <- gsub('^t', 'TimeDomain.', names(subset_x))
names(subset_x) <- gsub('^f', 'FrequencyDomain.', names(subset_x))
names(subset_x) <- gsub('\\.std\\.', '.StandardDeviation.', names(subset_x))
names(subset_x) <- gsub('\\.mean\\.', '.Mean.', names(subset_x))
names(subset_x) <- gsub('Mag\\.', '.Magnitude.', names(subset_x))
names(subset_x) <- gsub('Acc\\.', '.Acceleration.', names(subset_x))
names(subset_x) <- gsub('AccJerk\\.', '.LinearAcceleration.', names(subset_x))
names(subset_x) <- gsub('GyroJerk\\.', '.AngularVelocity.', names(subset_x))
names(subset_x) <- gsub('Gyro\\.', '.Gyroscope.', names(subset_x))
names(subset_x) <- gsub('BodyBody\\.', 'Body.', names(subset_x))


# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
subset_data <- cbind(all_subject, all_y, subset_x)
subset_avg <- ddply(subset_data, c("Subject.ID", "Activity.ID", "Activity.Label"), numcolwise(mean))
write.table(subset_avg, file="subset_avg.txt")
