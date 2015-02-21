# Code book

## What script do

* Reading raw data from files features.txt, activity_labels.txt, train/X_train.txt, train/subject_train.txt, train/y_train.txt, test/X_test.txt, test/subject_test.txt, test/y_test.txt
* Merging test and training data into variables all_x, all_subjects, all_y
* Set names for all_x from features.txt
* Create subset with mean and std columns into variable subset_x
* Add descriptive activity names from file activity_labels.txt
* Rename variable names
* Join all_subject, all_y, subset_x into variable subset_data
* Calc means 
* Write result to file subset_avg.txt
