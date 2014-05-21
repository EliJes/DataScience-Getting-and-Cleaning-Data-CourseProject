

## You should create one R script called run_analysis.R that does the following. 
## * 1.Merges the training and the test sets to create one data set.

test=cbind(read.table("test/y_test.txt"),read.table("test/subject_test.txt"),read.table("test/X_test.txt"))
train=cbind(read.table("train/y_train.txt"),read.table("train/subject_train.txt"),read.table("train/X_train.txt"))

df=rbind(test, train)


## *2.Extracts only the measurements on the mean and standard deviation for each measurement. 

features=read.table("features.txt")

# Version 1: By selecting matching columns
# mean_std=grepl("mean|std", as.character(features[,2])) # form a vector with TRUE for headings including "mean" or "std" in it

# df2=rbind(df,mean_std) 
# df3=df2[,df2[10300,]==1] # select columns with 1 on row 10300
# df4=df3[1:10299,] #omit row 10300

# Version 2: By adding and selecting cols which consist "mean" or "std" in their colnames (Best, because includes task nro 4.)
colnames(df) = c("activities","subject", as.character(features[,2])) #include colnames
df_2=df[,grep("mean|std|activities|subject", names(df))] #select columns

# Version 3: By matching with selected vector (short and leaves the df untouched)
# df_ms=df[,grep("mean|std", as.character(features[,2]))]


## *3.Uses descriptive activity names to name the activities in the data set

activity_labels=read.table("activity_labels.txt")
df_2$activities= activity_labels$V2[match(df_2$activities, activity_labels$V1)]

## *4.Appropriately labels the data set with descriptive activity names.

# Done already in task nro 2. Version 2.

## *5.Creates a second, independent tidy data set with the average of each variable for
##  each activity and each subject. 

df_mean=aggregate(. ~ activities + subject, df_2, FUN = mean) 

write.table(df_mean, "/Users/Elina/Dataa/mydata.txt", sep=";")
