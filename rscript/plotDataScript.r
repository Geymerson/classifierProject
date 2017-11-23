if(!require(ggplot2)){
  install.packages("ggplot2")
  library(ggplot2)
}

setwd("/home/geymerson/Documents/ecom_089_2017_1/classifierProject/rscript/")
rd <- read.table("../resources/dataFilePath.txt", header = FALSE)
data <- read.csv(as.character(rd$V1))

temp <- ggplot(data, aes(x = label, fill = label)) +
  geom_bar()
ggsave("../plots/data.jpg")
