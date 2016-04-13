train <- read.csv("~/R/Kaggle/Digits/train.csv")
test <- read.csv("~/R/Kaggle/Digits/test.csv")
train$label <- as.factor(train$label)
coordinates <- data.frame(name=colnames(train)[-1], num=c(0:783))
coordinates$col <- coordinates$num %% 28 + 1
coordinates$row <- ceiling((coordinates$num + 1) / 28)

#train2, number of pixels used in each row/column
train2 <- data.frame(matrix(NA, nrow = 42000, ncol = 56))
colnames(train2) <- apply(expand.grid(c(01:28), c("C", "R")), 1, function(x) paste((x[1]), x[2], sep=""))
train2[,1] <- apply(train[ ,as.character(coordinates$name[which(coordinates$col==1)])], 1, function(x) sum(x>0))
train2[,1:28] <- sapply(1:28, function(y) apply(train[ ,as.character(coordinates$name[which(coordinates$col==y)])], 
                                                1, function(x) sum(x>0)))
train2[,29:56] <- sapply(1:28, function(y) apply(train[ ,as.character(coordinates$name[which(coordinates$row==y)])], 
                                                1, function(x) sum(x>0)))
