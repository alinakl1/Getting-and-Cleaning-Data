# Getting and Cleaning Data Course Project

This repository contains the files for the Getting and Cleaning Data course project.

## Files

- `run_analysis.R` - script that downloads, merges, cleans, and summarizes the UCI HAR Dataset
- `CodeBook.md` - describes the variables, transformations, and resulting data
- `tidy_dataset.txt` - final tidy data set with the average of each variable for each activity and each subject

## How the script works

The script performs the following steps:

1. Downloads and unzips the dataset if needed
2. Loads training and test data
3. Merges the training and test sets
4. Extracts only measurements on the mean and standard deviation
5. Replaces activity IDs with descriptive activity names
6. Renames variables to make them more descriptive
7. Creates a second tidy data set with the average of each variable for each activity and each subject
8. Writes the final data set to `tidy_dataset.txt`
