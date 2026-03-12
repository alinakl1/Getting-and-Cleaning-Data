# Code Book

## Source Data

The data comes from the UCI Human Activity Recognition Using Smartphones Dataset.

## Included Files

- `run_analysis.R`
- `tidy_dataset.txt`

## Transformations

The script does the following:

1. Merges the training and test sets into one data set
2. Extracts only variables containing `mean()` or `std()`
3. Replaces numeric activity values with descriptive names:
   - WALKING
   - WALKING_UPSTAIRS
   - WALKING_DOWNSTAIRS
   - SITTING
   - STANDING
   - LAYING
4. Renames variables:
   - `t` -> `Time`
   - `f` -> `Frequency`
   - `Acc` -> `Accelerometer`
   - `Gyro` -> `Gyroscope`
   - `Mag` -> `Magnitude`
   - removes punctuation
5. Creates a second tidy dataset with the mean of each variable grouped by `subject` and `activity`

## Variables

- `subject`: ID of the subject
- `activity`: activity name
- all other variables are averaged sensor measurements for each subject and activity
