library(tidyverse)
library(dplyr)
library(patchwork)
mam <- read.csv("../Data_Course_Rodier/mammals.csv")
summary(mam)
mam %>%
  
  filter(brain_wt < 1000) %>%  ## This graph makes a little more sense without outliers, hence the filtering of outliers that skew the visuals
  ggplot(aes(x=brain_wt, y=total_sleep))+
  geom_point()+
  geom_smooth(method="lm")

mam %>%
  filter(body_wt < 1000) %>%
  ggplot(aes(x= body_wt, y = total_sleep)) +
  geom_point() + 
  facet_wrap(~predation)

mam %>%
  mutate(pred = as.character(predation)) %>%   #I did this because how likely they are to be eaten is categorical data. 
  ggplot(aes(x=danger, y =total_sleep, color = pred)) +    #I may convert some of the data from numerical to categorical and then add additional variables. 
  geom_point()  

mutate(pred = as.character(predation)) %>%


mam %>%
  mutate(pred = as.character(predation)) %>%
  ggplot(aes(x=pred, y = danger)) +
  geom_point()

mam %>%
  group_by(predation) %>%
  summarize(N=n(),mean_total_slp = mean(total_sleep))



##next try the summarize method

##kaggle analysis. and other things to get ideas

