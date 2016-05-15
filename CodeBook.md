 gacdProject Codebook
 ====================
 
 Variables
 ---------
 **featureLabels**: Holds the names of the features that are collected in the original dataset.
 **testLabels**: Holds the activity IDs for each entry in the testing dataset.
 **trainLabels**: Holds the activity IDs for each entry in the training dataset.
 
 Data
 ----
 **actLabels**: The original file holding the activity labels.
 **featureList**: 
 **fullTable**: The tidied and combined training/testing dataset.
 **meansTable**: The table of averages of each variable for each activity and each subject.
 **sbjActList**: The list of all subject/activity combinations found in the total dataset.
 **subjectTest**: The original file holding the subject IDs of subjects in the testing dataset.
 **subjectTrain**: The original file holding the subject IDs of subjects in the training dataset.
 **testData**: The original file holding the feature data for each row in the testing dataset.
 **testTable**: The tidied and combined testing dataset.
 **trainData**: The original file holding the feature data for each row in the training dataset.
 **trainTable**: The tidied and combined training dataset.
 
 Transformations
 ---------------
 In order to clean up the dataset, the labeling for all segements of the dataset needed to be improved. Previously, they were either non-descriptive numeric values or non-existant. As such, the numeric activity values were substituted for the string equivalent supplied in the **activity_labels.txt** file. Furthermore, the feature labels for the dataset from the "features.txt" file were put into the dataset proper.