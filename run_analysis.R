
#Read in relevant data
TestData <- read.table("./Cleaning - Course Project/test/X_test.txt")
TestSubjectData <- read.table("./Cleaning - Course Project/test/subject_test.txt")
TestYData <- read.table("./Cleaning - Course Project/test/y_test.txt")
TrainData <- read.table("./Cleaning - Course Project/train/X_train.txt")
TrainSubjectData <- read.table("./Cleaning - Course Project/train/subject_train.txt")
TrainYData <- read.table("./Cleaning - Course Project/train/y_train.txt")
variables <- read.table("./Cleaning - Course Project/features.txt")


#Assign Variable names to Subject and Activity Data
colnames(TestSubjectData) <- "SubjectID"
colnames(TrainSubjectData) <- "SubjectID"
colnames(TestYData) <- "SubjectActivity"
colnames(TrainYData) <- "SubjectActivity"

#Relabel Activity values with meaningful descriptions
library(plyr)
TestYData$SubjectActivity <- as.character(TestYData$SubjectActivity)
TestYData$SubjectActivity <- revalue(TestYData$SubjectActivity, c("1"="Walking","2"= "Walking Upstairs","3"= "Walking Downstairs","4"= "Sitting","5"="Standing","6"= "Laying"))
TrainYData$SubjectActivity <- as.character(TrainYData$SubjectActivity)
TrainYData$SubjectActivity <- revalue(TrainYData$SubjectActivity,c("1"="Walking","2"= "Walking Upstairs","3"= "Walking Downstairs","4"= "Sitting","5"="Standing","6"= "Laying"))

#Assign Variable names to the primary data
#Variable names are already descriptive, so no further modification is made to them
colnames(TestData) <-variables$V2
colnames(TrainData) <- variables$V2

#Subset the primary data to capture only mean and standard deviation data
#Note: The variables whose titles end with "meanFreq()" are excluded
TestData <- TestData[,grep("mean(?!F)|(.*)std",names(TestData),perl = TRUE)]
TrainData <- TrainData[,grep("mean(?!F)|(.*)std",names(TrainData),perl = TRUE)]

# Combine all Test Data together and all Train Data together
CombTest <- cbind(TestSubjectData,TestYData,TestData)
CombTrain <- cbind(TrainSubjectData,TrainYData,TrainData)

#Combine Test and Train Data into a single data set
AllData <- rbind(CombTest,CombTrain)


#Create a new tidy data set with variable averages by activity and subject
library(reshape2)
NewAllData <- melt(AllData, id.vars = 1:2)
NewAllData <- dcast(NewAllData, SubjectID + SubjectActivity ~ variable, fun.aggregate = mean)

write.table(NewAllData, file = "./Cleaning - Course Project/Tidy Project Data by Means.txt",row.names = FALSE)






