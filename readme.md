---
title: "Readme"
author: "Greg Gibson"
date: "October 10, 2019"
output: html_document
---

Coursera Getting and Cleaning Data Week 4 Project
run_analysis.R

Downloads and unzips file from provided link:  "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

Data provided is a dataset of 563 variables based on volunteers wearing accelerometers from the Samsung Galaxy S smartphone.
The data was split between 7,352 observations in a training file and 2,947 observations in a test file, along with a
features file identifiying the variables and activity label file identifying six activity categories.

The files were imported into tables and col.names arguments were set equal to the label files to create column headers.
Training and testing tables were combined into one data source for analysis.

Data was further tidied by reducing variables to those labeled with "mean" or "std".  Using the actual . allowed exclusion of "meanfreq".
Variable names were further clarified by replacing abbreviations with full words or longer abbreviations.

The project required a mean of each variable per activity and subject, performed via chaining a group_by and summarize_all and saved as dataTidy.
dataTidy written out to file as tidydata.txt