## Read in data files
Xtest = read.table("test/X_test.txt") 
ytest = read.table("test/y_test.txt") 
subtest = read.table("test/subject_test.txt") 
Xtrain = read.table("train/X_train.txt") 
ytrain = read.table("train/y_train.txt") 
subtrain = read.table("train/subject_train.txt")
##merge columns
bigtest<-cbind(subtest,Xtest)
bigtest<-cbind(ytest,bigtest)
bigtrain<-cbind(subtrain,Xtrain)
bigtrain<-cbind(ytrain,bigtrain)
##Merge Test and Train
combodata<-rbind(bigtrain,bigtest)
