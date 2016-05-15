# gacdProject
The Course Project for "Getting and Cleaning Data" on Coursera


Script Explanation
==================
run_analysis.R
--------------

This script splits the work into the following sections:
	1. Tidying the training and testing datasets seperately
	2. Merging the training and testing datasets together
	3. Creating a dataset containing averages of each variable for each activity and each subject
	
The script requires the implementation of the **data.table** package, which is checked for at the beginning of the script. Two functions were created to improve clarity of the script. The first function, *switchLabels*, changes the original numeric labels of a data frame to more meaningful values. The second, *getSbjActMean*, calculates the mean for a given subject/activity combination, and returns a data frame with the means for each column.
