if(!require(OneR)){
  install.packages("OneR")
  library(OneR)
}

if(!require(ggplot2)){
  install.packages("ggplot2")
  library(ggplot2)
}

setwd("/home/geymerson/Documents/ecom_089_2017_1/classifierProject/rscript/")
rd <- read.table("../datasets/dataFilePath.txt", header = FALSE)
data <- read.csv(as.character(rd$V1))
  
# Required only if reproduction is needed 
#set.seed(12)

# Generate trainning data
random <- sample(1:nrow(data), 0.7 * nrow(data) )
data_train <- optbin(data[random, ], method = "infogain")

# Generate test data
data_test <- data[-random, ]
save(data_test, file = "../robjects/data_test.rda")

# Create trainning data plot
ggplot(data_test, aes(x = label, fill = label)) +
  geom_bar()
ggsave("../plots/data_test.jpg")

# If a trainning model already exists, load it
# otherwise, create a model from the trainning data
if(file.exists("../robjects/model_train.rda")) {
  print("A model already exists.")
  load("../robjects/model_train.rda")
} else {
  model_train <- OneR(data_train, verbose = TRUE)
  save(model_train, file = "../robjects/model_train.rda")
}

# Plot the trainning model results
png("../plots/trainningPlot.png");
plot(model_train)
dev.off();

# Uncomment the code below to restore
# output in the terminal
#sink()
#sink(type="message")

# Save the trainning model log
sink("../rlogs/modelSummary.log", append=FALSE, split=FALSE)
summary(model_train)

sink("../rlogs/eval_model.log", append=FALSE, split=FALSE)
prediction <- predict(model_train, data_test)
eval_model(prediction, data_test)
