library(moments)
library(dplyr)
library(tidyverse)

df <- read.csv("merged_data.csv")


LY <- df %>% 
  select(life_expectancy, year) %>% 
  na.omit()

df %>% 
  filter(year %in% (2000:2019))
