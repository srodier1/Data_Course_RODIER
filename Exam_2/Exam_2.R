library(dplyr)
library(ggplot2)
library(tidyverse)
library(zoo)
options(scipen = 999)
list.files("Exam_2", full.names = TRUE)
#I.
land_data <- read.csv("Exam_2/landdata-states.csv")

ggplot(land_data, aes(x = Date, y = Land.Value, color = region)) + 
  geom_smooth() +
  xlab(element_text("Year"))+
  ylab(element_text("Land Value(USD)"))
  
#II.
filter(land_data, is.na(land_data$region))

#III.
unicef <- read.csv("Exam_2/unicef-u5mr.csv" )
unicef <- unicef %>%
  pivot_longer(cols = starts_with("U5MR."),  names_prefix = "U5MR.",
                 names_to = "Year", names_transform = list(Year = as.integer),
               values_to = "U5MR", )
#IV.
unicef %>% 
  ggplot(aes(x = Year, y = U5MR, color = Continent )) +
  geom_point(size = 2)+
  ylab(element_text("Mortality Rate")) +
  theme(panel.grid.major = element_blank()) 

glimpse(unicef)

