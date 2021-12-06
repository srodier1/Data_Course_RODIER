library(moments)
library(dplyr)

df <- read.csv("merged_data.csv")

names(df)
var <- select(df, -c(entity, total_pop, year, continent))
col <- data.frame(names(var))

skew <- data.frame(col, apply(var, 2, skewness, na.rm = TRUE))
names(skew)
beep <- filter(skew, !between(skew$apply.var..2..skewness..na.rm...TRUE., -0.6, 0.6))

df %>% 
  mutate()

norm <- df %>% select(unique(beep$col)) %>% 
  apply(2, sqrt)

for (i in var){
  a <- skewness(i, na.rm = TRUE)
  data.frame(a)
}

 