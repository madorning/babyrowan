library(rjson)

# import raw data
babyData <- fromJSON(file = "babyplus_data_export.json")
babyData <- babyData$babies[[1]]

# feeding data
food <- data.frame(matrix(unlist(babyData$feed$breastfeed), nrow=345, byrow=T), 
                   stringsAsFactors=FALSE)
names(food) <- c("side", "start", "end", "duration_sec")
food$date <- sapply(strsplit(food$start, split=" "), "[[", 1)
food$startT <- sapply(strsplit(food$start, split=" "), "[[", 2)
food$startT <- sapply(strsplit(food$startT, split="[.]"), "[[", 1)
food$endT <- sapply(strsplit(food$end, split=" "), "[[", 2)
food$endT <- sapply(strsplit(food$endT, split="[.]"), "[[", 1)

# diapering data
diaper <- data.frame(matrix(unlist(babyData$nappy), nrow=137, byrow=T), 
                     stringsAsFactors=FALSE)
names(diaper) <- c("time", "description", "condition")
diaper$date <- sapply(strsplit(diaper$time, split=" "), "[[", 1)
diaper$time <- sapply(strsplit(diaper$time, split=" "), "[[", 2)
diaper$time <- sapply(strsplit(diaper$time, split="[.]"), "[[", 1)

# export
write.csv(food, "food.csv")
write.csv(diaper, "diaper.csv")
