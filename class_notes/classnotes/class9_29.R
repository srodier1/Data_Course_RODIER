library(tidyverse) 
library(readxl)
library(janitor)
#data should not be "wide" (varialbe name on the left and a list running right to left)
#it should be "long" (variable names on top )
df <- read_xlsx("./Data/wide_data_example.xlsx")
colnames(df) <- make_clean_names(colnames(df))


df$treatment_1[df$treatment_1 == "?"] <- NA #takes out any question marks and makes them NA
df$treatment_1 <- as.numeric(df$treatment_1) #inserting NA makes your data categorical, this line makes our data numeric

df %>%
  pivot_longer(cols = c("treatment_1", "treatment_2"), #pivot_longer puts your data
               names_to = "treatment",
               values_to = "Brain_Activity")


