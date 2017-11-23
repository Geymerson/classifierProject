if(!require(OneR)){
  install.packages("OneR")
  library(OneR)
}

setwd("/home/geymerson/Documents/ecom_089_2017_1/classifierProject/rscript/")

#Get the input data path
rd <- read.table("../resources/dataFilePath.txt", header = FALSE)
data <- read.csv(as.character(rd$V1))

# Load the trainning model
if(file.exists("../robjects/model_train.rda")) {  
  load("../robjects/model_train.rda")
} else {
  print("The model could not be found.")
}

# Generate predictions based on the model
# and save prediction log
sink("../rlogs/prediction.log", append=FALSE, split=FALSE)
prediction <- predict(model_train, data)
for(i in 1:length(prediction)) {
  print(as.character(prediction[i]))
}
