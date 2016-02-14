# har_assignment

This repo contains the code for producing the tidy data file based on the har data.

The code performs the following steps:

1) read in the descriptive data files features.txt and activity_labels.txt
2) read in the training and test data sets
3) merge the data sets together
4) add some column names to the merged data set - this uses the data read in step 1
5) join the 3 separate files into one big data file of subject, activity and measurements
6) extract just the columns we are interested in (mean and standard deviation)
7) write out the new file


