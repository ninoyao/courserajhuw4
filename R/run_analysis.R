#mission 1 Merges the training and the test sets to create one data set.
#read data
Train <- data.table(read.table("/Users/nino/Desktop/coursera/3 getting and cleaning data/project/UCI HAR Dataset/train/subject_train.txt"))
Test <- data.table(read.table("/Users/nino/Desktop/coursera/3 getting and cleaning data/project/UCI HAR Dataset/test/subject_test.txt"))
xTrain <- data.table(read.table("/Users/nino/Desktop/coursera/3 getting and cleaning data/project/UCI HAR Dataset/train/X_train.txt"))
xTest<-data.table(read.table("/Users/nino/Desktop/coursera/3 getting and cleaning data/project/UCI HAR Dataset/test/X_test.txt"))
yTrain <- data.table(read.table("/Users/nino/Desktop/coursera/3 getting and cleaning data/project/UCI HAR Dataset/train/Y_train.txt"))
yTest<-data.table(read.table("/Users/nino/Desktop/coursera/3 getting and cleaning data/project/UCI HAR Dataset/test/Y_test.txt"))
# merge 
MergeTestTrain <- rbind(Train,Test)
setnames(MergeTestTrain, "V1", "MergeTestTrain")
Ymerge <- rbind(yTrain,yTest)
Xmerge <- rbind(xTrain,xTest)
setnames(Ymerge,"V1","Ymer")
setnames(Xmerge,"Xmer","V1")
Mergeall <- cbind(Xmerge,Ymerge,MergeTestTrain)
#mission 2 Extracts only the measurements on the mean and standard deviation
Datafeature <- fread("/Users/nino/Desktop/coursera/3 getting and cleaning data/project/UCI HAR Dataset/features.txt")
posMeanStd <- grep("mean|std",Datafeature$V2)
posMeanStd <- c(posMeanStd,562,563)
meanAndStd <- subset(Mergeall,select = posMeanStd)
#mission 3 Uses descriptive activity names to name the activities in the data set
actnames<- fread("/Users/nino/Desktop/coursera/3 getting and cleaning data/project/UCI HAR Dataset/activity_labels.txt")
names(actnames) <- c("Ymer","Activities")
Datawithnames <- merge(meanAndStd,actnames, by = "Ymer")
# mission 4 Appropriately labels the data set with descriptive variable names. 
fNames <- Datafeature$V2[posMeanStd]
fNames <- fNames[c(1:79)]
fNames
fNames <- gsub("-","_",fNames)
fNames <- gsub("\\(\\)","",fNames)
fNames <- gsub("Body","Body_",fNames)
fNames <- gsub("Acc","_Acc_",fNames)
fNames <- gsub("Gyro","Gyro_",fNames)
fNames <- gsub("Jerk","Jerk_",fNames)
fNames <- gsub("meanFreq","mean_Freq",fNames)
fNames <- gsub("__","_",fNames)
fNames
fNames <- append(c("Activity_ID"),fNames) 
fNames <- append(fNames,c("Subject","Activity_Name"))
fNames
names(Datawithnames) <- fNames
# mission 5 Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
Vars <- names(Datawithnames)[2:80]
Vars
dataMelt <- melt(Datawithnames, id = c("Subject","Activity_ID","Activity_Name"),measure.vars = Vars)
tidydata <- dcast(dataMelt, Subject + Activity_Name ~ variable,mean)
write.table(tidydata,"tidyData.txt",row.names = FALSE)

