library(tidyverse)
csv_files <- list.files(path = "Data", recursive = TRUE pattern = ".csv")
length(csv_files)
df <- read.csv("Data/wingspan_vs_mass.csv")
df %>%
  head(5)
dat<-list.files(path = "Data", recursive = TRUE, pattern = "^b",full.names = TRUE)
read.csv(dat[1:3])
for(i in 1:3) {
  loop <- read.csv(dat[i])
  print(head(loop,5))
}
for (i in 1:29) {
  poop <- read.csv(csv_files[i])
  print(head(poop,5))
}

