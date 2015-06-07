Script has one function which name is "run_analysis()". Each step is composed of function invocations to make some operations with data.
First of all we download data from Internet. After this step we prepare working data for script necessity. Next we change data column names to make date much representative.
When all preparing steps are completed we fetch data from downloaded zip archive and merge it in one data frame according to column names (mean, std).
After this point we enrich data with column names and combine all parts together. Result is "tidyResult" variable where all data is prepared to create an "average" data set.
Using "plyr" library and "ddply" function we create result data frame "tidyResultAverage" and write it in file "tidyResultAverage.txt".

destfileName - downloaded file name
activityNames - activity vectors
feathers - all measurements in the research
featuresColumns - column positions with appropriate column names
featuresNames - column names
XTrain - main research data from train directory
XTest - main research data from test directory
XTrainSubject - subjects from train directory
XTestSubject - subjects from test directory
YTrain - activities from train directory
YTest - activities from test directory
XMerged - merged main research data
XMergedSubject - merged subjects
YMerged - merged activities
tidyResult - combination of merged main research data subjects and activities
tidyResultAverage - result after all data operations