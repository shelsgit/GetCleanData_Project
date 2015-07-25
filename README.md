Purpose
------------------
The purposes of this guide is to:

* Summarize the purpose of the scripts of this repo, run_analysis.R

* Provide instructions on how to run the script, while describing how it works and how they are connected


Summary
------------------
This script prepares tidy data that can be used for later analysis.

The raw data was collected from the accelerometers from the Samsung Galaxy S smartphone - A full description is available here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


Instructions - how to run the script
------------------
1. Download: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. Extract the zip into your working R directory

3. Save 'run_analysis.R' (from this repo) to your working 'R' directory 

4. From 'R', install and load the dplry and reshape2 packages by entering the following:
	> install.packages("dplyr")
	> library(dplyr)
	> install.packages("reshape2")
	> library(reshape2)
	
5. From 'R', run the 'run_analysis.R' script by entering the following:
	> source('run_analysis.R')


