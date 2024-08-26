library(reshape2)
library(dplyr)

fileName <- "./data/getcleandata_dataset.zip"

if(!file.exists("./data")) {dir.create("./data")}
if(!file.exists(fileName)) {
      fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(fileURL, destfile = fileName, method = "curl")}
if(file.exists(fileName)) {
      unzip(fileName, exdir = "./data")}

activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
features <- read.table("data/UCI HAR Dataset/features.txt")
features <- as.character(features$V2)

featuresWanted <- grep(".*mean.*|.*std.*", features)
featuresWantedNames <- features[featuresWanted]
featuresWantedNames <- gsub("-mean", "Mean", featuresWantedNames)
featuresWantedNames <- gsub("-std", "Std", featuresWantedNames)
featuresWantedNames <- gsub("[-()]","", featuresWantedNames)

train <- read.table("data/UCI HAR Dataset/train/X_train.txt")[featuresWanted]
trainActivity <- read.table("data/UCI HAR Dataset/train/y_train.txt")
trainSubjects <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivity, train)

test <- read.table("data/UCI HAR Dataset/test/X_test.txt")[featuresWanted]
testActivity <- read.table("data/UCI HAR Dataset/test/y_test.txt")
testSubjects <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivity, test)

allData <- rbind(train, test)
colnames(allData) <- c("Subjects", "Activity", featuresWantedNames)

allData$Activity <- factor(allData$Activity, levels = activity_labels$V1, labels = activity_labels$V2)
allData$Subjects <- as.factor(allData$Subjects)

allDataMeanSA <- allData %>% melt(id=c("Subjects", "Activity")) %>%
                  dcast(Subjects + Activity ~ variable, mean)

write.table(allDataMeanSA, "./data/tidy.txt", row.names = F, quote = F)