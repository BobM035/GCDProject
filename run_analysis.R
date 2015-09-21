## load required libraries
library(data.table)
library(dplyr)
## Read in data files
Xtest<-read.table("test/X_test.txt")
ytest<-read.table("test/y_test.txt")
subtest<-read.table("test/subject_test.txt") 
Xtrain<-read.table("train/X_train.txt") 
ytrain<-read.table("train/y_train.txt") 
subtrain<-read.table("train/subject_train.txt")
## Read in column names
cols<-read.table("features.txt", stringsAsFactors=FALSE)
cols<-cols[,2]
## Strip out special characters from column names
cols<-gsub('\\(','',cols)
cols<-gsub('\\)','',cols)
cols<-gsub('\\,','',cols)
cols<-gsub('-','',cols)
cols<-gsub('\\,','',cols)
## Alternate method not implemented
## make.names(cols)
## Read in Activity Labels
alabs<-read.table("activity_labels.txt", stringsAsFactors=FALSE)
## Rename Columns 
colnames(Xtest)<-cols
colnames(Xtrain)<-cols
subtest<-rename(subtest, subject = V1)
subtrain<-rename(subtrain, subject = V1)
ytest<-rename(ytest, activity = V1)
ytrain<-rename(ytrain, activity = V1)
## merge columns to add subject and activity data
bigtest<-cbind(subtest,Xtest)
bigtest<-cbind(ytest,bigtest)
bigtrain<-cbind(subtrain,Xtrain)
bigtrain<-cbind(ytrain,bigtrain)
## Merge Test and Train data sets
combodata<-rbind(bigtrain,bigtest)
## Change Activity # to Activity Label
combodata[,1]<-alabs[combodata[,1],2]
## Extract columns dealing with mean and standard deviation
mstd1<-combodata[,grep("activity|subject|std|mean",names(combodata))]
# Remove columns with meanFreq
mstd<-mstd1[,!grepl('F',names(mstd1))]
# Create Tidy Data set
TidyData<-group_by(mstd,activity,subject) %>% summarise_each("mean") 
# Write Tidy Data set to disk
write.table(TidyData,file="TidyData.txt", row.names = FALSE)

