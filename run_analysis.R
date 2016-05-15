#Make sure to set the working directory to be
#wherever the gacdProject repo was saved.

require(data.table)

#Files for use:
#Get meaningful activity labels from the "activity_labels.txt" file:
actLabels     = read.table("./Dataset/activity_labels.txt")

#Get meaningful feature labels from the "features.txt" file:
featureLabels = read.table("./Dataset/features.txt")

#Get the subject, activity, and feature data for the training set
subjectTrain  = read.table("./Dataset/train/subject_train.txt")
trainLabels   = read.table("./Dataset/train/y_train.txt")
trainData     = read.table("./Dataset/train/X_train.txt")

#Get the subject, activity, and feature data for the testing set
subjectTest = read.table("./Dataset/test/subject_test.txt")
testLabels  = read.table("./Dataset/test/y_test.txt")
testData    = read.table("./Dataset/test/x_test.txt")




#Functions for use:
#Changes out the numeric labels for meaningful labels
switchLabels = function(labelSet, newLabels) {
  lapply(labelSet, function(x) {
      newLabels[x,2]
  })
}

#Match subject/activity combinations, and average them together:
getSbjActMean = function(combination, table) {
  featureList = table[table$`Subject ID` == as.numeric(combination[1]) & table$Activity == combination[2] ,c(3:length(table))]
  featureList = lapply(featureList, mean)
  as.data.frame(c(combination, featureList))
}



#I decided to combine the labels for each set before
#putting the two sets together. Due to this, there will
#be some reduplication in steps, but I preferred doing
#it this way over combining each seperate section as
#it will let me test combinations on smaller sets of
#the data, thus making each iteration of the script
#to be smaller as I was building it.



featureLabels = featureLabels[,2]
names(trainData) = featureLabels
names(testData)  = featureLabels

#Switch out the labels to the activity names
trainLabels = switchLabels(trainLabels, actLabels)
testLabels  = switchLabels(testLabels, actLabels)

#Assigning proper labels to the subject and activity columns:
names(subjectTrain) = "Subject ID"
names(trainLabels)  = "Activity"
names(subjectTest)  = "Subject ID"
names(testLabels)   = "Activity"

#Merge activity and features:
trainTable = cbind(subjectTrain, trainLabels, trainData)
testTable  = cbind(subjectTest, testLabels, testData)

#Combine the training and testing datasets:
fullTable = rbind(trainTable, testTable)

#Extracting only the required features using a regular expression:
fullTable = fullTable[,c("Subject ID", "Activity", grep("mean|std", featureLabels, value=TRUE))]


#Creating independent dataset:
#First, get a list of all unique combinations of subject/activity.
sbjActList = unique(fullTable[,c("Subject ID", "Activity")])

#Using this list, iterate through each combination, and find the average:
meansTable = rbindlist(lapply(transpose(sbjActList), getSbjActMean, fullTable))

#Adjust the names (They were adjusted during the apply function)
names(meansTable) = names(fullTable)

#Write the new data frame to file
write.csv(meansTable, file = "subjectMeans.csv")

