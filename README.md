# Cleaning-Data-Course-Project

The codebook file titled "Codebook" contains a description of the variables used in the tidy dataset as well as additional information to explain the data.

The R script titled "run_analysis.R" contains all the code used to process the raw data into the tidy dataset.

Process Overview:
This section will describe the steps used to process the original data.  Detailed comments are also provided within the script.

Step 1:  The data used come from the following documents:  X_test.txt, Subject_test.txt, y_test.txt, X_train.txt, Subject_train.txt,y_train.txt, and features.txt.  This data is read into R using read.table() and stored in seven separate data frames titled TestData, TrainData, TestSubjectData, TrainSubjectData, TestYData, TrainYData, and variables.

Step 2:  Variable (column) names are assigned to TestSubjectData, TrainSubjectData, TestYData, and TrainYData.

Step 3:  The activities in TestYData and TrainYData are numerical.  Using library(plyr), the numerical values are converted to character values and subsequently "revalued" to character strings indicating the activity performed (e.g. walking, sitting, etc.).  

Step 4:  The data frame variables contains two columns.  The second column contains the variable names for the data and is used to set the column names for TestData and TrainData.

Step 5:  TestData and TrainData are subset to include only variables indicating a measurement of mean or standard deviation.  An important note is that variables containing meanFreq() in the variable name were excluded.  The subset is completed using the grep() function and REGEX code containing a "negative look ahead".  

Step 6:  The cbind() function is used to combine all "Test" data together and all "Train" data togther into the data frames CombTest and CombTrain.

Step 7:  The rbind() function is used to combine CombTest and CombTrain into a single data frame called AllData.

Step 8:  Using library(reshape2), the melt() and dcast() functions are applied to AllData, resulting in the tidy dataset called NewAllData.  The mean() function is used inside dcast() in order to take the average of each variable for every combination of SubjectID and SubjectActivity.
