# run_analysis.R

# Download and unzip data if needed
file_url <- "https://d396qusza40orc.cloudfront.net/projectfiles/UCI%20HAR%20Dataset.zip"
zip_file <- "dataset.zip"

if (!file.exists(zip_file)) {
  download.file(file_url, zip_file, mode = "wb")
}

if (!dir.exists("UCI HAR Dataset")) {
  unzip(zip_file)
}

base_path <- "UCI HAR Dataset"

# Read files
features <- read.table(file.path(base_path, "features.txt"), stringsAsFactors = FALSE)
activity_labels <- read.table(file.path(base_path, "activity_labels.txt"), stringsAsFactors = FALSE)

x_train <- read.table(file.path(base_path, "train", "X_train.txt"))
y_train <- read.table(file.path(base_path, "train", "y_train.txt"))
subject_train <- read.table(file.path(base_path, "train", "subject_train.txt"))

x_test <- read.table(file.path(base_path, "test", "X_test.txt"))
y_test <- read.table(file.path(base_path, "test", "y_test.txt"))
subject_test <- read.table(file.path(base_path, "test", "subject_test.txt"))

# Name columns
colnames(x_train) <- features[, 2]
colnames(x_test) <- features[, 2]
colnames(y_train) <- "activity"
colnames(y_test) <- "activity"
colnames(subject_train) <- "subject"
colnames(subject_test) <- "subject"

# Merge train and test
train_data <- cbind(subject_train, y_train, x_train)
test_data <- cbind(subject_test, y_test, x_test)
merged_data <- rbind(train_data, test_data)

# Extract only mean and std measurements
selected_cols <- grepl("mean\\(\\)|std\\(\\)", colnames(merged_data))
tidy_data <- merged_data[, c(TRUE, TRUE, selected_cols)]

# Use descriptive activity names
activity_labels$V2 <- c(
  "WALKING",
  "WALKING_UPSTAIRS",
  "WALKING_DOWNSTAIRS",
  "SITTING",
  "STANDING",
  "LAYING"
)

tidy_data$activity <- activity_labels$V2[match(tidy_data$activity, activity_labels$V1)]

# Clean variable names
clean_names <- colnames(tidy_data)
clean_names <- gsub("^t", "Time", clean_names)
clean_names <- gsub("^f", "Frequency", clean_names)
clean_names <- gsub("Acc", "Accelerometer", clean_names)
clean_names <- gsub("Gyro", "Gyroscope", clean_names)
clean_names <- gsub("Mag", "Magnitude", clean_names)
clean_names <- gsub("BodyBody", "Body", clean_names)
clean_names <- gsub("-mean\\(\\)", "Mean", clean_names)
clean_names <- gsub("-std\\(\\)", "STD", clean_names)
clean_names <- gsub("-", "", clean_names)
clean_names <- gsub("\\(\\)", "", clean_names)

colnames(tidy_data) <- clean_names

# Create second independent tidy dataset with averages
second_tidy_data <- aggregate(. ~ subject + activity, data = tidy_data, FUN = mean)

# Order rows
second_tidy_data <- second_tidy_data[order(second_tidy_data$subject, second_tidy_data$activity), ]

# Write output
write.table(second_tidy_data, "tidy_dataset.txt", row.names = FALSE)
