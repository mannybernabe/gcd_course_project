# specify data sources from UCI HAR Dataset folder
data <- list(
        test.y        = "UCI HAR Dataset/test/y_test.txt",
        test.subject  = "UCI HAR Dataset/test/subject_test.txt",
        test.x        = "UCI HAR Dataset/test/X_test.txt",
        train.y       = "UCI HAR Dataset/train/y_train.txt",
        train.subject = "UCI HAR Dataset/train/subject_train.txt",
        train.x       = "UCI HAR Dataset/train/X_train.txt",
        features      = "UCI HAR Dataset/features.txt",
        activity.labels = "UCI HAR Dataset/activity_labels.txt"
        )

# read table with variables and activity labels
variables       <- read.table(data$features, header = FALSE, stringsAsFactors = FALSE)
activity.labels <- read.table(data$activity.labels, header=FALSE, stringsAsFactors=FALSE)

# extract column indexes used to subset X_test.txt and X_train.txt looking 
# only for mean and standard deviation measures
column.indexes  <- as.vector(sapply("mean|std", grep, variables$V2))

# read and combine reaminging data subsetting test measures (x's) by columns indexes
# each dataset on bound by column and then the two are combined on rows
aggregate.data <- rbind(
        cbind(read.table(data$test.subject, header=FALSE),
              read.table(data$test.y,       header=FALSE),
              read.table(data$test.x,       header=FALSE)[column.indexes]),
        cbind(read.table(data$train.subject, header=FALSE),
              read.table(data$train.y,       header=FALSE),
              read.table(data$train.x,       header=FALSE)[column.indexes])
        )

# function to improve readability of variables/column names
# takes as input one character variable name
FormatColumnNames <- function(variable) {
        # replace 't' or 'f' with time or frequency at start of each variable
        variable <- sub("^t", "time", variable)
        variable <- sub("^f", "frequency", variable)
        
        # "un-disambiguate" Acc and Mag
        variable <- sub("Acc", "Acceleration", variable)
        variable <- sub("Mag", "Magnitude", variable)
        
        # change 'mean' and 'std' to upper case for ease of reading
        variable <- sub("mean", "Mean", variable)
        variable <- sub("std", "Std", variable)
        
        # remove non-word characters
        variable <- gsub("[^a-zA-Z]", "", variable)
}

# assign list of formatted variables to column.names
column.names <- sapply(variables[column.indexes,2], FormatColumnNames)

# use formatted variables to re-name columns in our aggregated data
colnames(aggregate.data) <- c("subject", "activity", column.names)

# correctly label activities as factors with clear names and levels 
# as per activity_labels.txt
aggregate.data$activity <- factor(
        aggregate.data$activity,
          levels = activity.labels$V1, 
          labels = gsub("[^a-z]", ".", tolower(activity.labels$V2))
)

# correctly label test subjects as factors with clear names and levels 
aggregate.data$subject <- factor(
        aggregate.data$subject,
        levels = unique(aggregate.data$subject), 
        labels = sapply("subject", paste0, unique(aggregate.data$subject))
)

# summarise data for each subject/activity pair using the built-in 
# aggregate.data.frame function
summary.data <- aggregate.data.frame(
        aggregate.data[,-c(1:2)], 
                  list(subject  = aggregate.data$subject,
                       activity = aggregate.data$activity
                       ), 
                  mean
               )

# clean up unused variables
rm(variables, activity.labels, column.indexes, column.names, data, FormatColumnNames)
